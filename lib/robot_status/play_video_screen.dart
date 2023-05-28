import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orionstar_robot/robot_status/state_video_controller/video_controller_logic.dart';

import 'package:video_player/video_player.dart';

enum RobotVideoType { network, local }

class RobotPlayVideoState extends GetView<VideoControllerLogic> {
  final String videoPath;
  final RobotVideoType robotVideoType;
  final VideoPlayerController videoController;

  const RobotPlayVideoState(
      {Key? key,
      required this.videoController,
      required this.videoPath,
      required this.robotVideoType})
      : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: Get.width,
        height: Get.height,
        child: GestureDetector(
          onTap: () {
            // Get.back();
          },
          child: VideoPlayer(videoController),
        ),
      ),
    );
  }
}
