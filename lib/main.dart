import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:menu/menu.dart';

import 'classes_all_days.dart';
import 'classes_page.dart';
import 'classes_timetable.dart';
import 'drop_down_pools.dart';
import 'event.dart';
import 'leisure_centre.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Timetable',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Timetable'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String classFilter = '';
  String title = '';
  String currentDay = 'monday';
  LeisureCentre mdw = LeisureCentre();
  int _currentPageIndex = 0;

  var _value;

  String _pool = 'Meadows Leisure Centre/Main';
  @override
  Widget build(BuildContext context) {
    //List tempList = mdw.classList(classFilter);

    print('got tempList');
    List myList;

    AppBar appBar = AppBar(
      title: Text(title),
      actions: <Widget>[DropdownScreen(changePoolType ),],
    );

    BottomNavigationBar bottomNavigationBar = BottomNavigationBar(
      currentIndex: _currentPageIndex, // new
      onTap: onTabTapped, // new
// a new tab is tapped
      items: [
        BottomNavigationBarItem(
          icon: new Icon(Icons.accessibility_new),
          title: new Text('Classes'),
        ),
        BottomNavigationBarItem(
          icon: new Icon(Icons.beach_access,),
          title: new Text('Swim timetable'),
        ),
//          BottomNavigationBarItem(
//              icon: Icon(Icons.person), title: Text('Profile'))
      ],
    );


    final choices = List<Widget>.generate(mdw.classFilters.length, (i) {
      var myClass = mdw.classFilters[i];
      return ListTile(
        title: Text(myClass),
        onTap: () {
          setState(
                () {
              classFilter = myClass;

              title = '${classFilter == "" ? 'all classes' : classFilter}';
              _currentPageIndex=0;

            },
          );
          Navigator.pop(context);
        },
      );
    });


    final List<Widget> pages2 = [
      ClassesTimetable(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height -
            kToolbarHeight - kBottomNavigationBarHeight,
        myList: mdw.getEventsList(pool: _pool),
        myGrid: mdw.gridLine,
      ),
      ClassesAllDays(
        myList: mdw.getEventsList(event: classFilter),
      )
    ];


    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: appBar,

      drawer: Drawer(

        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(children: choices),
        ),
      ),

      body: pages2[_currentPageIndex],
      bottomNavigationBar: bottomNavigationBar
//      floatingActionButton: FloatingActionButton(
//        onPressed: () {},
//        tooltip: 'Increment',
//        child: Icon(Icons.android),
//      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void changePoolType(String pool){
    setState(() {
      _pool = pool;
    });
  }
  void onTabTapped(int index) {
    setState(() {
      _currentPageIndex = index;
      if (index==0) {
        title = '${classFilter == "" ? 'all classes' : classFilter}';
      }else{
        title = 'Swim';
      }

    });
  }
}
