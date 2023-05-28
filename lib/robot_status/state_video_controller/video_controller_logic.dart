import 'package:get/get.dart';
import 'package:orionstar_robot/robot_status/play_video_screen.dart';
import 'package:video_player/video_player.dart';

import 'video_controller_state.dart';

class VideoControllerLogic extends GetxController with StateMixin<VideoControllerState>{

  VideoPlayerController videoPlayerController =
  VideoPlayerController.asset("assets/customer_videos/res.mp4");
  RobotVideoType robotVideoType = RobotVideoType.local;
  String videoPath = "assets/customer_videos/res.mp4";

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  void playVideo() {
    if (videoPlayerController.value.isInitialized) {
      videoPlayerController.pause();
    }

    switch (robotVideoType) {
      case RobotVideoType.network:
        videoPlayerController = VideoPlayerController.network(videoPath);
        break;
      case RobotVideoType.local:
        videoPlayerController = VideoPlayerController.asset(videoPath);
        break;
    }

    videoPlayerController.addListener(() {
      update();
    });

    videoPlayerController.setLooping(true);
    videoPlayerController.initialize().then((_) => update());
    videoPlayerController.play();
    update();
  }

}
