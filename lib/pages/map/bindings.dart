import 'package:get/get.dart';

import 'controller.dart';
class MapBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<MapController>(()=>MapController());
  }

}