import 'package:meta/meta.dart';

@immutable
abstract class ScoreBoardState {
  ScoreBoardState() : super();
}

class ScoreBoardLoading extends ScoreBoardState {
  @override
  String toString() => 'ScoreBoardLoading';
}

class ScoreBoardLoaded extends ScoreBoardState {
  final int currentScore;
  final int totalScore;

  ScoreBoardLoaded({required this.currentScore, required this.totalScore})
      : super();

  @override
  String toString() => 'ScoreBoardLoaded';
}

class ScoreBoardNotLoaded extends ScoreBoardState {
  @override
  String toString() => 'ScoreBoardNotLoaded';
}
