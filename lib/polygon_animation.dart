import 'dart:math';

import 'package:flutter/material.dart';

class PolygonAnimation extends StatefulWidget {
  const PolygonAnimation({super.key});

  @override
  State<PolygonAnimation> createState() => _PolygonAnimationState();
}

class _PolygonAnimationState extends State<PolygonAnimation>
    with TickerProviderStateMixin {
  late AnimationController _sideController;
  late Animation<int> _sideAnimation;

  late AnimationController _radiusController;
  late Animation<double> _radiusAnimation;

  late AnimationController _rotationController;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();

    _sideController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _radiusController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _sideAnimation = IntTween(begin: 3, end: 10).animate(_sideController);

    _radiusAnimation = Tween<double>(begin: 40, end: 400)
        .chain(CurveTween(curve: Curves.bounceInOut))
        .animate(_radiusController);

    _rotationAnimation = Tween<double>(begin: 0, end: 2 * pi).animate(
      CurvedAnimation(
        parent: _rotationController,
        curve: Curves.easeInOut,
      ),
    );

    _sideController.repeat(reverse: true);
    _radiusController.repeat(reverse: true);
    _rotationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _sideController.dispose();
    _radiusController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: AnimatedBuilder(
              animation: Listenable.merge([
                _sideController,
                _radiusController,
                _rotationController,
              ]),
              builder: (context, child) {
                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..rotateX(_rotationAnimation.value)
                    ..rotateY(_rotationAnimation.value)
                    ..rotateZ(_rotationAnimation.value),
                  child: SizedBox(
                    width: _radiusAnimation.value,
                    height: _radiusAnimation.value,
                    child: CustomPaint(
                      painter: Polygon(side: _sideAnimation.value),
                    ),
                  ),
                );
              })),
    );
  }
}

class Polygon extends CustomPainter {
  final int side;

  Polygon({required this.side});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    final path = Path();

    final center = Offset(size.width / 2, size.height / 2);

    final angle = (2 * pi) / side;

    final angles = List.generate(side, (index) => index * angle);

    final radius = size.width / 2;

    path.moveTo(center.dx + radius * cos(0), center.dy + radius * sin(0));

    for (var item in angles) {
      path.lineTo(
          center.dx + radius * cos(item), center.dy + radius * sin(item));
    }

    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate is Polygon && oldDelegate.side != side;
  }
}
