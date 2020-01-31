import 'package:flutter/material.dart';

class ClassesPage extends StatelessWidget {
  const ClassesPage({
    Key key,
    @required this.myList,
  }) : super(key: key);

   final List myList;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 8.0 / 3.0,
        children: List.generate(myList.length, (index) {
          return Card(

            color: Colors.white,
            elevation: 4,
            shape: RoundedRectangleBorder(

              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                 children: <Widget>[
                   // CLASS NAME
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "${myList[index].shortName}",
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                  // VIRTUAL

                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "${myList[index].start} to ${myList[index].finish} ",
                      style: TextStyle(fontSize: 12.0),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: CircleAvatar(
                      backgroundColor: myList[index].classColor,
                      //myList[index].shortName.toLowerCase().contains('pump')?Colors.red:Colors.blue,
                      child: Text(myList[index].isVirtual?'V':''),
                      maxRadius: 12,
                      foregroundColor: Colors.white,
                    ),
                  ),

                ],

              ),
            ),); //robohash.org api provide you different images for any number you are giving
        }),
      ),
    );
  }
}
