import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orionstar_robot/generated/assets.dart';
import 'package:orionstar_robot/robot_status/play_video_screen.dart';
import 'package:orionstar_robot/robot_status/state_video_controller/video_controller_logic.dart';

import 'package:video_player/video_player.dart';

class RobotBlinknLookUpState extends StatelessWidget {
   RobotBlinknLookUpState({super.key}){
     if(!Get.isRegistered<VideoControllerLogic>()){
       Get.lazyPut(() => VideoControllerLogic());
     }
     VideoControllerLogic controllerLogic= Get.find<VideoControllerLogic>();
     controllerLogic.videoPath=Assets.videosMiniEmoBlinknlookup;
     controllerLogic.update();
     controllerLogic.playVideo();
   }


  @override
  Widget build(BuildContext context) {
    return RobotPlayVideoState(videoController: Get.find<VideoControllerLogic>().videoPlayerController, videoPath: Assets.videosMiniEmoBlinknlookup, robotVideoType: Get.find<VideoControllerLogic>().robotVideoType);

  }
}
