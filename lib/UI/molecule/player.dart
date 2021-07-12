import 'package:box_game/styles.dart';
import 'package:box_game/utils/strings.dart';
import 'package:flutter/cupertino.dart';

class Player extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 20,
      color: Styles.blue,
      child: Center(
        child: Text(
          Strings.PLAYER,
          style: TextStyle(color: Styles.white, fontSize: 16),
        ),
      ),
    );
  }
}
