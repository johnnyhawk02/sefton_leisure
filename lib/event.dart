import 'package:sefton_leisure/time_table.dart';

 import 'package:flutter/material.dart';
import 'utils.dart' show Utils ;








class GridLines{

}



class Event {
  Map siteColors = {
    'Meadows Leisure Centre': Colors.green,
    'Crosby Lakeside': Colors.orange,
    'Bootle Leisure Centre': Colors.lightBlueAccent,
    'Dunes': Colors.blue,
    'Netherton Activity Centre': Colors.pink
  };
  Map dayColors = {
    'Monday': Colors.orange,
    'Tuesday': Colors.redAccent,
    'Wednesday': Colors.purpleAccent,
    'Thursday': Colors.cyan,
    'Friday': Colors.green,
    'Saturday': Colors.teal,
    'Sunday': Colors.redAccent,
  };
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

  Event({
    this.site,
    this.siteShortName,
    this.name,
    this.type,
    this.info,
    this.day,
    this.start,
    this.finish,
  });

  double get left =>
      (Utils.convertStringTimeToDouble(start) - TimeTable.left) *
          TimeTable.multiplier;
  double get right =>
      (Utils.convertStringTimeToDouble(finish) - TimeTable.left) *
          TimeTable.multiplier;
  double get width => right - left;
  double get height => 1 / 8;
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

  double get top => daysIndex[day] * height;

  String get shortName =>
      this.name.replaceAll('Les Mills ', '').replaceAll(' Virtual', '');

  bool get isVirtual => name.toLowerCase().contains('virtual');

  double get duration {
    return (Utils.convertStringTimeToDouble(finish) -
        Utils.convertStringTimeToDouble(start)) *
        60;
  }

   Color get color {
     String tmp = this.name.toLowerCase();
     if (tmp.contains('public swim')) {
       return Colors.blue;
     }
     if (tmp.contains('bootle and north')) {
       return Colors.green;
     }
     if (tmp.contains('adults only')) {
       return Colors.cyan;
     }
     if (tmp.contains('swim & splash')) {
       return Colors.pinkAccent;
     }

     if (tmp.contains('pump')) {
       return Colors.red;
     }
     if (tmp.contains('spin') ||
         tmp.contains('trip') ||
         tmp.contains('sprint') ||
         tmp.contains('rpm')) {
       return Colors.blue;
     }
     if (tmp.contains('yoga')) {
       return Colors.yellow;
     }
     if (tmp.contains('pilates')) {
       return Colors.green;
     }
     if (tmp.contains('zumba')) {
       return Colors.green;
     }
     if (tmp.contains('aqua')) {
       return Colors.pink;
     }
     if (tmp.contains('combat')) {
       return Colors.teal;
     }
     if (tmp.contains('tai chi')) {
       return Colors.indigoAccent;
     }

     if (tmp.contains('grit') || tmp.contains('hiit')) {
       return Colors.deepOrangeAccent;
     }

     if (tmp.contains('padwork') || tmp.contains('boxer')) {
       return Colors.purple;
     }
     return Colors.grey;
   }

   Color get dayColor {
     print(this.day);
     return dayColors[this.day];
   }

   Color get siteColor {
      return siteColors[this.site];
   }
}
