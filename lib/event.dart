import 'events_list.dart';
 import 'package:flutter/material.dart';

double convertStringTimeToDouble(s) {
  return double.parse(s.split(':')[0]) + double.parse(s.split(':')[1]) / 60;
}

 Map dayColors = {
   'Monday': Colors.orange,
   'Tuesday': Colors.redAccent,
   'Wednesday': Colors.purpleAccent,
   'Thursday': Colors.cyan,
   'Friday': Colors.green,
   'Saturday': Colors.teal,
   'Sunday': Colors.redAccent,
 };

 Map siteColors = {
   'Meadows Leisure Centre': Colors.yellow,
   'Crosby Lakeside': Colors.orange,
   'Bootle Leisure Centre': Colors.lightBlueAccent
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

abstract class TimeTable {
  static String closing = '22:00';
  static String opening = '06:30';

  //Times();
  static double get left => convertStringTimeToDouble(opening);
  static double get right => convertStringTimeToDouble(closing);
  static double get yOffset => 100;
  static double get multiplier => 1 / (right - left);
}

class Event {
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
      (convertStringTimeToDouble(start) - TimeTable.left) *
          TimeTable.multiplier;
  double get right =>
      (convertStringTimeToDouble(finish) - TimeTable.left) *
          TimeTable.multiplier;
  double get width => right - left;
  double get height => 1 / 16;
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

  double get top =>
      0.05 +
          (poolType == 'learner' ? daysIndex[day] + 0.5 : daysIndex[day] + 0.0) / 8;

  String get shortName =>
      this.name.replaceAll('Les Mills ', '').replaceAll(' Virtual', '');

  bool get isVirtual => name.toLowerCase().contains('virtual');

  double get duration {
    return (convertStringTimeToDouble(finish) -
        convertStringTimeToDouble(start)) *
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

class LeisureCentre {
  List classFilters = [
    'all',
    'pump',
    'bike',
    'yoga',
    'zumba',
    'boxer',
    'cx',
    'grit',
    'hiit',
    'public swim',
    'adult swim',
    'public swim learner pool'
  ];

  List days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];
  List<Event> events = [];
  String openingTime;
  String closingTime;
  LeisureCentre({
    this.openingTime,
    this.closingTime,
  }) {
    eventsList.forEach((e) {
      events.add(Event(
        site: e['site'],
        siteShortName: e['siteShortName'],
        name: e['name'],
        type: e['type'],
        info: e['info'],
        day: e['day'],
        start: e['start'],
        finish: e['finish'],
      ));
    });
  }
  List virtualEventList() => events.where((e) => e.isVirtual).toList();

  List classList({String filterDay, String className}) {
    // Map<String, Function> filter = {
    //   'adult': (Event e) => {e.name.toLowerCase().contains('adult')},
    //   'zumba': (Event e) => {
    //         e.name.toLowerCase().contains('zumba') ||
    //             e.name.toLowerCase().contains('dance fit')
    //       },
    // };
    List<Event> tmpEvents = [];
    List<Event> filteredEvents = [];

    events.sort((a, b) {
      var r = a.dayIndex.compareTo(b.dayIndex);
      if (r != 0) return r;
      return a.left.compareTo(b.left);
    });

    if (filterDay == null || filterDay == '') {
      tmpEvents = events;
    } else {
      tmpEvents = events
          .where((e) => e.day.toLowerCase() == filterDay.toLowerCase())
          .toList();
    }

    //filteredEvents = tmpEvents.where(filter[className]).toList();
    switch (className) {
      case 'all':
        {
          filteredEvents = tmpEvents.where((e) => e.type == 'class').toList();
        }
        break;

      case 'pool':
        {
          filteredEvents = tmpEvents.where((e) => e.type == 'pool').toList();
        }
        break;

      case 'public swim':
        {
          filteredEvents = tmpEvents
              .where((e) =>
          e.name.toLowerCase().contains('adult') ||
              e.name.toLowerCase().contains('public') ||
              e.poolType == 'main')
              .toList();
        }

        break;

      case 'adult swim':
        {
          filteredEvents = tmpEvents
              .where((e) =>
          e.name.toLowerCase().contains('adult') &&
              !e.name.toLowerCase().contains('fit') &&
              e.poolType == 'main')
              .toList();
        }
        break;

      case 'public swim learner pool':
        {
          filteredEvents = tmpEvents
              .where((e) =>
          e.name.toLowerCase().contains('public') &&
              e.poolType == 'learner')
              .toList();
        }
        break;

      case 'bike':
        {
          filteredEvents = tmpEvents
              .where((e) =>
          e.name.toLowerCase().contains('spin') ||
              e.name.toLowerCase().contains('sprint') ||
              e.name.toLowerCase().contains('trip'))
              .toList();
        }
        break;

      case 'zumba':
        {
          filteredEvents = tmpEvents
              .where((e) =>
          e.name.toLowerCase().contains('zumba') ||
              e.name.toLowerCase().contains('dance fit'))
              .toList();
        }
        break;

      case 'aqua':
        {
          tmpEvents.forEach((e) {
            if (e.name.toLowerCase().contains('aqua') &&
                !(e.name.toLowerCase().contains('natal')) &&
                !(e.name.toLowerCase().contains('sub'))) {
              filteredEvents.add(e);
            }
          });
        }
        break;

      default:
        {
          filteredEvents = tmpEvents
              .where(
                  (e) => e.name.toLowerCase().contains(className.toLowerCase()))
              .toList();
        }
    }
    return filteredEvents;
  }
}
