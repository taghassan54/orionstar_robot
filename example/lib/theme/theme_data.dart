import 'package:flutter/material.dart';

import '../utils/extensions.dart';

class LightTheme {
  static const Color primaryColor = Color(0xffd34b27);
  static const Color secondaryColor = Colors.white;
  static Color backgroundColor = Colors.grey.shade50;
  static Color greyLight = Colors.grey.shade400;
  static Color primarySeed = HexColor.fromHex('#d34b27');
  static ThemeData lightTheme = ThemeData(
    appBarTheme: const AppBarTheme(backgroundColor: primaryColor),
    inputDecorationTheme: const InputDecorationTheme(
      hintStyle: TextStyle(
        color: primaryColor,
      ),
    ),
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: primarySeed),
    primaryColorLight: primaryColor.withOpacity(0.5),
    primarySwatch: Colors.orange,
    primaryColor: primaryColor,
    disabledColor: secondaryColor,
    bottomAppBarColor: greyLight,
    scaffoldBackgroundColor: backgroundColor,
    fontFamily: 'ProximaNova',
    textTheme: const TextTheme(
      labelMedium: TextStyle(),
    ).apply(
      bodyColor: primaryColor,
      displayColor: primaryColor,
    ),
    iconTheme: const IconThemeData(color: primaryColor),
  );
}

class AppColors {
  static Color transparentPrimaryColor = const Color(0xFFFFF0E3);
  static Color transparentBlackColor = const Color(0x83000000);
  static Color gray = const Color(0xffa8a8a8);
  static Color pink = const Color(0xffE8BDBB);
  static Color black = const Color(0xff3f3f3f);
  static Color white = const Color(0xffffffff);
}
