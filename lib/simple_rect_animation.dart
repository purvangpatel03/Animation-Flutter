import 'dart:math';

import 'package:flutter/material.dart';

class RectAnimation extends StatefulWidget {
  const RectAnimation({super.key});

  @override
  State<RectAnimation> createState() => _RectAnimationState();
}

class _RectAnimationState extends State<RectAnimation> with TickerProviderStateMixin{
  late AnimationController controller1;
  late Animation<Offset> animation1;
  late AnimationController controller2;
  late Animation<Offset> animation2;
  late AnimationController controller3;
  late Animation<Offset> animation3;
  late AnimationController controller4;
  late Animation<Offset> animation4;

  @override
  void initState() {
    super.initState();

    controller1 = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    animation1 = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(120, 0),
    ).animate(CurvedAnimation(parent: controller1, curve: Curves.easeInOutCubic));

    controller2 = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    animation2 = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(0, 120),
    ).animate(CurvedAnimation(parent: controller1, curve: Curves.easeInOutCubic));

    controller2 = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    animation2 = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(120, 0),
    ).animate(CurvedAnimation(parent: controller1, curve: Curves.easeInOutCubic));

    controller3 = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    animation3 = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(120, 0),
    ).animate(CurvedAnimation(parent: controller1, curve: Curves.easeInOutCubic));

    controller4 = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    animation4 = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(120, 0),
    ).animate(CurvedAnimation(parent: controller1, curve: Curves.easeInOutCubic));


    controller1.addStatusListener((status) {
      print(status);
      if(status == AnimationStatus.completed){
        animation2 = Tween<Offset>(
          begin: const Offset(120, 0),
          end: const Offset(0, 120),
        ).animate(CurvedAnimation(parent: controller2, curve: Curves.easeInOutCubic));
        controller2
          ..reset()
          ..forward();
      }
    });

  }
  @override
  Widget build(BuildContext context) {
    controller1
      ..reset()
      ..forward();
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()..rotateZ(pi / 4),
      child: AnimatedBuilder(
          animation: controller2,
          builder: (context, child) {
            return AnimatedBuilder(
              animation: controller1,
              builder: (context, child) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Transform.translate(
                          offset: animation1.value,
                          child: Transform.translate(
                            offset: animation2.value,
                            child: Container(
                              margin: const EdgeInsets.all(10),
                              height: 100,
                              width: 100,
                              color: Colors.red,
                            ),
                          ),
                        ),
                        Transform.translate(
                          offset: animation1.value,
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            height: 100,
                            width: 100,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Transform.translate(
                          offset: animation1.value,
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            height: 100,
                            width: 100,
                            color: Colors.green,
                          ),
                        ),
                        Transform.translate(
                          offset: animation1.value,
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            height: 100,
                            width: 100,
                            color: Colors.yellow,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            );
          }
      ),
    );
  }
}
