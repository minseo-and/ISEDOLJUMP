import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sedol_jump/provider/player_provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
              flex: 1,
              child: row_image(context, ine(context, 'assets/images/ine.png'), jingburger(context, 'assets/images/jingburger.png'))),
          Expanded(
              flex: 1,
              child: row_image(context, gosegu(context, 'assets/images/gosegu.png'), lilpa(context, 'assets/images/lilpa.png'))),
          Expanded(
              flex: 1,
              child: row_image(context, jururu(context, 'assets/images/jururu.png'), viichan(context, 'assets/images/viichan.png')))
        ],
      ),
    );
  }

  Row row_image(BuildContext context ,Widget character1, Widget character2) {
    return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [character1, character2],
            );
  }

  Expanded viichan(BuildContext context, String image) {
    return tab_avatar(context, image, 'viichan');
  }

  Expanded jururu(BuildContext context, String image) {
    return tab_avatar(context, image, 'jururu');
  }

  Expanded lilpa(BuildContext context, String image) {
    return tab_avatar(context, image, 'lilpa');
  }

  Expanded gosegu(BuildContext context, String image) {
    return tab_avatar(context, image, 'gosegu');
  }

  Expanded jingburger(BuildContext context, String image) {
    return tab_avatar(context, image, 'jingburger');
  }

  Expanded ine(BuildContext context, String image) {
    return tab_avatar(context, image, 'ine');
  }

  Expanded tab_avatar(BuildContext context, String image, String avatar) {
    return Expanded(
        flex: 1,
        child: GestureDetector(
          onTap: () {
            _setSelectedAvatar(context, avatar);
            Navigator.pop(context);
          },
          child: Image.asset(image),
        ));
  }

  void _setSelectedAvatar(BuildContext context, String character) {
    final avatarProvider = context.read<Avatar>();
    // 문자열로 조건 분기하여 해당 캐릭터에 대한 함수 호출
    switch(character) {
      case 'viichan':
        avatarProvider.viichan();
        break;
      case 'jururu':
        avatarProvider.jururu();
        break;
      case 'lilpa':
        avatarProvider.lilpa();
        break;
      case 'gosegu':
        avatarProvider.gosegu();
        break;
      case 'jingburger':
        avatarProvider.jingburger();
        break;
      case 'ine':
        avatarProvider.ine();
        break;
      default:
        break;
    }
  }
}
