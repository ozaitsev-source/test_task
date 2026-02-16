import 'package:flutter/material.dart';

import 'package:my_test_app/widgets/main_image.dart';
import 'package:my_test_app/widgets/control_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(children: [const AspectRatio(aspectRatio: 4 / 3, child: const MainImage()), Expanded(child: const ControlBar())]),
    );
  }
}
