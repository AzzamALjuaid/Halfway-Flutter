import 'dart:async';
import 'package:firebase_chat/common/entities/entities.dart';
import 'package:firebase_chat/common/values/colors.dart';
import 'package:firebase_chat/pages/map/controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../common/widgets/app.dart';

class MapPage extends GetView<MapController> {

  const MapPage({Key? key}) : super(key: key);

  AppBar _buildAppbar() {
    return transparentAppBar(
        title: Text(
          "Map",
          style: TextStyle(
              color: AppColors.primaryBackground,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600),
        ));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: _buildAppbar(),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(37.43296265331129, 122.08832357078792),
        ),
      )
    );
  }
}
