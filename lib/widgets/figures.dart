import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math' as math;

import 'package:my_test_app/widgets/control_bar.dart';

class Figures extends StatelessWidget {
  const Figures({super.key, required this.angle});
  final double angle;
  @override
  Widget build(BuildContext context) {
    return Container(child: CustomPaint(size: Size(200, 200), painter: MyPainter(angle)));
  }
}

class MyPainter extends CustomPainter {
  MyPainter(this.angle);
  final double angle;
  final double offset = math.pi / 2;
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2;
    final radiusWithPadding = radius - 12;
    final circle =
        Paint()
          ..color = Colors.blue
          ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius, circle);

    final triangle =
        Paint()
          ..color = Colors.green
          ..style = PaintingStyle.fill;
    final trianglePath =
        Path()
          ..moveTo(center.dx + radiusWithPadding * math.cos(angle - offset), center.dy + radiusWithPadding * math.sin(angle - offset))
          ..lineTo(
            center.dx + radiusWithPadding * math.cos(angle + math.pi * 2 / 3 - offset),
            center.dy + radiusWithPadding * math.sin(angle + math.pi * 2 / 3 - offset),
          )
          ..lineTo(
            center.dx + radiusWithPadding * math.cos(angle + math.pi * 4 / 3 - offset),
            center.dy + radiusWithPadding * math.sin(angle + math.pi * 4 / 3 - offset),
          )
          ..close();
    canvas.drawPath(trianglePath, triangle);
  }

  @override
  bool shouldRepaint(MyPainter oldDelegate) => oldDelegate.angle != angle;
}
