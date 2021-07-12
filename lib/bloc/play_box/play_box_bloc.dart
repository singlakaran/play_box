import 'dart:async';
import 'package:box_game/bloc/play_box/play_box_event.dart';
import 'package:box_game/bloc/play_box/play_box_state.dart';
import 'package:box_game/utils/constants.dart';
import 'package:box_game/utils/util.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlayBoxBloc extends Bloc<PlayBoxEvent, PlayBoxState> {
  final int totalBoxes;
  final int boxCountRow;
  @override
  Stream<PlayBoxState> mapEventToState(
    PlayBoxEvent event,
  ) async* {
    if (event is LoadPlayBox) {
      yield* _mapLoadPlayBoxToState(totalBoxes, boxCountRow);
    } else if (event is ChangePlayerPositionOnBox) {
      yield* _mapChangePlayerPositionToState(
          event.gestureType, totalBoxes, boxCountRow, state);
    }
  }

  PlayBoxBloc({required this.totalBoxes, required this.boxCountRow})
      : super(PlayBoxLoading());
}

Stream<PlayBoxState> _mapLoadPlayBoxToState(
    int totalBoxes, int boxCountRow) async* {
  try {
    Map playerCoordinate = Util.getRandomXandYCoordinate(
        xMaxValue: boxCountRow - 1, yMaxValue: (totalBoxes ~/ boxCountRow) - 1);
    Map treasureCoordinate = Util.getRandomXandYCoordinate(
        xMaxValue: boxCountRow - 1, yMaxValue: (totalBoxes ~/ boxCountRow) - 1);

    yield PlayBoxLoaded(
        playerValue: playerCoordinate, treasureValue: treasureCoordinate);
  } catch (error) {
    yield PlayBoxNotLoaded();
  }
}

Stream<PlayBoxState> _mapChangePlayerPositionToState(GestureType gestureType,
    int totalBoxes, int boxCountRow, currentState) async* {
  try {
    if (currentState is PlayBoxLoaded) {
      Map playerValue = currentState.playerValue;
      Map treasureValue = currentState.treasureValue;
      if (gestureType == GestureType.bottom) {
        playerValue['y'] = playerValue['y'] + 1;
        if (playerValue['y'] >= (totalBoxes / boxCountRow)) {
          playerValue['y'] = 0;
        }
      } else if (gestureType == GestureType.top) {
        playerValue['y'] = playerValue['y'] - 1;
        if (playerValue['y'] < 0) {
          playerValue['y'] = (totalBoxes / boxCountRow) - 1;
        }
      } else if (gestureType == GestureType.left) {
        playerValue['x'] = playerValue['x'] - 1;
        if (playerValue['x'] < 0) {
          playerValue['x'] = boxCountRow - 1;
        }
      } else if (gestureType == GestureType.right) {
        playerValue['x'] = playerValue['x'] + 1;
        if (playerValue['x'] >= boxCountRow) {
          playerValue['x'] = 0;
        }
      }
      yield PlayBoxLoaded(
          playerValue: playerValue, treasureValue: treasureValue);

      if (playerValue['x'] == treasureValue['x'] &&
          playerValue['y'] == treasureValue['y']) {
        yield PlayBoxLoaded(
            playerValue: playerValue,
            treasureValue: treasureValue,
            isEqualBothValues: true);
      }
    }
  } catch (error) {
    yield PlayBoxNotLoaded();
  }
}
