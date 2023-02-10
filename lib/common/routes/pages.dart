
import 'package:flutter/material.dart';
import 'package:firebase_chat/common/middlewares/middlewares.dart';

import 'package:get/get.dart';

import 'package:firebase_chat/pages/sign_in/index.dart';
import 'package:firebase_chat/pages/welcome/index.dart';
import 'package:firebase_chat/pages/application/index.dart';
import 'package:firebase_chat/pages/contact/index.dart';
import 'package:firebase_chat/pages/chat/index.dart';
import 'routes.dart';

class AppPages {
  static const INITIAL = AppRoutes.INITIAL;
  static const APPlication = AppRoutes.Application;
  static final RouteObserver<Route> observer = RouteObservers();
  static List<String> history = [];

  static final List<GetPage> routes = [

    GetPage(
      name: AppRoutes.INITIAL,
      page: () => const WelcomePage(),
      binding: WelcomeBinding(),
      middlewares: [
        RouteWelcomeMiddleware(priority: 1)
      ]
    ),
    GetPage(
      name: AppRoutes.SIGN_IN,
      page: () => const SignInPage(),
      binding: SignInBinding(),
    ),

    // check if needed to login or not
    GetPage(
      name: AppRoutes.Application,
      page: () => ApplicationPage(),
      binding: ApplicationBinding(),
      middlewares: [
        //RouteAuthMiddleware(priority: 1),
      ],
    ),


    // 最新路由
    // 首页
    GetPage(name: AppRoutes.Contact,
        page: () => ContactPage(),
        binding: ContactBinding()),
  /*
    GetPage(name: AppRoutes.Message, page: () => MessagePage(), binding: MessageBinding()),

    GetPage(name: AppRoutes.Me, page: () => MePage(), binding: MeBinding()),
    */
    GetPage(name: AppRoutes.Chat, page: () => ChatPage(), binding: ChatBinding()),
/*
    GetPage(name: AppRoutes.Photoimgview, page: () => PhotoImgViewPage(), binding: PhotoImgViewBinding()),*/
  ];




}
