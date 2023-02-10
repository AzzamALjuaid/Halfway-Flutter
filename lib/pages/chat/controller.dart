import 'package:firebase_chat/common/entities/entities.dart';
import 'package:firebase_chat/common/routes/names.dart';
import 'package:firebase_chat/common/widgets/toast.dart';
import 'package:firebase_chat/pages/welcome/state.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../common/store/user.dart';
import 'index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ChatController extends GetxController {
  ChatController();
  ChatState state = ChatState();
  var doc_id = null;

  @override
  void onInit(){
    super.onInit();
    var date= Get.parameters;
    doc_id = date['doc_id'];
    state.to_uid.value = date['to_uid']??"";
    state.to_name.value = date['to_name']??"";
    state.to_avatar.value = date['to_avatar']??"";
  }
}