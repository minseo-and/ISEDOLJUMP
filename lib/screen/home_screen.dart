import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sedol_jump/entity/player.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  double playerYaxis = 0;
  double time = 0;
  double height = 0;
  double initialHeight = 0;
  bool gameHasStarted = false;

  void jump() {
    setState(() {
      time = 0;
      initialHeight = playerYaxis;
    });
  }

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(Duration(milliseconds: 60), (timer) {
      time += 0.04;
      height = -4.9 * time * time + 2.8 * time;
      setState(() {
        playerYaxis = initialHeight - height;
      });
      if (playerYaxis > 1) {
        timer.cancel();
        gameHasStarted = false;
      }
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
              onTap: () {
                if(gameHasStarted) {
                  jump();
                } else {
                  startGame();
                }
              },
              child: AnimatedContainer(
                alignment: Alignment(0, playerYaxis),
              duration: Duration(milliseconds: 0),
              color: Colors.lightBlueAccent,
                child: Player(),
              ),
            ),
          ),
          Container(
            height: 20,
            color: Colors.blue,
          ),
          Expanded(child: Container(
            color: Color(0xFFFFF8BE),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                score('SCORE', 0),
                score('BEST', 10),
              ],
            ),
          ),
          ),
        ],
      )
    );
  }

  Column score( String name, int score) {
    return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(name, style: TextStyle(
                    color: Colors.pinkAccent, fontSize: 20
                  ),),
                  SizedBox(height: 20),
                  Text('$score', style: TextStyle(
                      color: Colors.lightBlue, fontSize: 35,
                    fontWeight: FontWeight.bold
                  ),)
                ],
              );
  }
}
