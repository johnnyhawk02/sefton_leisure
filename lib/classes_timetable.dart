import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sefton_leisure/event.dart';
import 'package:sefton_leisure/grid_lines.dart';
import 'package:sefton_leisure/leisure_centre.dart';
import 'package:sefton_leisure/leisure_centre.dart';
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
    double myWidth = (MediaQuery.of(context).size.width>1000?1:8) * width;
    double myHeight = height - 200;
    return Stack(
      children: <Widget>[
        SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Stack(
              children: <Widget>[
                Container(
                  width: myWidth,
                  height: height,
                  child: Stack(
                    children: List.generate(myList.length, (index) {
                      Event event = myList[index];
                      return Positioned(
                        left: event.left * myWidth,
                        top: event.top * myHeight + myHeight/12,
                        child: Container(
                          color: event.classColor,
                          height: event.height * myHeight , //- 1,
                          width: event.width * myWidth , //- 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AutoSizeText(
                              '${event.shortName} ${event.start}',
                              style: TextStyle(color: Colors.white,fontSize: 9),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                GridOverlay(height: height, width: myWidth, myGrid:myGrid),
              ],
            )),

      ],
    );
  }
}


