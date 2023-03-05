import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:bloc/bloc.dart' as bloc;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/utils/app_environment.dart';
import 'injection.dart';
import 'routes/app_routes.dart';
import 'theme/theme_data.dart';
import 'utils/bloc/global_app_bloc_delegate.dart';
import 'utils/translation/translations.dart';

void main() async {
  await GetStorage.init();

  configureDependencies(AppEnvironment.dev);
  bloc.Bloc.observer = SimpleBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive, overlays: []);
    setForceLandscapeOrientation();
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetMaterialApp(
            title: 'merchants admin',
            enableLog: true,
            debugShowCheckedModeBanner: false,
            defaultTransition: Transition.cupertino,
            getPages: AppRoutes.routes,
            translations: Translation(),
            routingCallback: (value) {},
            theme: LightTheme.lightTheme,
            initialRoute: AppRoutes.welcomeRoute,
          );
        });
  }
}

setForceLandscapeOrientation() async {
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
}

