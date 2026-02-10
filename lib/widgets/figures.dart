import 'package:flutter/material.dart';
import 'dart:math' as math;

class Figures extends StatelessWidget {
  const Figures({super.key, required this.angle});
  final double angle;
  @override
  Widget build(BuildContext context) {
    return Container(child: CustomPaint(painter: MyPainter(angle)));
  }
}

class MyPainter extends CustomPainter {
  MyPainter(this.angle);
  final double angle;
  final double angleOffset = math.pi / 2;
  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = math.min(size.width, size.height) / 2;
    final radiusWithPadding = radius - 12;
    final circle =
        Paint()
          ..color = Colors.blue
          ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius, circle);

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(angle);

    final triangle =
        Paint()
          ..color = Colors.green
          ..style = PaintingStyle.fill;
    final trianglePath =
        Path()
          ..moveTo(radiusWithPadding * math.cos(-angleOffset), radiusWithPadding * math.sin(-angleOffset))
          ..lineTo(radiusWithPadding * math.cos(math.pi * 2 / 3 - angleOffset), radiusWithPadding * math.sin(math.pi * 2 / 3 - angleOffset))
          ..lineTo(radiusWithPadding * math.cos(math.pi * 4 / 3 - angleOffset), radiusWithPadding * math.sin(math.pi * 4 / 3 - angleOffset))
          ..close();

    final triangleElse =
        Paint()
          ..color = Colors.red
          ..style = PaintingStyle.fill;
    final pathElse = Path();
    for (int i = 0; i < 3; i++) {
      final vertex = -angleOffset + (i * math.pi * 2 / 3);
      final x = radius * math.cos(vertex);
      final y = radius * math.sin(vertex);
      if (i == 0) {
        pathElse.moveTo(x, y);
      } else {
        pathElse.lineTo(x, y);
      }
    }
    pathElse.close();

    canvas.drawPath(pathElse, triangleElse);
    canvas.drawPath(trianglePath, triangle);

    canvas.restore();
  }

  @override
  bool shouldRepaint(MyPainter oldDelegate) => oldDelegate.angle != angle;
}
