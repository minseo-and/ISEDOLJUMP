import 'package:flutter/material.dart';

class Player extends StatelessWidget {
  const Player({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      height: height * 0.1,
      child: Image.asset(
          'assets/images/jingburger.png'
      ),
    );
  }
}
