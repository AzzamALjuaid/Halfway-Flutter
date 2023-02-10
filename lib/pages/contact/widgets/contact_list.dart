import 'package:firebase_chat/common/entities/entities.dart';
import 'package:firebase_chat/pages/contact/controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../common/values/colors.dart';


class ContactList extends GetView<ContactController> {
  const ContactList({Key? key}) : super(key: key);

  Widget BuildListItem(UserData item){
    return Container(
      padding: EdgeInsets.only(top: 10.w, left: 10.w, right: 10.w),
      child: InkWell(
        onTap: (){
          if(item.id!=null) {
            controller.goChat(item);
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(top: 0.w, left: 0.w, right: 15.w),
              child: SizedBox(
                width: 54.w,
                height: 54.w,
                child: CachedNetworkImage(imageUrl:"${item.photourl}"),
              ),
            ),
            Container(
              width: 250.w,
              padding: EdgeInsets.only(top: 15.w, left: 0.w, right: 0.w, bottom: 0.w),
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: 1, color: Color(0xffe5efe5))
                  )
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 200.w,
                    height: 42.w,
                    child: Text(
                      item.name??"",
                      style: TextStyle(
                          fontFamily: "Avenir",
                          fontWeight: FontWeight.bold,
                          color: AppColors.thirdElement,
                          fontSize: 17.sp
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Obx(
        ()=>CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.symmetric(vertical: 0.w, horizontal: 0.w),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                        (context , index){
                      var item = controller.state.contactList[index];
                      return BuildListItem(item);
                    },
                    childCount: controller.state.contactList.length
                ),
              ),)
          ],
        )
    );
  }
}
