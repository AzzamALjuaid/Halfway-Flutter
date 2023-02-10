import 'package:firebase_chat/common/values/colors.dart';
import 'package:firebase_chat/common/values/shadows.dart';
import 'package:firebase_chat/common/widgets/app.dart';
import 'package:firebase_chat/common/widgets/button.dart';
import 'package:firebase_chat/pages/contact/controller.dart';
import 'package:firebase_chat/pages/contact/widgets/contact_list.dart';
import 'package:firebase_chat/pages/sign_in/controller.dart';
import 'package:firebase_chat/pages/welcome/controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dots_indicator/dots_indicator.dart';

class ContactPage extends GetView<ContactController> {
  const ContactPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    AppBar _buildAppBar(){
      return transparentAppBar(
        title: Text(
       "Contact",
        style: TextStyle(
          color: AppColors.primaryBackground,
          fontSize: 18.sp,
          fontWeight: FontWeight.w600
        ),
        )
      );
    }

    return Scaffold(
    appBar: _buildAppBar(),
      body: ContactList(),

    );
  }
}
