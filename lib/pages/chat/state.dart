import 'package:firebase_chat/common/entities/entities.dart';
import 'package:get/get.dart';

class ChatState{
RxList<Msgcontent> msgcontentList = <Msgcontent>[].obs;
var to_uid = "".obs;
var to_name = "".obs;
var to_avatar = "".obs;
var to_location = "unknown".obs;
}