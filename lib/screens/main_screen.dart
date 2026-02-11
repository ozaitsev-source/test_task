import 'package:flutter/material.dart';

import 'package:my_test_app/widgets/main_image.dart';
import 'package:my_test_app/widgets/control_bar.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Row(children: [MainImage(), Expanded(child: ControlBar())]));
  }
}
