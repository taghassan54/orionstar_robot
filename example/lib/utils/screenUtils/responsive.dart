import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget? mobileLayout, webLayout, desktopLayout, tabletLayout;

  const ResponsiveLayout(
      {super.key,
      required this.desktopLayout,
      required this.webLayout,
      required this.mobileLayout,
      required this.tabletLayout});

  @override
  Widget build(BuildContext context) {
    return context.responsiveValue(
        desktop: desktopLayout ?? Container(),
        mobile: mobileLayout ?? Container(),
        tablet: tabletLayout ?? Container(),
        watch: Container(color: Colors.white));
  }
}
