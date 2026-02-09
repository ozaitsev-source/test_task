import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:my_test_app/screens/main_screen.dart';

void main() {
  debugRepaintRainbowEnabled = true;
  runApp(const MaterialApp(home: TestTaskScreen()));
}
