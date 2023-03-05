import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orionstar_robot_example/features/main_dashboard/presentation/controllers/main_screen_controller.dart';
import 'package:orionstar_robot_example/generated/assets.dart';
import 'package:orionstar_robot_example/routes/app_routes.dart';
import 'package:orionstar_robot_example/theme/theme_data.dart';
import 'package:orionstar_robot_example/utils/extensions.dart';

import '../widgets/location_item_widget.dart';

class MainDashboardScreen extends GetView<MainScreenController> {
  const MainDashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.obx((state) => Scaffold(

          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: Get.width,

                  decoration: BoxDecoration(
                      color: AppColors.black,
                      image: const DecorationImage(
                          image: AssetImage(Assets.bgImage),
                          fit: BoxFit.cover,
                          opacity: 0.2)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Please select the location',
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall
                            ?.copyWith(color: AppColors.white),
                      ),
                      context.sizedBoxHeightSmall,
                      SizedBox(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.points?.length,
                          itemBuilder: (context, index) => LocationItemWidget(
                              title: "${controller.points?[index]}",
                              imgPath: Assets.checkInBG,
                              onItemTapped: () async {
                                // await Get.toNamed(AppRoutes.welcomeRoute);
                                // Get.toNamed(AppRoutes.endRoute);

                                controller.goTo("${controller.points?[index]}");
                              }),
                        ),
                      ),

                      if (controller.resultMesseges.isNotEmpty)
                        SizedBox(
                          height: 100,
                          child: ListView.builder(
                            itemCount: controller.resultMesseges.length,
                            itemBuilder: (context, index) => Text(
                              controller.resultMesseges.reversed.toList()[index] ?? '',
                              style: const TextStyle(fontSize: 13),
                            ),
                          ),
                        ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LocationItemWidget(
                              title: 'Check in',
                              imgPath: Assets.checkInBG,
                              onItemTapped: () async {
                                // await Get.toNamed(AppRoutes.welcomeRoute);
                                // Get.toNamed(AppRoutes.endRoute);

                                controller.goTo("Reception Point");
                              }),
                          LocationItemWidget(
                              title: 'Lounge',
                              imgPath: Assets.loungeBG,
                              onItemTapped: () {
                                // Get.toNamed(AppRoutes.speechRoute);
                                controller.goTo("Amody");
                              })
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LocationItemWidget(
                            title: 'Bar',
                            imgPath: Assets.barBG,
                            onItemTapped: () => Get.toNamed(AppRoutes.speechRoute),
                          ),
                          LocationItemWidget(
                            title: 'Room',
                            imgPath: Assets.roomBG,
                            onItemTapped: () => Get.toNamed(AppRoutes.speechRoute),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
