import 'package:flutter/material.dart';

import 'package:my_test_app/widgets/main_image.dart';
import 'package:my_test_app/widgets/control_bar.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(children: [const AspectRatio(aspectRatio: 4 / 3, child: const MainImage()), Expanded(child: const ControlBar())]),
    );
  }
}
