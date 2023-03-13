import 'package:flutter/material.dart';
import 'package:sedol_jump/entity/player.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  double playerYaxis = 0;

  void jump() {
    setState(() {
      playerYaxis -= 0.1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: jump,
              child: AnimatedContainer(
                alignment: Alignment(0, playerYaxis),
              duration: Duration(milliseconds: 0),
              color: Colors.lightBlueAccent,
                child: Player(),
              ),
            ),
          ),
          Expanded(child: Container(
            color: Color(0xFFFFF8BE),
          ),
          ),
        ],
      )
    );
  }
}
