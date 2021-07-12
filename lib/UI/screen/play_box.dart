import 'package:box_game/UI/molecule/player.dart';
import 'package:box_game/UI/molecule/treasure.dart';
import 'package:box_game/UI/widgets/score_board.dart';
import 'package:box_game/bloc/play_box/play_box.dart';
import 'package:box_game/bloc/score_board/score_board.dart';
import 'package:box_game/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';

class PlayBox extends StatelessWidget {
  final totalBox = Constants.TOTAL_BOXES;
  final boxCountRow = Constants.BOX_ROW_COUNT;
  final PlayBoxBloc _playBoxBloc = PlayBoxBloc(
      totalBoxes: Constants.TOTAL_BOXES, boxCountRow: Constants.BOX_ROW_COUNT);
  final ScoreBoardBloc _scoreBoardBloc = ScoreBoardBloc();
  PlayBox() {
    _playBoxBloc.add(LoadPlayBox());
    _scoreBoardBloc.add(LoadScoreBoard());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener(
          bloc: _playBoxBloc,
          listener: (context, state) {
            if (state is PlayBoxLoaded) {
              if (state.isEqualBothValues) {
                _scoreBoardBloc.add(IncrementScore());
                _playBoxBloc.add(LoadPlayBox());
              }
            }
          },
        ),
        BlocListener(
          bloc: _scoreBoardBloc,
          listener: (context, state) {
            if (state is ScoreBoardLoaded) {
              if (state.currentScore == state.totalScore) {
                _scoreBoardBloc.add(LoadScoreBoard());
                _playBoxBloc.add(LoadPlayBox());
              }
            }
          },
        ),
      ],
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            BlocBuilder(
              bloc: _scoreBoardBloc,
              builder: (context, state) {
                if (state is ScoreBoardLoaded) {
                  return ScoreBoard(
                    totalScore: state.totalScore,
                    currentScore: state.currentScore,
                  );
                } else {
                  return Container();
                }
              },
            ),
            SimpleGestureDetector(
              onVerticalSwipe: (direction) {
                if (direction == SwipeDirection.up) {
                  changePlayerPosition(GestureType.top);
                } else {
                  changePlayerPosition(GestureType.bottom);
                }
              },
              onHorizontalSwipe: (direction) {
                if (direction == SwipeDirection.left) {
                  changePlayerPosition(GestureType.left);
                } else {
                  changePlayerPosition(GestureType.right);
                }
              },
              child: BlocBuilder(
                bloc: _playBoxBloc,
                builder: (context, state) {
                  if (state is PlayBoxLoaded) {
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: totalBox,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: boxCountRow,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      itemBuilder: (
                        context,
                        index,
                      ) {
                        Map currentCoordinate = getCoordinateByIndex(
                            index + 1, boxCountRow, totalBox ~/ boxCountRow);
                        if (isEqualCoordinate(
                            currentCoordinate, state.playerValue)) {
                          return Player();
                        }
                        if (isEqualCoordinate(
                            currentCoordinate, state.treasureValue)) {
                          return Treasure();
                        }
                        return Container(
                          color: Colors.red,
                        );
                      },
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void changePlayerPosition(GestureType gestureType) {
    _playBoxBloc.add(ChangePlayerPositionOnBox(gestureType));
  }

  bool isEqualCoordinate(Map coordinate1, Map coordinate2) {
    if (coordinate1['x'] == coordinate2['x'] &&
        coordinate1['y'] == coordinate2['y']) {
      return true;
    }
    return false;
  }

  Map getCoordinateByIndex(int index, int xItemCount, int yItemCount) {
    Map data = Map();
    data['x'] = index % xItemCount == 0
        ? xItemCount - 1
        : (index % xItemCount).toInt() - 1;
    data['y'] = index % xItemCount == 0
        ? index ~/ xItemCount - 1
        : (index / xItemCount).floor();
    return data;
  }
}
