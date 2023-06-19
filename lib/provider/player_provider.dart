import 'package:flutter/material.dart';

class Avatar extends ChangeNotifier {
  String _avatar = 'assets/images/jingburger.png';
  String _bg = 'assets/images/rewind_bg.png';
  String get avatar => _avatar;
  String get bg => _bg;

  void jingburger() {
    _avatar = 'assets/images/jingburger.png';
    _bg = 'assets/images/game_bg.png';
    notifyListeners();
  }

  void ine() {
    _avatar = 'assets/images/ine.png';
    notifyListeners();
  }

  void jururu() {
    _avatar = 'assets/images/jururu.png';
    notifyListeners();
  }

  void lilpa() {
    _avatar = 'assets/images/lilpa.png';
    notifyListeners();
  }

  void viichan() {
    _avatar = 'assets/images/viichan.png';
    notifyListeners();
  }

  void gosegu() {
    _avatar = 'assets/images/gosegu.png';
    notifyListeners();
  }
}