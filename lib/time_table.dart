import 'package:sefton_leisure/utils.dart';

abstract class TimeTable {
  static String closing = '22:00';
  static String opening = '06:30';

  TimeTable(){

  }
  static double get left => Utils.convertStringTimeToDouble(opening);
  static double get right => Utils.convertStringTimeToDouble(closing);
  static double get yOffset => 100;
  static double get multiplier => 1 / (right - left);
}