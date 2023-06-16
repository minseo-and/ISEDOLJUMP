import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sedol_jump/entity/barriers.dart';
import 'package:sedol_jump/entity/player.dart';
import 'package:sedol_jump/provider/game_provider.dart';
import 'package:sedol_jump/screen/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../provider/score_provider.dart';

class Game extends StatefulWidget {
  const Game({Key? key}) : super(key: key);

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {


  double playerYaxis = 0;
  bool musicOn = true;
  double time = 0;
  double height = 0;
  double initialHeight = 0;
  static double barrierXone = 1;
  double barrierXtwo = barrierXone + 1.5;

  int _counter = 0;
  int best = 0;
  Timer? _timer;
  double maxNumber = 100;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        context.read<Score>().add();
      });
    });
  }

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


  void startGame() async {
    context.read<GameDone>().startGame();
    Timer.periodic(Duration(milliseconds: 60), (timer) {
      time += 0.05;
      height = -4.9 * time * time + 2.8 * time;
      setState(() {
        playerYaxis = initialHeight - height;
      });


      if(playerIsDead()) {
        timer.cancel();
        setState(() {
          context.read<GameDone>().stopGame();
          _showDialog();
        });
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
    });
  }

  @override
  Widget build(BuildContext context) {
    bool playing = context.watch<GameDone>().playing;
    double height = MediaQuery.of(context).size.height;
    print(time.toString());
    print(playerYaxis.toString());
    return GestureDetector(
      onTap:playing ? jump : startGame,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/game_bg.png'), // 배경 이미지
              ),
            ),
            child: AnimatedContainer(
              alignment: Alignment(0, playerYaxis),
              duration: Duration(milliseconds: 0),
              child: Player(),
            ),
          ),
          barriers(barrierXone, 1.1, height * 0.2, 0, 0),
          barriers(barrierXone, -1.1, height * 0.25, 180, 1),
          barriers(barrierXtwo, 1.1, height * 0.2, 0, 2),
          barriers(barrierXtwo, -1.1, height * 0.25, 180, 3),
          Container(
            alignment: Alignment(0, -0.3),
            child: playing ? Text('') :
            Text("시작하려면 화면을 터치하세요",
              style: TextStyle(fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.yellow),),
          ),
        ],
      ),
    );
  }

  void _showDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.brown,
          title: Text(
            "끝!",
            style: TextStyle(color: Colors.white),
          ),
          content: _counter > best ? Text('Wow 최고점수') : Text('Score: $_counter' + '모시깽이한 점수네요'),
          actions: [
            GestureDetector(
              onTap: () {
                playerYaxis = 0;
                musicOn = true;
                time = 0;
                height = 0;
                initialHeight = 0;
                barrierXone = 1;
                barrierXtwo = barrierXone + 1.5;

                _counter = 0;
                best = 0;
                _timer;
                maxNumber = 100;
                Navigator.pop(context);
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
      },
    );
  }


  AnimatedContainer barriers(double x, double y, double size, double degrees, int randomIndex) {
    return AnimatedContainer(
      alignment: Alignment(x, y),
      duration: Duration(milliseconds: 0),
      child: MyBarrier(dimension: size, degrees: degrees, randomIndex: randomIndex,),
    );
  }

}
