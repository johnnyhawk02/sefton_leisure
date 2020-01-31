import 'package:sefton_leisure/utils.dart';

abstract class TimeTable {
  static String closing = '22:15';
  static String opening = '06:15';
  static double get left => Utils.convertStringTimeToDouble(opening);
  static double get right => Utils.convertStringTimeToDouble(closing);
  static double get yOffset => 100;
  static double get multiplier => 1 / (right - left);
}