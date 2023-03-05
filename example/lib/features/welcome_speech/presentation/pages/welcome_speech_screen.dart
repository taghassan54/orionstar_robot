import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:orionstar_robot_example/features/welcome_speech/presentation/controllers/welcome_controller.dart';
import 'package:orionstar_robot_example/generated/assets.dart';
import 'package:orionstar_robot_example/routes/app_routes.dart';
import 'package:video_player/video_player.dart';

class WelcomeScreen extends GetView<WelcomeController> {
  const WelcomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return controller.obx((state) => Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        width: Get.width,
        height: Get.height,
        child: GestureDetector(
          onTap: () {
            // Get.offAndToNamed(AppRoutes.welcomeSpeechRoute);
          },
          child: VideoPlayer(controller.videoController),
        ),
      ),
    ));
  }
}
