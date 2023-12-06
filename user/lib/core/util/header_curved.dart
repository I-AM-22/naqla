import 'package:flutter/cupertino.dart';
import 'dart:ui' as ui;
import 'package:user/core/util/extensions/build_context.dart';

class HeaderCurvedContainer extends CustomPainter {
  final BuildContext context;

  HeaderCurvedContainer({super.repaint, required this.context});
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..shader = ui.Gradient.linear(const Offset(0, 150), const Offset(0, 0),
          [const Color(0xFFA78BFA), context.colorScheme.primary]);
    Path path = Path()
      ..relativeLineTo(0, 190)
      ..quadraticBezierTo(size.width / 2, 255.0, size.width, 190)
      ..relativeLineTo(0, -190)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
