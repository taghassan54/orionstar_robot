
import 'package:flutter/material.dart';



@immutable
abstract class WelcomeGetState {}

class WelcomeInitial extends WelcomeGetState {}
class ConnectionStatusChangedEvent extends WelcomeGetState{}
