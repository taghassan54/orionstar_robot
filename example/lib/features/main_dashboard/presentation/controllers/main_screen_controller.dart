import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:orionstar_robot_example/core/utils/robot.dart';
import 'package:orionstar_robot_example/features/main_dashboard/presentation/controllers/main_screen_stats.dart';
import 'package:orionstar_robot_example/generated/assets.dart';
import 'package:orionstar_robot_example/injection.dart';
import 'package:orionstar_robot/logger_helper.dart';
import 'package:orionstar_robot/models/GoogleAnswerTextModel.dart';
import 'package:orionstar_robot/orionstar_robot.dart';
import 'package:video_player/video_player.dart';

class MainScreenController extends GetxController with StateMixin<MainScreenState> {
  final orionstarRobot =OrionstarRobot();
  VideoPlayerController videoController =
  VideoPlayerController.asset(Assets.welcomeVideo);
  Timer? mainTimer;
  bool petrolStatus = false, startGreeting = false,speeching=false;
  GoogleAnswerTextModel? googleAnswerText;
  List<String>? points;
  List resultMesseges = [];
  @override
  void onInit()async {
    await orionstarRobot.initRobot();
    playTimer();
   points=await orionstarRobot.robotGetLocation();

    change(null,status: RxStatus.success());
    super.onInit();
  }
  @override
  void onClose() {
    videoController.dispose();

    super.onClose();
  }
  playTimer() {
    const duration = Duration(milliseconds: 1000);
    mainTimer = Timer.periodic(duration, (Timer timer) async {

        // voiceListener();
      final String? result = await orionstarRobot.checkStatus();
      if (!result!.startsWith("personResData")) {
        if (resultMesseges.isNotEmpty) {
          if (resultMesseges.last != result) {

              resultMesseges.add(result);

          }
        } else {

            resultMesseges.add(result);

        }
      }
      update();
    });
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

  queryByText(String text)=>  orionstarRobot.queryByText(text: text);

  voiceListener() async {
    final String? requestResponse = await orionstarRobot.getRequestResponse();
    if (requestResponse != null) {
      googleAnswerText =
          GoogleAnswerTextModel.fromJson(jsonDecode(requestResponse));
      if (googleAnswerText != null && googleAnswerText!.answerTextPlay!) {
        // payFullScreenVideo(Assets.speechVideo);
        mainTimer?.cancel();
        Future.delayed(const Duration(seconds: 15),() => mainTimer?.reactive,);
        LoggerHelper.debug("intent = ${googleAnswerText?.intent}");
        if (googleAnswerText?.intent == "guide&guide") {
          String placeName =
              "${googleAnswerText?.nlpData?.detail?.first.slots?.destination?.first.value}";
          LoggerHelper.debug(
              "placeName ${googleAnswerText?.nlpData?.detail?.first.slots?.destination?.first.value}");

          if (placeName != "null") {

            orionstarRobot.startNavigation(placeName: placeName);

          }
          // await  orionstarRobot.playText(textToPlay: "i'll take you to $placeName");

          speeching=true;
          update();
        } else {
          speeching=true;
          update();
          await orionstarRobot.playText(
              textToPlay: "${googleAnswerText?.answerText}");
        }
        Future.delayed(
          const Duration(seconds: 6),
              () {
            payFullScreenVideo(Assets.welcomeVideo);
          },
        );
      }
      orionstarRobot.resetRequestResponse();
      speeching=false;

      update();
      //
    }
  }

  goTo(String placeName)async{
    await Future.delayed(
      const Duration(seconds: 2),
          () async => await orionstarRobot.startNavigation(placeName: placeName),
    );
  }


}