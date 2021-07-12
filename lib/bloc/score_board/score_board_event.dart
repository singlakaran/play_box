import 'package:meta/meta.dart';

@immutable
abstract class ScoreBoardEvent {
  ScoreBoardEvent() : super();
}

class LoadScoreBoard extends ScoreBoardEvent {
  @override
  String toString() => 'LoadScoreBoard';
}

class IncrementScore extends ScoreBoardEvent {
  @override
  String toString() => 'IncrementScore';
}
