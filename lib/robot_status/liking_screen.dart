import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orionstar_robot/generated/assets.dart';

import 'package:video_player/video_player.dart';

class RobotLikingState extends StatefulWidget {
  const RobotLikingState({Key? key}) : super(key: key);

  @override
  State<RobotLikingState> createState() => _LikingScreenState();
}

class _LikingScreenState extends State<RobotLikingState> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(Assets.videosLikingVideo);

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
