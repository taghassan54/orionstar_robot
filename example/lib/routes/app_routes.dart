import 'package:get/get.dart';
import 'package:orionstar_robot_example/features/checkin/presentation/pages/checkin_screen.dart';
import 'package:orionstar_robot_example/features/letsgo/presentation/pages/letsgo_screen.dart';
import 'package:orionstar_robot_example/features/main_dashboard/presentation/controllers/main_controller_binding.dart';
import 'package:orionstar_robot_example/features/main_dashboard/presentation/pages/main_dashboard_screen.dart';
import 'package:orionstar_robot_example/features/speech/presentation/pages/speech_screen.dart';
import 'package:orionstar_robot_example/features/welcome_speech/presentation/controllers/welcome_binding.dart';
import 'package:orionstar_robot_example/features/welcome_speech/presentation/pages/welcome_speech_screen.dart';

import '../features/end/presentation/pages/end_screen.dart';

class AppRoutes {
  static const welcomeRoute = "/welcome";
  static const checkInScreen = "/checkin";
  static const mainDashboardRoute = "/main_dashboard";
  static const speechRoute = "/speech";
  static const letsGoRoute = "/letsgo";
  static const endRoute = "/end";

  static final routes = <GetPage<dynamic>>[
    GetPage(
      name: welcomeRoute,
      page: () => const WelcomeScreen(),
      binding: WelcomeControllerBinding()
    ),

    GetPage(
      name: mainDashboardRoute,
      page: () => const MainDashboardScreen(),
      binding: MainScreenControllerBinding()
    ),
    GetPage(
      name: speechRoute,
      page: () => const SpeechScreen(),
    ),
    GetPage(
      name: checkInScreen,
      page: () => const CheckInScreen(),
    ),
    GetPage(
      name: letsGoRoute,
      page: () => const LetsGoScreen(),
    ),
    GetPage(
      name: endRoute,
      page: () => const EndScreen(),
    ),
  ];
}
