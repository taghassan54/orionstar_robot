import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orionstar_robot/robot_status/play_video_screen.dart';

import 'package:video_player/video_player.dart';

class RobotTakeaPhotoState extends StatefulWidget {
  const RobotTakeaPhotoState({Key? key}) : super(key: key);

  @override
  State<RobotTakeaPhotoState> createState() => _TakeaPhotoScreenState();
}

class _TakeaPhotoScreenState extends State<RobotTakeaPhotoState> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset("assets/videos/mini_emo_takeaphoto.mp4");

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
    return RobotPlayVideoState(videoController: _controller, videoPath: "assets/videos/mini_emo_takeaphoto.mp4", robotVideoType: RobotVideoType.local);

  }
}