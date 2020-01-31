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
    List dayList = [];
    LeisureCentre.days.forEach((day) {
      if (widget.myList.firstWhere((e) => e.day == day, orElse: () => null) !=
          null) {
        dayList.add(day);
      }
    });

    return Container(
      //color: Colors.grey,

      child: ListView.builder(
        key: Key(Utils.CreateCryptoRandomString(88)),
        itemCount: dayList.length,
        //shrinkWrap: false,
        itemBuilder: (BuildContext context, int dayIndex) {
          List newList =
              widget.myList.where((e) => e.day == dayList[dayIndex]).toList();

          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 16, 0),
                child: Text(dayList[dayIndex]),
              ),
              Card(
                color: Colors.white,
                elevation: 0.2,
                shape: RoundedRectangleBorder(

                  borderRadius: BorderRadius.circular(32.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                  child: Column(
                    children: List.generate(newList.length, (index) {
                      var event = newList[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: event.siteColor,
                          child: Text(event.siteShortName,style: TextStyle(fontSize: 12),),
                          maxRadius: 20,
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
                      ); //robohash.org api provide you different images for any number you are giving
                    }),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
