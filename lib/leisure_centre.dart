
import 'package:sefton_leisure/event.dart';
import 'package:sefton_leisure/grid_list.dart';
import 'events_list.dart';
import 'grid_lines.dart';

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

  static List days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  List<Event> events = [];
  List<GridLines> gridLine = [];
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
        clash: e['clash'],
        poolName: e['poolName'],
      ));
    });

    gridList.forEach((e) {
      gridLine.add(GridLines(
        time: e['time'],
        bold: e['bold'],
      ));
    });
  }
  List virtualEventList() => events.where((e) => e.isVirtual).toList();

  List getEventsList({String day, String event, String pool}) {
    // Map<String, Function> filter = {
    //   'adult': (Event e) => {e.name.toLowerCase().contains('adult')},
    //   'zumba': (Event e) => {
    //         e.name.toLowerCase().contains('zumba') ||
    //             e.name.toLowerCase().contains('dance fit')
    //       },
    // };
    //List<Event> tmpEvents = [];
    List<Event> filteredEvents = [];
    filteredEvents = events;

    if (day == null && event == null && pool==null) {return filteredEvents;}

    if (day != null ) {
      filteredEvents = filteredEvents
          .where((e) => e.day == day)
          .toList();
    }

    if (pool != null) {
      filteredEvents = filteredEvents
          .where((e) => e.site == pool.split('/')[0]
      && e.poolName == pool.split('/')[1])
          .toList();
    }

    if (event == null) {return filteredEvents;}

    switch (event) {
      case 'all':
        {
          filteredEvents = filteredEvents.where((e) => e.type == 'class').toList();
        }
        break;

      case 'pool':
        {
          filteredEvents = filteredEvents.where((e) => e.type == 'pool').toList();
        }
        break;

      case 'public swim':
        {
          filteredEvents = filteredEvents
              .where((e) =>
          e.name.toLowerCase().contains('adult') ||
              e.name.toLowerCase().contains('public') ||
              e.poolType == 'main')
              .toList();
        }

        break;

      case 'adult swim':
        {
          filteredEvents = filteredEvents
              .where((e) =>
          e.name.toLowerCase().contains('adult') &&
              !e.name.toLowerCase().contains('fit') &&
              e.poolType == 'main')
              .toList();
        }
        break;

      case 'public swim learner pool':
        {
          filteredEvents = filteredEvents
              .where((e) =>
          e.name.toLowerCase().contains('public') &&
              e.poolType == 'learner')
              .toList();
        }
        break;

      case 'bike':
        {
          filteredEvents = filteredEvents
              .where((e) =>
          e.name.toLowerCase().contains('spin') ||
              e.name.toLowerCase().contains('sprint') ||
              e.name.toLowerCase().contains('trip'))
              .toList();
        }
        break;

      case 'zumba':
        {
          filteredEvents = filteredEvents
              .where((e) =>
          e.name.toLowerCase().contains('zumba') ||
              e.name.toLowerCase().contains('dance fit'))
              .toList();
        }
        break;

      case 'aqua':
        {
          filteredEvents.forEach((e) {
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
          filteredEvents = filteredEvents
              .where(
                  (e) => e.name.toLowerCase().contains(event.toLowerCase()))
              .toList();
        }
    }
    filteredEvents.sort((a, b) {
      var r = a.dayIndex.compareTo(b.dayIndex);
      if (r != 0) return r;
      return a.left.compareTo(b.left);
    });
    return filteredEvents;
  }
}
