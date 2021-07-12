import 'dart:async';

import 'package:box_game/bloc/score_board/score_board_event.dart';
import 'package:box_game/bloc/score_board/score_board_state.dart';
import 'package:box_game/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScoreBoardBloc extends Bloc<ScoreBoardEvent, ScoreBoardState> {
  @override
  Stream<ScoreBoardState> mapEventToState(
    ScoreBoardEvent event,
  ) async* {
    if (event is LoadScoreBoard) {
      yield* _mapLoadScoreBoardToState();
    } else if (event is IncrementScore) {
      yield* _mapIncrementScoreToState(state);
    }
  }

  ScoreBoardBloc() : super(ScoreBoardLoading());
}

Stream<ScoreBoardState> _mapLoadScoreBoardToState() async* {
  try {
    yield ScoreBoardLoaded(currentScore: 0, totalScore: Constants.TOTAL_SCORE);
  } catch (error) {
    yield ScoreBoardNotLoaded();
  }
}

Stream<ScoreBoardState> _mapIncrementScoreToState(currentState) async* {
  try {
    if (currentState is ScoreBoardLoaded) {
      int totalScore = currentState.totalScore;
      int currentScore = currentState.currentScore + 1;
      yield ScoreBoardLoaded(
          totalScore: totalScore, currentScore: currentScore);
    }
  } catch (error) {
    yield ScoreBoardNotLoaded();
  }
}
