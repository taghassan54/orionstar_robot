import 'dart:async';

import 'package:orionstar_robot/models/person_res_data_model.dart';
import 'package:orionstar_robot/orionstar_robot.dart';

class RobotHelper {

  static final orionStarRobot = OrionstarRobot();
  static StreamController<dynamic> streamController = StreamController<dynamic>();
  static Future<String?> initRobot() async {
    return orionStarRobot.initRobot();
  }

  static Future<String?> initRobotApi() {
    return orionStarRobot.initRobotApi();
  }

  static Future<String?> getPlatformVersion() {
    return orionStarRobot.getPlatformVersion();
  }

  static Future<String?> methodCallHandler() {
    return orionStarRobot.methodCallHandler(
          (p0) {
        if (streamController.isClosed) {
          streamController = StreamController<dynamic>();
        }

        streamController.add(p0);
        return Future.value("");
      },
    );
  }

  static Future<String?> getPicture() {
    return orionStarRobot.getPicture();
  }

  static Future<String?> registerById() {
    return orionStarRobot.registerById();
  }

  static Future<String?> goForward({required double distance}) {
    return orionStarRobot.goForward(distance: distance);
  }

  static Future<String?> goBackward() {
    return orionStarRobot.goBackward();
  }

  static Future<String?> playText({required String textToPlay}) {
    return orionStarRobot.playText(textToPlay: textToPlay);
  }

  static Future<String?> getRequestResponse() {
    return orionStarRobot.getRequestResponse();
  }

  static Future<String?> resetRequestResponse() {
    return orionStarRobot.resetRequestResponse();
  }

  static Future<String?> checkStatus() {
    return orionStarRobot.checkStatus();
  }

  static Future<String?> startNavigation({required String placeName}) {
    return orionStarRobot.startNavigation(placeName: placeName);
  }

  static Future<String?> isRobotInLocation({required String placeName}) {
    return orionStarRobot.isRobotInLocation(placeName: placeName);
  }

  static Future<String?> stopNavigation() {
    return orionStarRobot.stopNavigation();
  }

  static Future<String?> getNavigationResult() {
    return orionStarRobot.getNavigationResult();
  }

  static Future<String?> getTextListenerStatus() {
    return orionStarRobot.getTextListenerStatus();
  }

  static Future<String?> isRobotEstimate() {
    return orionStarRobot.isRobotEstimate();
  }

  static Future<int?> findPeople() {
    return orionStarRobot.findPeople();
  }

  static Future<List<String>?> robotGetLocation() {
    return orionStarRobot.robotGetLocation();
  }

  static Future<int?> register() {
    return orionStarRobot.register();
  }

  static Future<String?> stopMove() {
    return orionStarRobot.stopMove();
  }

  static Future<String?> turnLeft({required String speed}) {
    return orionStarRobot.turnLeft(speed: speed);
  }

  static Future<String?> turnRight({required String speed}) {
    return orionStarRobot.turnRight(speed: speed);
  }

  static Future<String?> mHeadDown() {
    return orionStarRobot.mHeadDown();
  }

  static Future<String?> mHeadUp() {
    return orionStarRobot.mHeadUp();
  }

  static Future<String?> resetHead() {
    return orionStarRobot.resetHead();
  }

  static Future<String?> startFocusFollow() {
    return orionStarRobot.startFocusFollow();
  }

  static Future<String?> stopFocusFollow() {
    return orionStarRobot.stopFocusFollow();
  }

  static Future<String?> checkMapName() {
    return orionStarRobot.checkMapName();
  }

  static Future<PersonResDataModel?> getPerson() {
    return orionStarRobot.getPerson();
  }

  static Future<String?> setLocation({required String locationName}) {
    return orionStarRobot.setLocation(locationName: locationName);
  }

  static Future<String?> startLead({required String locationName}) {
    return orionStarRobot.startLead(locationName: locationName);
  }

  static Future<String?> queryByText({required String text}) {
    return orionStarRobot.queryByText(text: text);
  }

  static Future<String?> startCruise() {
    return orionStarRobot.startCruise();
  }

  static Future<String?> stopCruise() {
    return orionStarRobot.stopCruise();
  }

  static convertTextToDuration(String? answerText){
    return orionStarRobot.convertTextToDuration(answerText);
  }

  static notPoseEstimate() {
    orionStarRobot.playText(
        textToPlay:
        " push me to the charging pool first ,and try again please");
  }

  static destinationNotExist() {
    orionStarRobot.playText(
        textToPlay: "sorry your Destination not exist ,try again please");
  }

}
