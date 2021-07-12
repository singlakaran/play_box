import 'package:box_game/styles.dart';
import 'package:box_game/utils/strings.dart';
import 'package:flutter/cupertino.dart';

class Treasure extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 20,
      color: Styles.green,
      child: Center(
        child: Text(
          Strings.TREASURE,
          style: TextStyle(color: Styles.white, fontSize: 12),
        ),
      ),
    );
  }
}
