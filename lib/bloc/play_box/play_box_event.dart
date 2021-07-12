import 'package:box_game/utils/constants.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PlayBoxEvent {
  PlayBoxEvent() : super();
}

class LoadPlayBox extends PlayBoxEvent {
  @override
  String toString() => 'LoadPlayBox';
}

class ChangePlayerPositionOnBox extends PlayBoxEvent {
  final GestureType gestureType;

  ChangePlayerPositionOnBox(this.gestureType);

  @override
  String toString() => 'ChangePlayerPositionOnBox';
}

class ResetPlayBox extends PlayBoxEvent {
  @override
  String toString() => 'ResetPlayBox';
}
