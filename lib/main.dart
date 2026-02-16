import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'screens/main_screen.dart';
import 'cubit/triangle_rotation_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  debugRepaintRainbowEnabled = true;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => TriangleRotationCubit(), child: const MaterialApp(home: MainScreen()));
  }
}
