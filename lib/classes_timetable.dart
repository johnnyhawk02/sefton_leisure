import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sefton_leisure/event.dart';
import 'package:sefton_leisure/grid_lines.dart';
import 'package:sefton_leisure/leisure_centre.dart';
import 'package:sefton_leisure/leisure_centre.dart';
import 'package:sefton_leisure/time_table.dart';
import 'drop_down_pools.dart';
import 'grid_overlay.dart';

class ClassesTimetable extends StatelessWidget {


  const ClassesTimetable({
    Key key,
    @required this.myList,
    this.width,
    this.height,
    this.myGrid,
  }) : super(key: key);

  final List myList;
 final List myGrid;
 final width;
  final height;

  @override
  Widget build(BuildContext context) {

    double myWidth = (MediaQuery.of(context).size.width>1000?1:2) * width;
    double topGap = 50;
    double myHeight = height - TimeTable.headerHeight;
    List bottomLayer = myList.where((e) => e.clash == 0).toList();
    List topLayer = myList.where((e) => e.clash == 1 || e.clash == null).toList();
    return Stack(
      children: <Widget>[
        SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Stack(
              children: <Widget>[
                Container(height: height, width: myWidth,color: Colors.grey[300],),
                GridOverlay(height: height, width: myWidth, myGrid:myGrid),
                EventBox( myList: bottomLayer, myWidth: myWidth, height: height, bottomLayer: bottomLayer, myHeight: myHeight),
                EventBox( myList: topLayer, myWidth: myWidth, height: height, bottomLayer: bottomLayer, myHeight: myHeight),
                TimetableOverlay(height: height, width: myWidth,),
              ],
            )),


      ],
    );
  }
}

class TimetableOverlay extends StatelessWidget {
  const TimetableOverlay({
    Key key,
    @required this.width,
    @required this.height,
  }) : super(key: key);
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width:width,
      height:height,
      child: Stack(
        children: List<Widget>.generate(7, (i) {
          return Positioned(top: i.toDouble()*height/7,child: Container(width:400,height:100,color: Colors.blueGrey,));
        }),
      ),
    );
  }
}


class EventBox extends StatelessWidget {
  const EventBox({
    Key key,
    @required this.myList,
    @required this.myWidth,
    @required this.height,
    @required this.bottomLayer,
    @required this.myHeight,
  }) : super(key: key);

  final List myList;
  final double myWidth;
  final double height;
  final List bottomLayer;
  final double myHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.grey[100],
      width: myWidth,
      height: height ,
      child: Stack(
        children: List.generate(myList.length, (index) {
          Event event = myList[index];
          return Positioned(
            left: event.left * myWidth,
            top: event.top * myHeight + myHeight/14 , //+ event.dayIndex*2,
            child: GestureDetector(
              onTap: (){print ('${event.name} ${event.day}');},
              child: Container(

                height: event.height * myHeight ,
                width: event.width * myWidth ,
                decoration: BoxDecoration(

                    color: event.classColor, //Color.lerp(event.classColor, Color.fromRGBO(255, 255, 255, 0.4), 0.5), //event.classColor,
                    border: Border.all(color: Colors.white,width: 0.1)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: AutoSizeText(

                    '${event.shortName} ', // ${event.start}',
                    style: TextStyle(color: Colors.white,fontSize: 9),
                    maxLines: 1,

                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}


