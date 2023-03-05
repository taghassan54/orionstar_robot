import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orionstar_robot_example/generated/assets.dart';
import 'package:orionstar_robot_example/theme/theme_data.dart';
import 'package:lottie/lottie.dart';

class EndScreen extends StatelessWidget {
  const EndScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: Get.width,
        height: Get.height,
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset(Assets.byeAnim),
              Container(
                width: 150,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: const BoxDecoration(
                    image: DecorationImage(image: AssetImage(Assets.goodbyeImg), fit: BoxFit.fitWidth)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
