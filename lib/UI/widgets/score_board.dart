import 'package:box_game/styles.dart';
import 'package:flutter/cupertino.dart';

class ScoreBoard extends StatelessWidget {
  final int totalScore;
  final int currentScore;
  ScoreBoard({required this.totalScore, this.currentScore = 0});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      color: Styles.green,
      child: Center(
        child: Text(
          '$currentScore / $totalScore',
          style: TextStyle(color: Styles.white, fontSize: 20),
        ),
      ),
    );
  }
}
