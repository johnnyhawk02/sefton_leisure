import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sefton_leisure/event.dart';
import 'package:zoom_widget/zoom_widget.dart';



class ClassesTimetable extends StatelessWidget {

  const ClassesTimetable({
    Key key,
    @required this.myList,  this.width, this.height,
  }) : super(key: key);

  final List myList;
  final width;
  final height;


  @override
  Widget build(BuildContext context) {
    double myWidth =4*width;
    double myHeight = height-80;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        width: myWidth,
        height:height,
        child: Stack(
          children: List.generate(myList.length, (index) {
            Event event = myList[index];
            return Positioned(
              left: event.left*myWidth,
              top: event.top*myHeight,
              child: Container(
                color: event.color,
                height: event.height*myHeight-1,
                width: event.width*myWidth-1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AutoSizeText('${event.shortName} ${event.start}',style: TextStyle(color: Colors.white),),
                ),
              ),
            );
          }),
    ),
      ));
  }
}
