import 'package:sefton_leisure/time_table.dart';
import 'package:flutter/material.dart';
import 'colors.dart';
import 'utils.dart' show Utils;


class Event {
  Map<String, double> daysIndex = {
    'Monday': 0,
    'Tuesday': 1,
    'Wednesday': 2,
    'Thursday': 3,
    'Friday': 4,
    'Saturday': 5,
    'Sunday': 6,
  };

  String site, siteShortName, name, type, info, day, start, finish;
  int clash;

  Event({
    this.site,
    this.siteShortName,
    this.name,
    this.type,
    this.info,
    this.day,
    this.start,
    this.finish,
    this.clash,
  });

  double get left =>
      (Utils.convertStringTimeToDouble(start) - TimeTable.left) *
      TimeTable.multiplier;
  double get right =>
      (Utils.convertStringTimeToDouble(finish) - TimeTable.left) *
      TimeTable.multiplier;
  double get width => right - left;
  double get height {
    if (clash == null   ) {
      return 1 / 7;
    } else {
      return 1 / 14;
    }
  }
  double get dayIndex => daysIndex[day];
  String get poolType {
    if (this.info.contains('Learner')) {
      return 'learner';
    } else if (this.info.contains('Main')) {
      return 'main';
    } else {
      return null;
    }
  }

  double get top {
  if (clash == null) {
    return daysIndex[day] * 1/7;
  } else {
    return (daysIndex[day] + (clash * 0.5)) * 1/7;
  }

  }

  String get shortName =>
      this.name.replaceAll('Les Mills ', '').replaceAll(' Virtual', '');

  bool get isVirtual => name.toLowerCase().contains('virtual');

  double get duration {
    return (Utils.convertStringTimeToDouble(finish) -
            Utils.convertStringTimeToDouble(start)) *
        60;
  }

  Color get classColor {
    print(this.day);
    if (classColors.containsKey(shortName)) {
      return classColors[shortName];
    } else {
      return Colors.grey;
    }
  }

  Color get dayColor {
    print(this.day);
    return dayColors[this.day];
  }

  Color get siteColor {
    return siteColors[this.site];
  }
}
