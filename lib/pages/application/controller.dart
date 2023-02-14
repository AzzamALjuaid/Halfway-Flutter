import 'package:firebase_chat/common/entities/entities.dart';
import 'package:firebase_chat/common/routes/names.dart';
import 'package:firebase_chat/common/values/colors.dart';
import 'package:firebase_chat/common/widgets/toast.dart';
import 'package:firebase_chat/pages/welcome/state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'index.dart';

class ApplicationController extends GetxController {
  final state = ApplicationState();
  ApplicationController();

  late final List<String> tabTitles;
  late final PageController pageController;
  late final List<BottomNavigationBarItem> bottomTabs;

  void handlePageChanged(int index){
    state.page = index;

  }

  void handleNavBarTap(int index){
    pageController.jumpToPage(index);
  }


  @override
  void onInit(){
    super.onInit();
    tabTitles = ['Map', 'Chat', 'Contact' , 'Profile'];
    bottomTabs = <BottomNavigationBarItem>[
      const BottomNavigationBarItem(
          icon: Icon(Icons.map_rounded,
            color: AppColors.thirdElementText,
          ),
          activeIcon: Icon(Icons.map_rounded,
            color: AppColors.secondaryElementText,

          ),
          label: 'Map',
          backgroundColor: AppColors.primaryBackground
      ),
      const BottomNavigationBarItem(
          icon: Icon(Icons.message,
          color: AppColors.thirdElementText,
          ),
        activeIcon: Icon(Icons.message,
          color: AppColors.secondaryElementText,

        ),
      label: 'Chat',
    backgroundColor: AppColors.primaryBackground
    ),
      const BottomNavigationBarItem(
          icon: Icon(Icons.contact_page,
            color: AppColors.thirdElementText,
          ),
          activeIcon: Icon(Icons.contact_page,
            color: AppColors.secondaryElementText,

          ),
          label: 'Contact',
          backgroundColor: AppColors.primaryBackground
      ),
      const BottomNavigationBarItem(
          icon: Icon(Icons.person,
            color: AppColors.thirdElementText,
          ),
          activeIcon: Icon(Icons.person,
            color: AppColors.secondaryElementText,

          ),
          label: 'Profile',
          backgroundColor: AppColors.primaryBackground
      )

  ];
    pageController = PageController(initialPage: state.page);
  }

  @override
  void dispose(){
    pageController.dispose();
    super.dispose();
  }

}