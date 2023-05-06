import 'package:flutter/material.dart';



@immutable
abstract class RobotState {}

class Initial extends RobotState {}
class NavigationState extends RobotState{}
class SpeechState extends RobotState{}
class SadState extends RobotState{}
class SmileState extends RobotState{}
class LikingState extends RobotState{}
class BlinkLookUpState extends RobotState{}
class TakePhotoState extends RobotState{}
class LookLeftRightState extends RobotState{}
