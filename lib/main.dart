import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_test_app/screens/main_screen.dart';
import 'package:my_test_app/cubit/triangle_rotation_cubit.dart';

void main() {
  debugRepaintRainbowEnabled = true;
  runApp(MaterialApp(home: BlocProvider(create: (context) => TriangleRotationCubit(), child: const TestTaskScreen())));
}
