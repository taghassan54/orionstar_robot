import 'package:flutter_test/flutter_test.dart';
import 'package:orionstar_robot/models/person_res_data_model.dart';
import 'package:orionstar_robot/orionstar_robot.dart';
import 'package:orionstar_robot/orionstar_robot_platform_interface.dart';
import 'package:orionstar_robot/orionstar_robot_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockOrionstarRobotPlatform
    with MockPlatformInterfaceMixin
    implements OrionstarRobotPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<String?> getPicture() => Future.value("");

  @override
  Future<String?> checkStatus() => Future.value("");

  @override
  Future<int?> findPeople() => Future.value(0);

  @override
  Future<int?> register() => Future.value(0);

  @override
  Future<String?> startNavigation({required String placeName}) =>
      Future.value("");

  @override
  Future<List<String>?> robotGetLocation() =>Future.value([]);

  @override
  Future<String?> mHeadDown() =>
      Future.value("");

  @override
  Future<String?> mHeadUp() =>
      Future.value("");

  @override
  Future<String?> resetHead() =>
      Future.value("");

  @override
  Future<String?> startFocusFollow() =>
      Future.value("");
  @override
  Future<String?> stopFocusFollow() =>
      Future.value("");

  @override
  Future<String?> stopMove() =>
      Future.value("");

  @override
  Future<String?> turnLeft() =>
      Future.value("");
  @override
  Future<String?> turnRight() =>
      Future.value("");

  @override
  Future<PersonResDataModel?> getPerson() =>Future.value(null);

  @override
  Future<String?> checkInit() =>Future.value("");

  @override
  Future<String?> startCruise() =>Future.value("");

  @override
  Future<String?> checkMapName() =>Future.value("");

  @override
  Future<String?> setLocation({required String locationName}) =>Future.value('');
}

void main() {
  final OrionstarRobotPlatform initialPlatform =
      OrionstarRobotPlatform.instance;

  test('$MethodChannelOrionstarRobot is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelOrionstarRobot>());
  });

  test('getPlatformVersion', () async {
    OrionstarRobot orionstarRobotPlugin = OrionstarRobot();
    MockOrionstarRobotPlatform fakePlatform = MockOrionstarRobotPlatform();
    OrionstarRobotPlatform.instance = fakePlatform;

    expect(await orionstarRobotPlugin.getPlatformVersion(), '42');
  });
}
