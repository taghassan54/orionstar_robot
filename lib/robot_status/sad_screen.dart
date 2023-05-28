import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orionstar_robot/robot_status/play_video_screen.dart';

import 'package:video_player/video_player.dart';

class RobotSadState extends StatefulWidget {
  const RobotSadState({Key? key}) : super(key: key);

  @override
  State<RobotSadState> createState() => _SadScreenState();
}

class _SadScreenState extends State<RobotSadState> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset("assets/videos/sad_video.mp4");

    _controller.addListener(() {
      if(mounted) {
        setState(() {});
      }
    });
    _controller.setLooping(true);
    _controller.initialize().then((_) => mounted ? setState(() {}) : null);
    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RobotPlayVideoState(videoController: _controller, videoPath: "assets/videos/sad_video.mp4", robotVideoType: RobotVideoType.local);

  }
}
