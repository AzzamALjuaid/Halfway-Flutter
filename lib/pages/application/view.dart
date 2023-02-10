import 'package:firebase_chat/common/values/colors.dart';
import 'package:firebase_chat/common/values/shadows.dart';
import 'package:firebase_chat/common/widgets/button.dart';
import 'package:firebase_chat/pages/contact/index.dart';
import 'package:firebase_chat/pages/sign_in/controller.dart';
import 'package:firebase_chat/pages/welcome/controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dots_indicator/dots_indicator.dart';

import 'controller.dart';

class ApplicationPage extends GetView<ApplicationController> {
  const ApplicationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _buildPageView(){
      return PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: controller.pageController,
        onPageChanged: controller.handlePageChanged,
        children: [
          Center(child: Text('Chat')),
          ContactPage(),
          Center(child: Text('profile'))
        ],
      );
    }

    Widget _buildBottomNavigationBar(){
      return Obx(
          ()=>BottomNavigationBar(
              items:controller.bottomTabs,
            currentIndex: controller.state.page,
            type: BottomNavigationBarType.fixed,
            onTap: controller.handleNavBarTap,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            unselectedItemColor: AppColors.tabBarElement,
            selectedItemColor: AppColors.thirdElementText,
          )
      );
    }


    return Scaffold(
        body: _buildPageView(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }
}
