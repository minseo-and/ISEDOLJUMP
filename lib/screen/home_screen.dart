import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sedol_jump/barriers.dart';
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
  static double barrierXone = 1;
  double barrierXtwo = barrierXone + 1.5;

  void jump() {
    setState(() {
      time = 0;
      initialHeight = playerYaxis;
    });
  }

  bool playerIsDead() {
    if( playerYaxis < -1 || playerYaxis > 1) {
      return true;
    }
    return false;
  }

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(Duration(milliseconds: 60), (timer) {
      time += 0.05;
      height = -4.9 * time * time + 2.8 * time;
      setState(() {
        playerYaxis = initialHeight - height;
      });

      if(playerYaxis < -1 || playerYaxis > 1) {
        timer.cancel();
      }

      if(playerIsDead()) {
        timer.cancel();
        gameHasStarted = false;
        _showDialog();
      }

      setState(() {
        if (barrierXone < -2) {
          barrierXone += 3.5;
        } else {
          barrierXone -= 0.05;
        }
      });

      setState(() {
        if (barrierXtwo < -2) {
          barrierXtwo += 3.5;
        } else {
          barrierXtwo -= 0.05;
        }
      });

      if (playerYaxis > 1) {
        timer.cancel();
        gameHasStarted = false;
      }
    });
  }


  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: gameHasStarted ? jump : startGame,
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: Stack(
                children: [

                    AnimatedContainer(
                      alignment: Alignment(0, playerYaxis),
                      duration: Duration(milliseconds: 0),
                      color: Colors.lightBlueAccent,
                      child: Player(),
                    ),
                  Container(
                    alignment: Alignment(0, -0.3),
                    child: gameHasStarted ? Text('') :
                    Text("시작하려면 화면을 터치하세요",
                    style: TextStyle(fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.yellow),),
                  ),
                  barriers(barrierXone, 1.1, 200.0, 0),
                  barriers(barrierXone, -1.1, 200.0, 180),
                  barriers(barrierXtwo, 1.1, 150.0, 0),
                  barriers(barrierXtwo, -1.1, 250.0, 180),

                ],
              )
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
      ),
    );
  }

  AnimatedContainer barriers(double x, double y, double size, double degrees) {
    return AnimatedContainer(
                alignment: Alignment(x, y),
                  duration: Duration(milliseconds: 0),
                child: MyBarrier(size: size, degrees: degrees,),
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
  void _showDialog() {
    showDialog(context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.brown,
            title: Text(
              "끝!",
              style: TextStyle(color: Colors.white),
            ),
            content: Text(
              'Score: ' + score.toString()
            ),
            actions: [
              GestureDetector(
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder:
                  (context) => HomeScreen()));
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    padding: EdgeInsets.all(7),
                    color: Colors.white,
                    child: Text(
                      '다시하기',
                      style: TextStyle(color: Colors.brown),
                    ),
                  ),
                ),
              )
            ],

          );
        });
  }

}
