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
          // Кнопки
          const SizedBox(height: 20),
          RepaintBoundary(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [setStep(context, '-10°', -math.pi / 18), setZero(context), setStep(context, '+10°', math.pi / 18)],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: BlocBuilder<TriangleRotationCubit, double>(
              builder:
                  (context, rotationAngle) => Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Слайдер
                      RepaintBoundary(
                        child: Slider(
                          value: rotationAngle,
                          min: -math.pi,
                          max: math.pi,
                          onChanged: (value) {
                            context.read<TriangleRotationCubit>().setRotation(value);
                            //  BlocProvider.of<TriangleRotationCubit>(context).setRotation(value); // Рекомендований метод?
                          },
                        ),
                      ),
                      Text('Current Degrees: ${(rotationAngle * 180 / math.pi).toStringAsFixed(2)}°'),
                      const Spacer(),
                      // Фігури
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

  Widget setStep(BuildContext context, String text, double step) {
    return ElevatedButton(
      onPressed: () {
        context.read<TriangleRotationCubit>().setStep(step);
      },
      child: Text(text),
    );
  }

  Widget setZero(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<TriangleRotationCubit>().setZero();
      },
      child: const Text('0'),
    );
  }
}
