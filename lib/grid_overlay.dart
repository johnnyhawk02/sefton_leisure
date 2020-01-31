
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sefton_leisure/grid_lines.dart';
import 'leisure_centre.dart';

class GridOverlay extends StatelessWidget {


  const GridOverlay({
    Key key,
    @required this.height, this.width, this.myGrid,
  }) : super(key: key);

  final height;
  final width;
  final myGrid;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: Stack(
        children: List.generate(myGrid.length, (index) {
          GridLines gridLine = myGrid[index];
          return Positioned(
            left: gridLine.left * width,
            top: 0,
            child: Stack(
              children: <Widget>[
                Container(
                  color: Color.fromRGBO(0, 0, 0, 0.2),
                  height: height,
                  width: gridLine.width ,

                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AutoSizeText(
                    '${gridLine.time} ',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}