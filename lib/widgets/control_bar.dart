import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:my_test_app/widgets/figures.dart';

class ControlBar extends StatefulWidget {
  const ControlBar({super.key});

  @override
  State<ControlBar> createState() => _ControlBarState();
}

class _ControlBarState extends State<ControlBar> {
  double _rotationAngle = 0.0;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Кнопки
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [setStep('-10°', -math.pi / 18), setZero(), setStep('+10°', math.pi / 18)],
          ),
          const SizedBox(height: 20),
          // Слайдер
          Slider(
            value: _rotationAngle,
            min: -math.pi,
            max: math.pi,
            onChanged: (value) {
              setState(() {
                _rotationAngle = value;
              });
            },
          ),
          Text('Current Degrees: ${(_rotationAngle * 180 / math.pi).toStringAsFixed(1)}°'),
          const Spacer(),
          // Фігури
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: Padding(padding: const EdgeInsets.all(12), child: RepaintBoundary(child: Figures(angle: _rotationAngle))),
            ),
          ),
        ],
      ),
    );
  }

  Widget setStep(String text, double step) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _rotationAngle += step;
        });
        _rotationAngle = (_rotationAngle).clamp(-math.pi, math.pi);
      },
      child: Text(text),
    );
  }

  Widget setZero() {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _rotationAngle = 0;
        });
      },
      child: const Text('0'),
    );
  }
}
