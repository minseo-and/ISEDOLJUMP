import 'package:flutter/material.dart';
import 'dart:math' as math;

class MyBarrier extends StatelessWidget {
  final dimension;
  final double degrees;
  final int randomIndex;

  const MyBarrier(
      {super.key,
        required this.dimension,
        required this.degrees,
        required this.randomIndex});

  @override
  Widget build(BuildContext context) {
    List<String> imagePath = [
      'assets/images/barrier1.png',
      'assets/images/barrier2.png',
      'assets/images/barrier3.png',
      'assets/images/barrier4.png'
    ];

    double radians = degrees * math.pi / 180;

    double height = MediaQuery.of(context).size.height;
    

    return Container(
        width: dimension * 0.5,
        height: dimension,
        child: Transform.rotate(
          angle: radians,
          child: Image.asset(
            imagePath[randomIndex],
            fit: BoxFit.fill,
          ),
        ));
  }
}
