import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orionstar_robot_example/generated/assets.dart';
import 'package:orionstar_robot_example/routes/app_routes.dart';
import 'package:orionstar_robot_example/theme/theme_data.dart';
import 'package:orionstar_robot_example/utils/extensions.dart';

import '../widgets/location_item_widget.dart';

class CheckInScreen extends StatefulWidget {
  const CheckInScreen({Key? key}) : super(key: key);

  @override
  State<CheckInScreen> createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController =
      AnimationController(vsync: this, duration: const Duration(milliseconds: 900));

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _animationController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        decoration: BoxDecoration(
            color: AppColors.black,
            image: const DecorationImage(image: AssetImage(Assets.bgImage), fit: BoxFit.cover, opacity: 0.2)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Please select the location',
              style: Theme.of(context).textTheme.displaySmall?.copyWith(color: AppColors.white),
            ),
            context.sizedBoxHeightDefault,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SlideTransition(
                  position: Tween<Offset>(begin: const Offset(0, -8), end: const Offset(0, 0))
                      .animate(CurvedAnimation(parent: _animationController, curve: Curves.decelerate)),
                  child: SizeTransition(
                    sizeFactor: Tween<double>(begin: 0, end: 1)
                        .animate(CurvedAnimation(parent: _animationController, curve: Curves.decelerate)),
                    child: LocationItemWidget(
                      title: 'Check in',
                      imgPath: Assets.checkInBG,
                      onItemTapped: () async {
                        await Get.toNamed(
                          AppRoutes.speechRoute,
                        );
                        Get.toNamed(AppRoutes.letsGoRoute);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
