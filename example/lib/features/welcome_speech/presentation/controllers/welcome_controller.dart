import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:orionstar_robot_example/core/utils/robot.dart';
import 'package:orionstar_robot_example/features/welcome_speech/presentation/controllers/welcome_get_state.dart';
import 'package:orionstar_robot_example/generated/assets.dart';
import 'package:orionstar_robot_example/injection.dart';
import 'package:orionstar_robot_example/routes/app_routes.dart';
import 'package:orionstar_robot/logger_helper.dart';
import 'package:orionstar_robot/models/person_res_data_model.dart';
import 'package:orionstar_robot/orionstar_robot.dart';
import 'package:video_player/video_player.dart';
import 'package:orionstar_robot/models/GoogleAnswerTextModel.dart';

class WelcomeController extends GetxController
    with StateMixin<WelcomeGetState> {
  final _orionstarRobot = OrionstarRobot();

  VideoPlayerController videoController =
      VideoPlayerController.asset(Assets.welcomeVideo);
  Timer? timer;
  bool petrolStatus = false, startGreeting = false,speeching=false;
  GoogleAnswerTextModel? googleAnswerText;

  @override
  void onInit() async {
    payFullScreenVideo(Assets.welcomeVideo);

    await _orionstarRobot.initRobot();

    petrolStatus = true;
    update();
    checkForPerson();

    // startCruise();
    change(null, status: RxStatus.success());
    super.onInit();
  }

  checkForPerson() {

    const duration = Duration(milliseconds: 1000);
    timer = Timer.periodic(duration, (Timer timer) async {
      if(!speeching) {
        voiceListener();
      }
      PersonResDataModel? person = await _orionstarRobot.getPerson();
      LoggerHelper.info("person $person");
      if (person != null) {
        if (petrolStatus == true) {
          petrolStatus = false;

          // await Future.delayed(Duration.zero,()async => await _orionstarRobot.stopCruise(),);
          await _orionstarRobot.stopFocusFollow();
          await _orionstarRobot.startFocusFollow();

          if (!startGreeting) {
            greet();
          }
        }
      } else {
        if (kDebugMode) {
          LoggerHelper.info("petrolStatus $petrolStatus");
        }
        if (petrolStatus == false) {
          petrolStatus = true;
          // startCruise();
          update();

        }
      }
    });
  }

  @override
  void onClose() {
    videoController.dispose();

    super.onClose();
  }

  void payFullScreenVideo(String video) {
    videoController.pause();
    videoController = VideoPlayerController.asset(video);

    videoController.addListener(() {
      update();
    });
    videoController.setLooping(true);
    videoController.initialize().then((_) => update());
    videoController.play();
    update();
  }

  greet() async {
    startGreeting = true;
    update();

    payFullScreenVideo(Assets.speechVideo);

    _orionstarRobot.playText(
        textToPlay:
            "hi i'm smart service robot , you can ask me what i can do ?");

    Future.delayed(
      const Duration(seconds: 6),
      () {
        timer?.cancel();

        Get.toNamed(AppRoutes.mainDashboardRoute);
        // payFullScreenVideo(Assets.welcomeVideo);
      },
    );
    startGreeting = false;
    update();
  }

  voiceListener() async {
    final String? requestResponse = await _orionstarRobot.getRequestResponse();
    if (requestResponse != null) {
      googleAnswerText =
          GoogleAnswerTextModel.fromJson(jsonDecode(requestResponse));
      if (googleAnswerText != null && googleAnswerText!.answerTextPlay!) {
        payFullScreenVideo(Assets.speechVideo);

        LoggerHelper.debug("intent = ${googleAnswerText?.intent}");
        if (googleAnswerText?.intent == "guide&guide") {
          String placeName =
              "${googleAnswerText?.nlpData?.detail?.first.slots?.destination?.first.value}";
          LoggerHelper.debug(
              "placeName ${googleAnswerText?.nlpData?.detail?.first.slots?.destination?.first.value}");

          if (placeName != "null") {
            _orionstarRobot.startNavigation(placeName: placeName);
          }
          speeching=true;
          update();
        await  _orionstarRobot.playText(textToPlay: "i'll take you to $placeName");
        } else {
          speeching=true;
          update();
          await _orionstarRobot.playText(
              textToPlay: "${googleAnswerText?.answerText}");
        }
        Future.delayed(
          const Duration(seconds: 6),
              () {
            payFullScreenVideo(Assets.welcomeVideo);
          },
        );
      }
      _orionstarRobot.resetRequestResponse();
      speeching=false;

      update();
      //
    }
  }

   startCruise()async {

     // Future.delayed(Duration(seconds: 2),() => _orionstarRobot.playText(textToPlay: "i'm starting a petrol "),);
     Future.delayed(
       const Duration(seconds: 3),
           () async => await _orionstarRobot.startCruise(),
     );
   }
}
