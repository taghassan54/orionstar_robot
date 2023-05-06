import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:video_player/video_player.dart';

enum RobotVideoType{network,local}

class RobotPlayVideoState extends StatefulWidget {
  final String videoPath;
  final RobotVideoType robotVideoType;
  const RobotPlayVideoState({Key? key,required this.videoPath,required this.robotVideoType}) : super(key: key);

  @override
  State<RobotPlayVideoState> createState() => _RobotPlayVideoStateState();
}

class _RobotPlayVideoStateState extends State<RobotPlayVideoState> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoPath);

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
