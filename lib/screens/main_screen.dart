import 'package:flutter/material.dart';

import 'package:my_test_app/widgets/main_image.dart';
import 'package:my_test_app/widgets/control_bar.dart';

class TestTaskScreen extends StatefulWidget {
  const TestTaskScreen({super.key});
  @override
  State<TestTaskScreen> createState() => _TestTaskScreenState();
}

class _TestTaskScreenState extends State<TestTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Row(children: [const MainImage(), ControlBar()]));
  }
}
