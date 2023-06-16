import 'package:flutter/material.dart';
import 'package:sedol_jump/provider/game_provider.dart';
import 'package:sedol_jump/provider/score_provider.dart';
import 'package:sedol_jump/screen/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Score()),
        ChangeNotifierProvider(create: (_) => GameDone()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
