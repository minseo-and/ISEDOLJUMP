import 'dart:async';
import 'dart:math';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:sedol_jump/entity/barriers.dart';
import 'package:sedol_jump/entity/player.dart';
import 'package:shared_preferences/shared_preferences.dart';

late AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer.newPlayer();

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  AudioCache player = new AudioCache();

  int _counter = 0;
  int best = 0;
  Timer? _timer;




  @override
  void initState() {
    super.initState();

    _assetsAudioPlayer.open(
      Audio("assets/audios/bgm.mp3"),
      loopMode: LoopMode.single, //반복 여부 (LoopMode.none : 없음)
      autoStart: true, //자동 시작 여부
      showNotification: false, //스마트폰 알림 창에 띄울지 여부
    );

    _assetsAudioPlayer.play();

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        gameHasStarted ? _counter++ : _counter=0;
      });
    });
  }


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

      if(playerYaxis > 0) {
        if(barrierXtwo <= 0.1 && (playerYaxis >= 0.3 || playerYaxis <= -0.3)){
          timer.cancel();
          gameHasStarted = false;
          _showDialog();
        } else if(barrierXtwo <= 0.1 && (playerYaxis >= 0.3 || playerYaxis <= -0.3)){
          timer.cancel();
          gameHasStarted = false;
          _showDialog();
        }
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
                  barriers(barrierXone, 1.1, 200.0, 0, 0),
                  barriers(barrierXone, -1.1, 200.0, 180, 1),
                  barriers(barrierXtwo, 1.1, 150.0, 0, 2),
                  barriers(barrierXtwo, -1.1, 250.0, 180, 3),

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
                  score('SCORE', _counter),
                  score('BEST', _counter > best ? best = _counter : best),
                ],
              ),
            ),
            ),
          ],
        )
      ),
    );
  }


  AnimatedContainer barriers(double x, double y, double size, double degrees, int randomIndex) {
    return AnimatedContainer(
                alignment: Alignment(x, y),
                  duration: Duration(milliseconds: 0),
                child: MyBarrier(size: size, degrees: degrees, randomIndex: randomIndex,),
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
            content: _counter > best ? Text(
              'Wow 최고점수'
            ) : Text(
                'Score: $_counter' + '모시깽이한 점수네요'
            ),
            actions: [
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder:
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
