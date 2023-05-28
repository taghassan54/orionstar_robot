import 'package:get/get.dart';

import 'video_controller_logic.dart';

class VideoControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VideoControllerLogic());
  }
}
