import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orionstar_robot/robot_status/play_video_screen.dart';

import 'package:video_player/video_player.dart';

class RobotBlinknLookUpState extends StatefulWidget {
  const RobotBlinknLookUpState({Key? key}) : super(key: key);

  @override
  State<RobotBlinknLookUpState> createState() => _BlinknLookUpScreenState();
}

class _BlinknLookUpScreenState extends State<RobotBlinknLookUpState> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset("assets/videos/mini_emo_blinknlookup.mp4");

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
    return RobotPlayVideoState(videoController: _controller, videoPath: "assets/videos/mini_emo_blinknlookup.mp4", robotVideoType: RobotVideoType.local);

  }
}