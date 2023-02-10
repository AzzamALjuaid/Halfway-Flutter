import 'package:firebase_chat/common/entities/entities.dart';
import 'package:firebase_chat/common/routes/names.dart';
import 'package:firebase_chat/common/widgets/toast.dart';
import 'package:firebase_chat/pages/welcome/state.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import '../../common/store/user.dart';
import '../../../common/store/user.dart';
import 'index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


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
    ).orderBy("addtime", descending: true);
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
  }

  @override
  void dispose(){
    msgScrolling.dispose();
    listener.cancel();
    super.dispose();
  }

}