import 'package:flutter/material.dart';
import 'dart:math' as math;

class MyBarrier extends StatelessWidget {

  final size;
  final double degrees;

  const MyBarrier({super.key, required this.size, required this.degrees});

  @override
  Widget build(BuildContext context) {

    double radians = degrees * math.pi / 180;
    return Container(
      width: 100,
      height: size,
      child: Transform.rotate(angle: radians,child:
      Image.asset('assets/images/barrier1.png', fit: BoxFit.fill,),)
    );
  }
}
