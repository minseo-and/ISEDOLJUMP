import 'package:flutter/material.dart';

class GameDone extends ChangeNotifier {
  bool playing = false;

  void startGame() {
    playing = true;
    notifyListeners();
  }

  void stopGame() {
    playing = false;
    notifyListeners();
  }
}