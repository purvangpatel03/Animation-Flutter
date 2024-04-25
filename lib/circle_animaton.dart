import 'dart:math';

import 'package:flutter/material.dart';

class CircleAnimation extends StatefulWidget {
  const CircleAnimation({super.key});

  @override
  State<CircleAnimation> createState() => _CircleAnimationState();
}


extension on VoidCallback{
  Future<void> delayed(Duration duration) =>
      Future.delayed(duration, this);
}

class _CircleAnimationState extends State<CircleAnimation>
    with TickerProviderStateMixin {
  late AnimationController counterClockwiseController;
  late Animation<double> counterClockAnimation;

  late AnimationController flippedAnimationController;
  late Animation<double> flippedAnimation;
  
  @override
  void initState() {
    super.initState();
    counterClockwiseController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    counterClockAnimation = Tween<double>(
      begin: 0,
      end: -pi / 2,
    ).animate(CurvedAnimation(
        parent: counterClockwiseController, curve: Curves.bounceOut));

    flippedAnimationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    flippedAnimation = Tween<double>(
      begin: 0,
      end: pi,
    ).animate(CurvedAnimation(
        parent: flippedAnimationController, curve: Curves.bounceOut));

    counterClockwiseController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        flippedAnimation = Tween<double>(
          begin: flippedAnimation.value,
          end: flippedAnimation.value + pi,
        ).animate(CurvedAnimation(
            parent: flippedAnimationController, curve: Curves.bounceOut));
        flippedAnimationController
          ..reset()
          ..forward();
      }
    });

    flippedAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        counterClockAnimation = Tween<double>(
          begin: counterClockAnimation.value,
          end: counterClockAnimation.value - pi / 2,
        ).animate(CurvedAnimation(
            parent: counterClockwiseController, curve: Curves.bounceOut));
        counterClockwiseController
          ..reset()
          ..forward();
      }
    });
  }

  @override
  void dispose() {
    counterClockwiseController.dispose();
    flippedAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    counterClockwiseController
      ..reset()
      ..forward.delayed(const Duration(seconds: 1));
    return Center(
      child: AnimatedBuilder(
          animation: counterClockwiseController,
          builder: (context, child) {
            return AnimatedBuilder(
                animation: flippedAnimation,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: counterClockAnimation.value,
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..rotateY(flippedAnimation.value),
                      child: CustomPaint(
                        painter: CustomCircle(),
                        child: const SizedBox(
                          width: 200,
                          height: 200,
                        ),
                      ),
                    ),
                  );
                });
          }),
    );
  }
}

class CustomCircle extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
     Paint paint = Paint();
     paint.color = Colors.blue;
    Rect rect = Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2), radius: 100);
    canvas.drawArc(rect, pi / 2, pi, true, paint);
    paint.color = Colors.yellow;
    Rect rect2 = Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2), radius: 100);
    canvas.drawArc(rect2, -pi / 2, pi, true, paint);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
