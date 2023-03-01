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
  Future<String?> getPlatformVersion() async {
    final result =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
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
  Future<String?> startNavigation({required String placeName}) async {
    final result =
        await methodChannel.invokeMethod<String>('startNavigation', placeName);
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
  Future<String?> turnLeft() async {
    final result = await methodChannel.invokeMethod<String>('turnLeft');
    return result;
  }

  @override
  Future<String?> turnRight() async {
    final result = await methodChannel.invokeMethod<String>('turnRight');
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
    final result = await methodChannel.invokeMethod<String>('goForward',distance);
    return result;
  }
  @override
  Future<String?> getRequestResponse() async {
    final result = await methodChannel.invokeMethod<String>('getRequestResponse');
    return result;
  }
  @override
  Future<String?> resetRequestResponse() async {
    final result = await methodChannel.invokeMethod<String>('resetRequestResponse');
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
  Future<String?> robotPlayText({required String textToPlay}) async {
    final result =
        await methodChannel.invokeMethod<String>('playText', textToPlay);
    return result;
  }
}
