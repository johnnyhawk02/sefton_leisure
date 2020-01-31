import 'package:sefton_leisure/time_table.dart';
import 'package:sefton_leisure/utils.dart';




class GridLines {
  String time;
  bool bold;

  GridLines({
    this.time,
    this.bold,
  });

  double get left =>
      (Utils.convertStringTimeToDouble(time) - TimeTable.left) *
      TimeTable.multiplier;

  double get width => bold ? 2 : 1;
}
