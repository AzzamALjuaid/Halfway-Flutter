import 'dart:io';
import 'package:firebase_chat/common/utils/security.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_chat/common/entities/entities.dart';
import 'package:firebase_chat/common/store/store.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';


class ChatController extends GetxController {
  ChatController();
  ChatState state = ChatState();
  var doc_id = null;
  final textController = TextEditingController();
  ScrollController msgScrolling = ScrollController();
  FocusNode contentNode = FocusNode();
  final user_id = UserStore.to.token;
  final db = FirebaseFirestore.instance;
  var listener;

  File? _photo;
  final ImagePicker _picker = ImagePicker();

  Future imgFromGallery() async {

    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if(pickedFile!=null){
      _photo = File(pickedFile.path);
      uploadFile();
    }else{
      print("No image selected");
    }
  }

  Future getImgUrl(String name) async {
    final spaceRef = FirebaseStorage.instance.ref("chat").child(name);
    var str = await spaceRef.getDownloadURL();
    return str??"";
  }

  sendImageMessage(String url) async {
    final content = Msgcontent(
      uid: user_id,
      content: url,
      type: "image",
      addtime: Timestamp.now()
    );

    await db.collection("message").doc(doc_id).collection("msglist").
    withConverter(
        fromFirestore: Msgcontent.fromFirestore,
        toFirestore: (Msgcontent msgcontent, options)=> msgcontent.toFirestore())
        .add(content).then((DocumentReference doc) {
      print("Document snapshot added with id, ${doc.id}");
      textController.clear();
      Get.focusScope?.unfocus();
    });
    await db.collection("message").doc(doc_id).update({
      "last_msg":" [image] ",
      "last_time":Timestamp.now()
    }
    );
  }


  Future uploadFile()async{
    if(_photo==null) return;
    final fileName = getRandomString(15)+extension(_photo!.path);
    try{
      final ref = FirebaseStorage.instance.ref("chat").child(fileName);

      ref.putFile(_photo!).snapshotEvents.listen((event) async {
        switch(event.state){
          case TaskState.running:
            break;

          case TaskState.paused:
            break;
          case TaskState.success:
            String imgUrl = await getImgUrl(fileName);
            sendImageMessage(imgUrl);
            break;
        }

      });

    }catch(e){
      print("There's an error $e");
    }
  }


  @override
  void onInit(){
    super.onInit();
    var date= Get.parameters;
    doc_id = date['doc_id'];
    state.to_uid.value = date['to_uid']??"";
    state.to_name.value = date['to_name']??"";
    state.to_avatar.value = date['to_avatar']??"";
  }

  sendMessage() async {
    String sendContent = textController.text;
    final content = Msgcontent(
      uid: user_id,
      content: sendContent,
      type: "text",
      addtime: Timestamp.now()
    );
    await db.collection("message").doc(doc_id).collection("msglist").
    withConverter(
        fromFirestore: Msgcontent.fromFirestore,
        toFirestore: (Msgcontent msgcontent, options)=> msgcontent.toFirestore())
    .add(content).then((DocumentReference doc) {
      print("Document snapshot added with id, ${doc.id}");
      textController.clear();
      Get.focusScope?.unfocus();
    });
    await db.collection("message").doc(doc_id).update({
      "last_msg":sendContent,
      "last_time":Timestamp.now()
    }
    );
  }
  @override
  void onReady(){
    super.onReady();
    var messages = db.collection("message").doc(doc_id).collection("msglist")
    .withConverter(
        fromFirestore: Msgcontent.fromFirestore,
        toFirestore: (Msgcontent msgcontent , options)=>msgcontent.toFirestore()
    ).orderBy("addtime", descending: false);
    state.msgcontentList.clear();
    listener = messages.snapshots().listen((event) {
      for(var change in event.docChanges){
        switch(change.type){
          case DocumentChangeType.added:
          if(change.doc.data()!=null){
            state.msgcontentList.insert(0, change.doc.data()!);
          }
          break;
          case DocumentChangeType.modified:
            break;

          case DocumentChangeType.removed:
            break;
        }
      }

    },
    onError: (error)=>print("Listen failed: $error")
    );


    getLocation();
  }

  getLocation() async {
    try{
      var user_loaction = await db.collection("users").where("id", isEqualTo: state.to_uid.value)
          .withConverter(
          fromFirestore: UserData.fromFirestore,
          toFirestore: (UserData userdata, options)=>userdata.toFirestore()).get();
      var location = user_loaction.docs.first.data().location;
      if(location!=null){
      state.to_location.value=location??"unknown";
      }
    }catch(e){
      print("we have error $e");
    }
  }


  @override
  void dispose(){
    msgScrolling.dispose();
    listener.cancel();
    super.dispose();
  }

}