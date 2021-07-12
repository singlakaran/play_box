import 'dart:math';

class Util {
  static Map getRandomXandYCoordinate(
      {required int xMaxValue, required int yMaxValue}) {
    var _random = new Random();
    Map data = Map();
    data['x'] = _random.nextInt(xMaxValue);
    data['y'] = _random.nextInt(yMaxValue);
    return data;
  }
}
