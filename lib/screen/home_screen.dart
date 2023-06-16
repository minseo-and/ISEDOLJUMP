import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sedol_jump/entity/barriers.dart';
import 'package:sedol_jump/entity/player.dart';
import 'package:flutter_provider/flutter_provider.dart';
import 'package:sedol_jump/provider/game_provider.dart';
import 'package:sedol_jump/provider/score_provider.dart';
import 'package:sedol_jump/screen/game.dart';
import 'package:shared_preferences/shared_preferences.dart';

late AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer.newPlayer();

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  int check = 0;
  int _counter = 0;
  int best = 0;
  Timer? _timer;
  double maxNumber = 100;


  @override
  void initState() {
    super.initState();

    _assetsAudioPlayer.open(
      Audio("assets/audios/game_bgm.mp3"),
      loopMode: LoopMode.single, //반복 여부 (LoopMode.none : 없음)
      showNotification: false, //스마트폰 알림 창에 띄울지 여부
    );



  }

  @override
  void dispose() {
    _assetsAudioPlayer.dispose(); // assets_audio_player 해제
    super.dispose();
  }

  bool musicOn = true;





  void music() {
    musicOn ? _assetsAudioPlayer.play() : _assetsAudioPlayer.pause();
  }


  @override
  Widget build(BuildContext context) {
    int my_score = context.watch<Score>().count;
    int score1 = 0;
    setState(() {
      score1 = my_score;
    });
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(onPressed: (){
            }, icon: Icon(Icons.volume_down)),
            IconButton(onPressed: (){
              setState(() {
                musicOn = !musicOn;
                music();
              });
            }, icon: musicOn ? Icon(Icons.music_note) : Icon(Icons.music_off)),
          ],
        ),
        body: ChangeNotifierProvider(
          create: (BuildContext context) => Score(),
          child: Column(
            children: [
              Expanded(
                  flex: 2,
                  child: Game()
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
                    score('SCORE', score1
                    ),
                    score('BEST', _counter > best ? best = _counter : best),
                  ],
                ),
              ),
              ),
            ],
          ),
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
