import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:video_player/video_player.dart';

class RobotLookLeftRightState extends StatefulWidget {
  const RobotLookLeftRightState({Key? key}) : super(key: key);

  @override
  State<RobotLookLeftRightState> createState() => _LookLeftnRightScreenState();
}

class _LookLeftnRightScreenState extends State<RobotLookLeftRightState> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset("assets/videos/mini_emo_lookleftnright.mp4");

    _controller.addListener(() {
      setState(() {});
    });
    _controller.setLooping(true);
    _controller.initialize().then((_) => setState(() {}));
    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
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
            Get.back();
          },
          child: VideoPlayer(_controller),
        ),
      ),
    );
  }
}