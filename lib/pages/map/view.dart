import 'package:firebase_chat/common/values/colors.dart';
import 'package:firebase_chat/common/values/shadows.dart';
import 'package:firebase_chat/common/widgets/button.dart';
import 'package:firebase_chat/pages/map/controller.dart';
import 'package:firebase_chat/pages/sign_in/controller.dart';
import 'package:firebase_chat/pages/welcome/controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dots_indicator/dots_indicator.dart';

class MapPage extends GetView<MapController> {
  const MapPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Center(
      child: Column(
        children: [

        ],
      ),
    )
    );
  }
}
