import 'package:flutter/material.dart';
import 'dart:math' as math;

class CircleView extends StatelessWidget {
  final Color color;
  final double angle;
  final double padding;
  final double strokeWidth;
  CircleView({
    @required this.color = Colors.black,
    this.angle = 2 * math.pi,
    this.padding = 8.0,
    this.strokeWidth = 10.0,
  });
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _CirclePainter(
        color: color,
        angle: angle,
        padding: padding,
        strokeWidth: strokeWidth,
      ),
      child: Container(),
    );
  }
}

class _CirclePainter extends CustomPainter {
  final Color color;
  final double angle;
  final double padding;
  final double strokeWidth;
  _CirclePainter(
      {@required this.color = Colors.black,
      this.angle = 0.0,
      this.padding = 8.0,
      this.strokeWidth = 10.0});

  double getSize(Size size) {
    if (size.width > size.height) {
      return size.height - padding - strokeWidth;
    }
    return size.width - padding - strokeWidth;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Offset center = Offset(size.width / 2, size.height / 2);

    canvas.drawArc(
      Rect.fromCenter(
        center: center,
        width: getSize(size),
        height: getSize(size),
      ),
      0,
      angle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
