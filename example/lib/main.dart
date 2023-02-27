import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:orionstar_robot/models/person_res_data_model.dart';
import 'package:orionstar_robot/orionstar_robot.dart';
import 'package:orionstar_robot_example/model_data_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _orionstarRobotPlugin = OrionstarRobot();
  List<String>? dataList = [];
  String? placeName;
  List<String> imagePath = [];
  List resultMesseges = [];
  PersonResDataModel? person;
  Timer? _timer;
  int start = 100;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() async {
    await _orionstarRobotPlugin.initRobot();

    dataList= await _orionstarRobotPlugin.robotGetLocation();
    // await _orionstarRobotPlugin.startCruise();
    const oneSec = Duration(milliseconds: 1000);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) async {
        final String? resultPicture = await _orionstarRobotPlugin.getPicture();
        if (imagePath.length > 3) {
          imagePath.removeLast();
        }
        setState(() {
          imagePath.add("$resultPicture");
        });

        final String? result = await _orionstarRobotPlugin.checkStatus();
        if (!result!.startsWith("personResData")) {
          if (resultMesseges.isNotEmpty) {
            if (resultMesseges.last != result) {
              setState(() {
                resultMesseges.add(result);
              });
            }
          } else {
            setState(() {
              resultMesseges.add(result);
            });
          }
        }


            var zoal = await _orionstarRobotPlugin.getPerson();
            if (mounted) {
              setState(() {
                person = zoal;
              });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(

        body: SingleChildScrollView(
          child: Column(
            children: [
              if (imagePath.isNotEmpty)
               Row(
                 children: [
                   SizedBox(
                     width: Get.width*0.5,
                     child:  Column(
                       children: [
                         if (person != null)

                               Image.file(
                                 File(imagePath.last),
                                 width: 100,
                                 height: 100,
                                 errorBuilder: (context, error, stackTrace) => Container(),
                               ),
                              Padding(
                                 padding: const EdgeInsets.all(8.0),
                                 child: SizedBox(
                                   height: Get.height * 0.7,
                                   // width: Get.width*0.1,
                                   child: person!=null? ModelDataWidget(data: person!.toJson()):const Center(child: Text("No Person Found ! ^_^")),
                                 ),
                               ),
                       ],
                     ),
                   ),
                   SizedBox(
                     width: Get.width*0.45,
                     child:  Column(
                       children: [

                         if (resultMesseges.isNotEmpty)
                           SizedBox(
                             height: 100,
                             child: ListView.builder(
                               itemCount: resultMesseges.length,
                               itemBuilder: (context, index) => Text(
                                 resultMesseges.reversed.toList()[index] ?? '',
                                 style: const TextStyle(fontSize: 13),
                               ),
                             ),
                           ),
                         if (placeName != null)
                           Text(
                             placeName ?? '',
                             style: const TextStyle(fontSize: 24),
                           ),
                         if (dataList!=null&&dataList!.isNotEmpty)
                           SizedBox(
                             height: Get.height * 0.8,
                             child: ListView.builder(
                               padding: const EdgeInsets.all(8.0),
                               scrollDirection: Axis.vertical,
                               itemCount: dataList!.length,
                               itemBuilder: (context, index) => Padding(
                                 padding: const EdgeInsets.all(0.0),
                                 child: ElevatedButton(
                                     onPressed: () async{
                                       setState(() {
                                         placeName = "${dataList?[index]}";
                                       });
                                       await  Future.delayed(const Duration(seconds: 3),()async =>  await _orionstarRobotPlugin.startNavigation(placeName: "${dataList?[index]}"),);
                                     },
                                     child: Text("${dataList?[index]}")),
                               ),
                             ),
                           ),

                       ],
                     ),
                   )
                 ],
               )
            ],
          ),
        ),
      ),
    );
  }
}
