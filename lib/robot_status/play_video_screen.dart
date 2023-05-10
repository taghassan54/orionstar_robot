import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:video_player/video_player.dart';

enum RobotVideoType { network, local }

class RobotPlayVideoState extends StatefulWidget {
  final String videoPath;
  final RobotVideoType robotVideoType;
  VideoPlayerController? videoController;

  RobotPlayVideoState(
      {Key? key,
      this.videoController,
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

    if (widget.videoController != null) {
      if (widget.videoController!.value.isInitialized) {
        widget.videoController!.pause();
      }
    }else{
      VideoPlayerController? videoPlayerController;
      setState(() {
        widget.videoController=videoPlayerController;
      });
    }
    switch (widget.robotVideoType) {
      case RobotVideoType.network:
        widget.videoController =
            VideoPlayerController.network(widget.videoPath);
        break;
      case RobotVideoType.local:
        widget.videoController = VideoPlayerController.asset(widget.videoPath);
        break;
    }

    widget.videoController?.addListener(() {
      if(mounted) {
        setState(() {});
      }
    });

    widget.videoController?.setLooping(true);
    widget.videoController?.initialize().then((_) => setState(() {}));
    widget.videoController?.play();
  }

  @override
  void dispose() {
    widget.videoController?.dispose();
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
          child:widget.videoController!=null? VideoPlayer(widget.videoController!):const Center(child: Text("No Video Controller Found !")),
        ),
      ),
    );
  }
}
