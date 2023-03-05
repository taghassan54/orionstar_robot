import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../theme/theme_data.dart';

class LocationItemWidget extends StatelessWidget {
  final String title;
  final String imgPath;
  final Function onItemTapped;

  const LocationItemWidget({
    Key? key,
    required this.title,
    required this.imgPath,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onItemTapped(),
      child: Container(
        width: 100,
        height: 100,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          image: DecorationImage(image: AssetImage(imgPath), fit: BoxFit.cover),
        ),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 24),
            width: Get.width,
            decoration: const BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
                gradient: LinearGradient(
                    colors: [Colors.black, Colors.transparent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter)),
            child: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(fontWeight: FontWeight.bold, color: AppColors.white),
            ),
          ),
        ),
      ),
    );
  }
}
