import 'package:get/get.dart';
import 'package:orionstar_robot_example/features/welcome_speech/presentation/controllers/welcome_controller.dart';



class WelcomeControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WelcomeController());
  }
}