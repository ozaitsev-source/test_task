import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math' as math;

import 'package:my_test_app/io/udp_angle_service.dart';

class AngleState extends Equatable {
  final double angle;
  final bool isManual;

  const AngleState({required this.angle, required this.isManual});

  @override
  List<Object?> get props => [angle, isManual];

  AngleState copyWith({double? angle, bool? isManual}) {
    return AngleState(angle: angle ?? this.angle, isManual: isManual ?? this.isManual);
  }
}

class TriangleRotationCubit extends Cubit<AngleState> {
  TriangleRotationCubit() : super(const AngleState(angle: 0, isManual: true)) {}

  StreamSubscription<double>? _streamSubscription;

  Timer? _watchdogTimer;

  Future<void> openStream() async {
    _streamSubscription ??= UdpAngleReader().listen((value) {
      emit(state.copyWith(angle: value, isManual: false));
      _watchdogTimer?.cancel();
      _watchdogTimer = Timer(const Duration(milliseconds: 100), () {
        emit(state.copyWith(isManual: true));
      });
    });
  }

  Future<void> _closeStream() async {
    await _streamSubscription?.cancel();
    _streamSubscription = null;
  }

  void setAngle(double angle) {
    if (!state.isManual) return;

    emit(state.copyWith(angle: angle.clamp(-math.pi, math.pi).toDouble()));
  }

  @override
  Future<void> close() async {
    await _closeStream();

    return super.close();
  }

  void setStep(double step) => emit(state.copyWith(angle: (state.angle + step).clamp(-math.pi, math.pi)));
  void setZero() => emit(state.copyWith(angle: 0));
}
