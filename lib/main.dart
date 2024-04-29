import 'package:animation_flutter/circle_animaton.dart';
import 'package:animation_flutter/cube_animation.dart';
import 'package:animation_flutter/simple_rect_animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {  
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: CubeAnimation(),
        ),
      ),
    );
  }
}
