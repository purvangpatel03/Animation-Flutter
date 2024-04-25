import 'dart:math';

import 'package:flutter/material.dart';

class CubeAnimation extends StatefulWidget {
  const CubeAnimation({super.key});

  @override
  State<CubeAnimation> createState() => _CubeAnimationState();
}

class _CubeAnimationState extends State<CubeAnimation>
    with TickerProviderStateMixin {
  late AnimationController _xController;
  late AnimationController _yController;
  late AnimationController _zController;
  late Tween<double> _animationTween;

  @override
  void initState() {
    super.initState();
    _xController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    );
    _yController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    );
    _zController = AnimationController(
      duration: const Duration(seconds: 30),
      vsync: this,
    );

    _animationTween = Tween<double>(begin: 0, end: 2 * pi);
  }

  @override
  Widget build(BuildContext context) {
    _xController
      ..forward()
      ..repeat();

    _yController
      ..forward()
      ..repeat();

    _zController
      ..forward()
      ..repeat();

    return Center(
      child: AnimatedBuilder(
          animation:
              Listenable.merge([_xController, _yController, _zController]),
          builder: (context, child) {
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..rotateX(_animationTween.evaluate(_xController))
                ..rotateY(_animationTween.evaluate(_yController))
                ..rotateZ(_animationTween.evaluate(_zController)),
              child: Stack(
                children: [
                  Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..setTranslationRaw(0,0,-100),
                    child: Container(
                      height: 100,
                      width: 100,
                      color: Colors.red,
                    ),
                  ),
                  Transform(
                    alignment: Alignment.centerLeft,
                    transform: Matrix4.identity()..rotateY(pi / 2),
                    child: Container(
                      height: 100,
                      width: 100,
                      color: Colors.purpleAccent,
                    ),
                  ),
                  Transform(
                    alignment: Alignment.centerRight,
                    transform: Matrix4.identity()..rotateY(-pi / 2),
                    child: Container(
                      height: 100,
                      width: 100,
                      color: Colors.blue,
                    ),
                  ),
                  Transform(
                    alignment: Alignment.topCenter,
                    transform: Matrix4.identity()..rotateX(-pi / 2),
                    child: Container(
                      height: 100,
                      width: 100,
                      color: Colors.yellow,
                    ),
                  ),
                  Transform(
                    alignment: Alignment.bottomCenter,
                    transform: Matrix4.identity()..rotateX(pi / 2),
                    child: Container(
                      height: 100,
                      width: 100,
                      color: Colors.brown,
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    color: Colors.green,
                  ),
                ],
              ),
            );
          }),
    );
  }
}
