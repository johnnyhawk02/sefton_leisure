import 'package:sefton_leisure/utils.dart';

abstract class TimeTable {
  static String closing = '22:30';
  static String opening = '06:00';
  static double get left => Utils.convertStringTimeToDouble(opening);
  static double get right => Utils.convertStringTimeToDouble(closing);
  static double get headerHeight => 50;
  static double get multiplier => 1 / (right - left);
}