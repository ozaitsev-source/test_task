import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math' as math;

class TriangleRotationCubit extends Cubit<double> {
  TriangleRotationCubit() : super(0.0);

  void setRotation(double angle) => emit(angle);
  void setStep(double step) => emit((state + step).clamp(-math.pi, math.pi));
  void setZero() => emit(0.0);
}
