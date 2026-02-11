import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math' as math;

import 'package:my_test_app/widgets/figures.dart';
import 'package:my_test_app/cubit/triangle_rotation_cubit.dart';

class ControlBar extends StatelessWidget {
  const ControlBar({super.key});

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 20),

          RepaintBoundary(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStepButton(context, '-10°', -math.pi / 18),
                _buildZeroButoon(context),
                _buildStepButton(context, '+10°', math.pi / 18),
              ],
            ),
          ),
          const SizedBox(height: 20),

          Expanded(
            child: BlocBuilder<TriangleRotationCubit, double>(
              buildWhen: (previous, current) {
                int previousDegrees = (previous * 180 / math.pi).round();
                int currentDegrees = (current * 180 / math.pi).round();
                return previousDegrees != currentDegrees;
              },
              builder:
                  (context, rotationAngle) => Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RepaintBoundary(
                        child: Slider(
                          value: rotationAngle,
                          min: -math.pi,
                          max: math.pi,
                          onChanged: (value) {
                            context.read<TriangleRotationCubit>().setRotation(value);
                          },
                        ),
                      ),
                      Text('Current Degrees: ${(rotationAngle * 180 / math.pi).toStringAsFixed(2)}°'),
                      const Spacer(),

                      Expanded(
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Padding(padding: const EdgeInsets.all(8), child: RepaintBoundary(child: Figures(angle: rotationAngle))),
                        ),
                      ),
                    ],
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepButton(BuildContext context, String text, double step) {
    return ElevatedButton(
      onPressed: () {
        context.read<TriangleRotationCubit>().setStep(step);
      },
      child: Text(text),
    );
  }

  Widget _buildZeroButoon(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<TriangleRotationCubit>().setZero();
      },
      child: const Text('0'),
    );
  }
}
