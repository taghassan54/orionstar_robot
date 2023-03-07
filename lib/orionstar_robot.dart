import 'package:orionstar_robot/models/person_res_data_model.dart';
import 'package:permission_handler/permission_handler.dart';

import 'orionstar_robot_platform_interface.dart';

class OrionstarRobot {
  Future<String?> initRobot() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    return OrionstarRobotPlatform.instance.checkInit();
  }

  Future<String?> getPlatformVersion() {
    return OrionstarRobotPlatform.instance.getPlatformVersion();
  }

  Future<String?> getPicture() {
    return OrionstarRobotPlatform.instance.getPicture();
  }

  Future<String?> registerById() {
    return OrionstarRobotPlatform.instance.registerById();
  }

  Future<String?> goForward({required double distance}) {
    return OrionstarRobotPlatform.instance.goForward(distance: distance);
  }

  Future<String?> goBackward() {
    return OrionstarRobotPlatform.instance.goBackward();
  }

  Future<String?> playText({required String textToPlay}) {
    return OrionstarRobotPlatform.instance
        .robotPlayText(textToPlay: textToPlay);
  }

  Future<String?> getRequestResponse() {
    return OrionstarRobotPlatform.instance.getRequestResponse();
  }

  Future<String?> resetRequestResponse() {
    return OrionstarRobotPlatform.instance.resetRequestResponse();
  }

  Future<String?> checkStatus() {
    return OrionstarRobotPlatform.instance.checkStatus();
  }

  Future<String?> startNavigation({required String placeName}) {
    return OrionstarRobotPlatform.instance
        .startNavigation(placeName: placeName);
  }

  Future<String?> stopNavigation() {
    return OrionstarRobotPlatform.instance.stopNavigation();
  }

  Future<String?> getNavigationResult() {
    return OrionstarRobotPlatform.instance.getNavigationResult();
  }

  Future<String?> getTextListenerStatus() {
    return OrionstarRobotPlatform.instance.getTextListenerStatus();
  }

  Future<String?> isRobotEstimate() {
    return OrionstarRobotPlatform.instance.isRobotEstimate();
  }

  Future<int?> findPeople() {
    return OrionstarRobotPlatform.instance.findPeople();
  }

  Future<List<String>?> robotGetLocation() {
    return OrionstarRobotPlatform.instance.robotGetLocation();
  }

  Future<int?> register() {
    return OrionstarRobotPlatform.instance.findPeople();
  }

  Future<String?> stopMove() {
    return OrionstarRobotPlatform.instance.stopMove();
  }

  Future<String?> turnLeft() {
    return OrionstarRobotPlatform.instance.turnLeft();
  }

  Future<String?> turnRight() {
    return OrionstarRobotPlatform.instance.turnRight();
  }

  Future<String?> mHeadDown() {
    return OrionstarRobotPlatform.instance.mHeadDown();
  }

  Future<String?> mHeadUp() {
    return OrionstarRobotPlatform.instance.mHeadUp();
  }

  Future<String?> resetHead() {
    return OrionstarRobotPlatform.instance.resetHead();
  }

  Future<String?> startFocusFollow() {
    return OrionstarRobotPlatform.instance.startFocusFollow();
  }

  Future<String?> stopFocusFollow() {
    return OrionstarRobotPlatform.instance.stopFocusFollow();
  }

  Future<String?> checkMapName() {
    return OrionstarRobotPlatform.instance.checkMapName();
  }

  Future<PersonResDataModel?> getPerson() {
    return OrionstarRobotPlatform.instance.getPerson();
  }

  Future<String?> setLocation({required String locationName}) {
    return OrionstarRobotPlatform.instance
        .setLocation(locationName: locationName);
  }

  Future<String?> startLead({required String locationName}) {
    return OrionstarRobotPlatform.instance
        .startLead(locationName: locationName);
  }

  Future<String?> queryByText({required String text}) {
    return OrionstarRobotPlatform.instance.googleQueryByText(text: text);
  }

  Future<String?> startCruise() {
    return OrionstarRobotPlatform.instance.startCruise();
  }

  Future<String?> stopCruise() {
    return OrionstarRobotPlatform.instance.stopCruise();
  }
}
