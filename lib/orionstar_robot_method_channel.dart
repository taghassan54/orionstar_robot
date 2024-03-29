import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:orionstar_robot/logger_helper.dart';
import 'package:orionstar_robot/models/person_res_data_model.dart';

import 'orionstar_robot_platform_interface.dart';

/// An implementation of [OrionstarRobotPlatform] that uses method channels.
class MethodChannelOrionstarRobot extends OrionstarRobotPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('orionstar_robot');

  @override
  Future<String?> checkInit() async {
    final result = await methodChannel.invokeMethod<String>('checkInit');
    return result;
  }

  @override
  Future<String?> initRobotApi() async {
    final result = await methodChannel.invokeMethod<String>('initRobotApi');
    return result;
  }

  @override
  Future<String?> getPlatformVersion() async {
    final result =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return result;
  }
  @override
  Future<String?> methodCallHandler(Future<String?> Function(MethodCall) helperHandler) async {
    methodChannel.setMethodCallHandler((call) => helperHandler(call));
    return null;
  }

  @override
  Future<String?> startNaviToAutoChargeAction() async {
    final result = await methodChannel.invokeMethod<String>('startNaviToAutoChargeAction');
    return result;
  }
  @override
  Future<String?> stopChargingByApp() async {
    final result = await methodChannel.invokeMethod<String>('stopChargingByApp');
    return result;
  }
  @override
  Future<String?> getPicture() async {
    final result = await methodChannel.invokeMethod<String>('getPicture');
    return result;
  }

  @override
  Future<String?> checkStatus() async {
    final result = await methodChannel.invokeMethod<String>('checkStatus');
    return result;
  }

  @override
  Future<int?> findPeople() async {
    final result = await methodChannel.invokeMethod<int>('findPeople');
    return result;
  }

  @override
  Future<int?> register() async {
    final result = await methodChannel.invokeMethod<int>('register');
    return result;
  }

  @override
  Future<String?> isRobotInLocation({required String placeName}) async {
    final result =
        await methodChannel.invokeMethod<String>('isRobotInLocation', placeName);
    return result;
  }

  @override
  Future<String?> startNavigation({required String placeName}) async {
    final result =
        await methodChannel.invokeMethod<String>('startNavigation', placeName);
    return result;
  }

  @override
  Future<String?> resumeSpecialPlaceTheta({required String placeName}) async {
    final result =
        await methodChannel.invokeMethod<String>('resumeSpecialPlaceTheta', placeName);
    return result;
  }

  @override
  Future<String?> getNavigationResult() async {
    final result =
        await methodChannel.invokeMethod<String>('getNavigationResult');
    return result;
  }

  @override
  Future<String?> stopNavigation() async {
    final result = await methodChannel.invokeMethod<String>('stopNavigation');
    return result;
  }

  @override
  Future<List<String>?> robotGetLocation() async {
    final result = await methodChannel.invokeMethod<String>('robotGetLocation');
    return result?.split(',');
  }

  @override
  Future<String?> stopMove() async {
    final result = await methodChannel.invokeMethod<String>('stopMove');
    return result;
  }

  @override
  Future<String?> getTextListenerStatus() async {
    final result = await methodChannel.invokeMethod<String>('getTextListenerStatus');
    return result;
  }
  @override
  Future<String?> isRobotEstimate() async {
    final result = await methodChannel.invokeMethod<String>('isRobotEstimate');
    return result;
  }

  @override
  Future<String?> turnLeft({required String speed}) async {
    final result = await methodChannel.invokeMethod<String>('turnLeft',speed);
    return result;
  }

  @override
  Future<String?> turnRight({required String speed}) async {
    final result = await methodChannel.invokeMethod<String>('turnRight',speed);
    return result;
  }

  @override
  Future<String?> mHeadDown() async {
    final result = await methodChannel.invokeMethod<String>('mHeadDown');
    return result;
  }

  @override
  Future<String?> mHeadUp() async {
    final result = await methodChannel.invokeMethod<String>('mHeadUp');
    return result;
  }

  @override
  Future<String?> resetHead() async {
    final result = await methodChannel.invokeMethod<String>('resetHead');
    return result;
  }

  @override
  Future<String?> startFocusFollow() async {
    final result = await methodChannel.invokeMethod<String>('startFocusFollow');
    return result;
  }

  @override
  Future<PersonResDataModel?> getPerson() async {
    final result = await methodChannel.invokeMethod<String>('getPerson');
    var userMap = jsonDecode("$result");
    // LoggerHelper.debug("$result");
    if (userMap != null) {
      return PersonResDataModel.fromJson(userMap);
    }
    return null;
  }

  @override
  Future<String?> stopFocusFollow() async {
    final result = await methodChannel.invokeMethod<String>('stopFocusFollow');
    return result;
  }

  @override
  Future<String?> startCruise() async {
    final result = await methodChannel.invokeMethod<String>('startCruise');
    return result;
  }

  @override
  Future<String?> stopCruise() async {
    final result = await methodChannel.invokeMethod<String>('stopCruise');
    return result;
  }

  @override
  Future<String?> stopTTS() async {
    final result = await methodChannel.invokeMethod<String>('stopTTS');
    return result;
  }
  @override
  Future<String?> disableRecognizable() async {
    final result = await methodChannel.invokeMethod<String>('disableRecognizable');
    return result;
  }
  @override
  Future<String?> enableRecognizable() async {
    final result = await methodChannel.invokeMethod<String>('enableRecognizable');
    return result;
  }

  @override
  Future<String?> registerById() async {
    final result = await methodChannel.invokeMethod<String>('registerById');
    return result;
  }

  @override
  Future<String?> goBackward() async {
    final result = await methodChannel.invokeMethod<String>('goBackward');
    return result;
  }

  @override
  Future<String?> goForward({required double distance}) async {
    final result =
        await methodChannel.invokeMethod<String>('goForward', distance);
    return result;
  }

  @override
  Future<String?> getRequestResponse() async {
    final result =
        await methodChannel.invokeMethod<String>('getRequestResponse');
    return result;
  }

  @override
  Future<String?> resetRequestResponse() async {
    final result =
        await methodChannel.invokeMethod<String>('resetRequestResponse');
    return result;
  }

  @override
  Future<String?> checkMapName() async {
    final result = await methodChannel.invokeMethod<String>('checkMapName');
    return result;
  }

  @override
  Future<String?> setLocation({required String locationName}) async {
    final result =
        await methodChannel.invokeMethod<String>('setLocation', locationName);
    return result;
  }

  @override
  Future<String?> startLead({required String locationName}) async {
    final result =
        await methodChannel.invokeMethod<String>('startLead', locationName);
    return result;
  }

  @override
  Future<String?> googleQueryByText({required String text}) async {
    final result =
        await methodChannel.invokeMethod<String>('queryByText', text);
    return result;
  }

  @override
  Future<String?> robotPlayText({required String textToPlay}) async {
    final result =
        await methodChannel.invokeMethod<String>('playText', textToPlay);
    return result;
  }
}
