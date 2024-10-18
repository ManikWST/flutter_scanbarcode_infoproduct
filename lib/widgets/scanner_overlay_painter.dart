import 'package:flutter/material.dart';

class ScannerOverlayPainter extends CustomPainter {
  final Animation<double> animation;

  ScannerOverlayPainter({required this.animation}) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    final double cornerSize = size.width * 0.1;

    // Top-left corner
    canvas.drawLine(Offset(0, 0), Offset(0, cornerSize), paint);
    canvas.drawLine(Offset(0, 0), Offset(cornerSize, 0), paint);

    // Top-right corner
    canvas.drawLine(
        Offset(size.width, 0), Offset(size.width - cornerSize, 0), paint);
    canvas.drawLine(
        Offset(size.width, 0), Offset(size.width, cornerSize), paint);

    // Bottom-left corner
    canvas.drawLine(
        Offset(0, size.height), Offset(cornerSize, size.height), paint);
    canvas.drawLine(
        Offset(0, size.height), Offset(0, size.height - cornerSize), paint);

    // Bottom-right corner
    canvas.drawLine(Offset(size.width, size.height),
        Offset(size.width - cornerSize, size.height), paint);
    canvas.drawLine(Offset(size.width, size.height),
        Offset(size.width, size.height - cornerSize), paint);

    // Scan line animation
    final scanPaint = Paint()
      ..color = Colors.red.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    final scanLineY = size.height * animation.value;
    canvas.drawRect(
        Rect.fromLTRB(0, scanLineY, size.width, scanLineY + 5), scanPaint);
  }

  @override
  bool shouldRepaint(ScannerOverlayPainter oldDelegate) {
    return true;
  }
}
