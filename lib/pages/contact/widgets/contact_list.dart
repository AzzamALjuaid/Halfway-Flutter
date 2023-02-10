import 'package:firebase_chat/pages/contact/controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class ContactList extends GetView<ContactController> {
  const ContactList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
            padding: EdgeInsets.symmetric(vertical: 0.w, horizontal: 0.w),
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate(
              (context , index){
                var item = controller.state.contactList[index];
                return Container();
              },
            childCount: controller.state.contactList.length
          ),
        ),)
      ],
    );
  }
}
