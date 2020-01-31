import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sefton_leisure/event.dart';
import 'package:sefton_leisure/utils.dart';

import 'leisure_centre.dart';

class ClassesAllDays extends StatefulWidget {
  const ClassesAllDays({
    Key key,
    @required this.myList,
  }) : super(key: key);

  final List myList;

  @override
  _ClassesAllDaysState createState() => _ClassesAllDaysState();
}

class _ClassesAllDaysState extends State<ClassesAllDays> {
  var currentDay;
  @override
  Widget build(BuildContext context) {
    currentDay = null;
    int myCounter = 0;
    int numDays = 0;
    LeisureCentre.days.forEach((day) {
      if (widget.myList.firstWhere((e) => e.day == day, orElse: () => null) != null)   numDays++;
    });

    return ListView.builder(
      key: Key(Utils.CreateCryptoRandomString(88)),
      itemCount: widget.myList == null ? 1 : widget.myList.length + numDays,
      itemBuilder: (BuildContext context, int index) {
        Event event = widget.myList[myCounter];

        //
        if (currentDay != event.day) {
          currentDay = event.day;
          index -= 1;
          return Padding(
            padding: const EdgeInsets.fromLTRB(36, 12, 12, 0),
            child: Text(
              event.day,
              style: GoogleFonts.basic(
                textStyle: Theme.of(context).textTheme.display1,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          );
        } else {
          myCounter++;
          return Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: event.siteColor,
                child: Text(event.siteShortName),
                maxRadius: 25,
                foregroundColor: Colors.white,
              ),
              title: Text('${event.shortName}'),
              subtitle: Text('${event.day}: ${event.start} - ${event.finish}'),
              trailing: event.isVirtual
                  ? CircleAvatar(
                      backgroundColor: Colors.grey,
                      child: Text('V'),
                      maxRadius: 10,
                      foregroundColor: Colors.white,
                    )
                  : Text(''),

              //dense: true,
            ),
          );
        }
      },
    );
  }
}
