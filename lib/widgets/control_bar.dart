import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(onPressed: () {}, child: const Text('Button 1')),
            ElevatedButton(onPressed: () {}, child: const Text('Button 2')),
            ElevatedButton(onPressed: () {}, child: const Text('Button 3')),
          ],
        ),

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
        Figures(angle: _rotationAngle),
      ],
    );
  }
}

//   Widget _button(String text, double step) {
//     return ElevatedButton(
//       onPressed: () {
//         setState(() {
//           _rotationAngle += step;
//         });
//         _rotationAngle = (_rotationAngle).clamp(-math.pi, math.pi);
//       },
//       child: Text(text),
//     );
//   }


// _button('-10°', -math.pi / 18),
//                           ElevatedButton(
//                             onPressed: () {
//                               setState(() {
//                                 _rotationAngle = 0;
//                               });
//                             },
//                             child: Text('0'),
//                           ),
//                           _button('+10°', math.pi / 18),