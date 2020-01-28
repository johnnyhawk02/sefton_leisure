import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sefton_leisure/event.dart';

class ClassesAllDays extends StatelessWidget {
  const ClassesAllDays({
    Key key,
    @required this.myList,
  }) : super(key: key);

  final List myList;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: ListTile.divideTiles(
        context: context,
        tiles: List.generate(myList.length, (index) {
          Event event = myList[index];
          return
            ListTile(
            leading: CircleAvatar(
              backgroundColor: event.dayColor,
              child: Text(event.day.substring(0, 2)),
              maxRadius: 20,
              foregroundColor: Colors.white,
            ),
            title: Text(event.shortName),
            subtitle: Text(event.start),
            trailing: myList[index].isVirtual
                ? Icon(
                    Icons.tv,
                    color: Colors.black45,
                  )
                : Icon(
                    Icons.accessibility,
                    color: Colors.black45,
                  ),

            //dense: true,
          );
        }),
      ).toList(),
    ));
  }
}
