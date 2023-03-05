import 'package:get/get.dart';
import 'package:orionstar_robot_example/features/welcome_speech/presentation/controllers/welcome_controller.dart';

import 'main_screen_controller.dart';



class MainScreenControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainScreenController());
  }
}