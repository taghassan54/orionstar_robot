import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:orionstar_robot/orionstar_robot_method_channel.dart';

void main() {
  MethodChannelOrionstarRobot platform = MethodChannelOrionstarRobot();
  const MethodChannel channel = MethodChannel('orionstar_robot');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
