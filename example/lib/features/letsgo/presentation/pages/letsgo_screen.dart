import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orionstar_robot_example/generated/assets.dart';
import 'package:orionstar_robot_example/routes/app_routes.dart';
import 'package:lottie/lottie.dart';

class LetsGoScreen extends StatelessWidget {
  const LetsGoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: (){
          // GestureDetector is for seeing the flow
          Get.toNamed(AppRoutes.mainDashboardRoute);
        },
        child: SizedBox(
          width: Get.width,
          height: Get.height,
          child: Padding(
            padding: const EdgeInsets.all(70),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Lottie.asset(Assets.letsGoAnim),
                ),
                Text(
                  'Lets go!',
                  style: Theme.of(context).textTheme.displayMedium,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
