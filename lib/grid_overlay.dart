
import 'package:flutter/material.dart';

class GridOverlay extends StatelessWidget {
  const GridOverlay({
    Key key,
    @required this.height,
  }) : super(key: key);

  final height;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 0,
        child: Container(
          height: height,
          width: 200,
          color: Color.fromRGBO(0, 0, 0, 0.05),
        ));
  }
}