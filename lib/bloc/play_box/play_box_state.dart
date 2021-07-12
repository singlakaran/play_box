import 'package:meta/meta.dart';

@immutable
abstract class PlayBoxState {
  PlayBoxState() : super();
}

class PlayBoxLoading extends PlayBoxState {
  @override
  String toString() => 'PlayBoxLoading';
}

class PlayBoxLoaded extends PlayBoxState {
  final Map treasureValue;
  final Map playerValue;
  final bool isEqualBothValues;

  PlayBoxLoaded(
      {required this.treasureValue,
      required this.playerValue,
      this.isEqualBothValues = false})
      : super();

  @override
  String toString() => 'PlayBoxLoaded';
}

class PlayBoxNotLoaded extends PlayBoxState {
  @override
  String toString() => 'PlayBoxNotLoaded';
}
