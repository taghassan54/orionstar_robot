import 'package:flutter/services.dart';
import 'package:orionstar_robot/models/person_res_data_model.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'orionstar_robot_method_channel.dart';

abstract class OrionstarRobotPlatform extends PlatformInterface {
  /// Constructs a OrionstarRobotPlatform.
  OrionstarRobotPlatform() : super(token: _token);

  static final Object _token = Object();

  static OrionstarRobotPlatform _instance = MethodChannelOrionstarRobot();

  /// The default instance of [OrionstarRobotPlatform] to use.
  ///
  /// Defaults to [MethodChannelOrionstarRobot].
  static OrionstarRobotPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [OrionstarRobotPlatform] when
  /// they register themselves.
  static set instance(OrionstarRobotPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
  Future<String?> methodCallHandler(Future<String?> Function(MethodCall) helperHandler) {
    throw UnimplementedError('methodCallHandler() has not been implemented.');
  }

  Future<String?> checkInit() {
    throw UnimplementedError('checkInit() has not been implemented.');
  }

  Future<String?> getPicture() {
    throw UnimplementedError('getPicture() has not been implemented.');
  }

  Future<String?> checkStatus() {
    throw UnimplementedError('checkStatus() has not been implemented.');
  }

  Future<int?> findPeople() {
    throw UnimplementedError('findPeople() has not been implemented.');
  }

  Future<int?> register() {
    throw UnimplementedError('register() has not been implemented.');
  }

  Future<String?> startNavigation({required String placeName}) {
    throw UnimplementedError('startNavigation() has not been implemented.');
  }

  Future<String?> resumeSpecialPlaceTheta({required String placeName}) =>throw UnimplementedError('startNavigation() has not been implemented.');


  Future<List<String>?> robotGetLocation() {
    throw UnimplementedError('robotGetLocation() has not been implemented.');
  }

  Future<String?> stopMove() {
    throw UnimplementedError('stopMove() has not been implemented.');
  }

  Future<String?> turnLeft() {
    throw UnimplementedError('turnLeft() has not been implemented.');
  }

  Future<String?> turnRight() {
    throw UnimplementedError('turnRight() has not been implemented.');
  }

  Future<String?> mHeadDown() {
    throw UnimplementedError('mHeadDown() has not been implemented.');
  }

  Future<String?> mHeadUp() =>
      throw UnimplementedError('mHeadUp() has not been implemented.');

  Future<String?> resetHead() =>
      throw UnimplementedError('resetHead() has not been implemented.');

  Future<String?> startFocusFollow() =>
      throw UnimplementedError('startFocusFollow() has not been implemented.');

  Future<String?> stopFocusFollow() =>
      throw UnimplementedError('stopFocusFollow() has not been implemented.');

  Future<PersonResDataModel?> getPerson() =>
      throw UnimplementedError('getPerson() has not been implemented.');

  Future<String?> setLocation({required String locationName}) =>
      throw UnimplementedError('setLocation() has not been implemented.');

  Future<String?> startCruise() =>
      throw UnimplementedError('startCruise() has not been implemented.');

  Future<String?> checkMapName() =>
      throw UnimplementedError('checkMapName() has not been implemented.');

  Future<String?> getRequestResponse() => throw UnimplementedError(
      'getRequestResponse() has not been implemented.');

  Future<String?> resetRequestResponse() => throw UnimplementedError(
      'resetRequestResponse() has not been implemented.');

  Future<String?> robotPlayText({required String textToPlay}) =>
      throw UnimplementedError('robotPlayText() has not been implemented.');

  Future<String?> startNaviToAutoChargeAction() =>
      throw UnimplementedError('startNaviToAutoChargeAction() has not been implemented.');

  Future<String?> registerById() =>
      throw UnimplementedError('registerById() has not been implemented.');

  Future<String?> goBackward() =>
      throw UnimplementedError('goBackward() has not been implemented.');

  Future<String?> goForward({required double distance}) =>
      throw UnimplementedError('goForward() has not been implemented.');

  Future<String?> stopCruise() =>
      throw UnimplementedError('stopCruise() has not been implemented.');

  Future<String?> stopTTS() =>
      throw UnimplementedError('stopTTS() has not been implemented.');

  Future<String?> startLead({required String locationName}) =>
      throw UnimplementedError('startLead() has not been implemented.');

  Future<String?> googleQueryByText({required String text}) =>
      throw UnimplementedError('googleQueryByText() has not been implemented.');

  Future<String?> stopNavigation() =>
      throw UnimplementedError('stopNavigation() has not been implemented.');

  Future<String?> getNavigationResult() => throw UnimplementedError(
      'getNavigationResult() has not been implemented.');

  Future<String?> getTextListenerStatus() => throw UnimplementedError(
      'getTextListenerStatus() has not been implemented.');

  Future<String?> isRobotEstimate() =>throw UnimplementedError(
      'isRobotEstimate() has not been implemented.');

  Future<String?> isRobotInLocation({required String placeName}) =>throw UnimplementedError(
      'isRobotInLocation() has not been implemented.');

  Future<String?> stopChargingByApp() =>throw UnimplementedError('stopChargingByApp() has not been implemented.');

  Future<String?> disableRecognizable() =>throw UnimplementedError('disableRecognizable() has not been implemented.');

  Future<String?> enableRecognizable() =>throw UnimplementedError('enableRecognizable() has not been implemented.');
} //queryByText
