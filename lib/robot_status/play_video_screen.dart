import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:video_player/video_player.dart';

enum RobotVideoType { network, local }

class RobotPlayVideoState extends StatefulWidget {
  final String videoPath;
  final RobotVideoType robotVideoType;
  VideoPlayerController videoController;

  RobotPlayVideoState(
      {Key? key,
      required this.videoController,
      required this.videoPath,
      required this.robotVideoType})
      : super(key: key);

  @override
  State<RobotPlayVideoState> createState() => _RobotPlayVideoStateState();
}

class _RobotPlayVideoStateState extends State<RobotPlayVideoState> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {

      // widget.videoController.dispose();

    super.dispose();
  }

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
          child: VideoPlayer(widget.videoController),
        ),
      ),
    );
  }
}