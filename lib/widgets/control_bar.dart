import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math' as math;

import 'package:my_test_app/widgets/figures.dart';
import 'package:my_test_app/cubit/triangle_rotation_cubit.dart';

class ControlBar extends StatefulWidget {
  const ControlBar({super.key});

  @override
  State<StatefulWidget> createState() => ControlBarState();
}

class ControlBarState extends State<ControlBar> {
  double _sliderValue = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(height: 20),

        RepaintBoundary(
          child: BlocBuilder<TriangleRotationCubit, AngleState>(
            builder: (context, state) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStepButton(context, '-10°', -math.pi / 18, state.isManual),
                  _buildZeroButoon(context, state.isManual),
                  _buildStepButton(context, '+10°', math.pi / 18, state.isManual),
                ],
              );
            },
          ),
        ),

        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RepaintBoundary(
                child: BlocBuilder<TriangleRotationCubit, AngleState>(
                  builder: (context, state) {
                    return Slider(
                      value: _sliderValue,
                      min: -math.pi,
                      max: math.pi,
                      onChanged:
                          (!state.isManual)
                              ? null
                              : (value) {
                                setState(() => _sliderValue = value);
                                context.read<TriangleRotationCubit>().setAngle(value);
                              },
                    );
                  },
                ),
              ),
            ],
          ),
        ),

        BlocBuilder<TriangleRotationCubit, AngleState>(
          builder: (context, state) {
            return RepaintBoundary(child: Text('Current Raw Degrees: ${(state.angle * 180 / math.pi).toStringAsFixed(2)}°'));
          },
        ),

        const Spacer(),

        Expanded(
          child: BlocBuilder<TriangleRotationCubit, AngleState>(
            buildWhen: (previous, current) {
              int previousDegrees = (previous.angle * 180 / math.pi).round();
              int currentDegrees = (current.angle * 180 / math.pi).round();
              return previousDegrees != currentDegrees;
            },
            builder: (context, state) {
              return AspectRatio(
                aspectRatio: 1,
                child: Padding(padding: const EdgeInsets.all(8), child: RepaintBoundary(child: Figures(angle: state.angle))),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildStepButton(BuildContext context, String text, double step, bool isEnabled) {
    return ElevatedButton(
      onPressed:
          !isEnabled
              ? null
              : () {
                context.read<TriangleRotationCubit>().setStep(step);
              },
      child: Text(text),
    );
  }

  Widget _buildZeroButoon(BuildContext context, bool isEnabled) {
    return ElevatedButton(
      onPressed:
          !isEnabled
              ? null
              : () {
                context.read<TriangleRotationCubit>().setZero();
              },
      child: const Text('0'),
    );
  }
}
