import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/player_provider.dart';

class Player extends StatelessWidget {
  const Player({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    String image = context.watch<Avatar>().avatar;
    return Container(
      height: height * 0.1,
      child: Image.asset(
          image
      ),
    );
  }
}
