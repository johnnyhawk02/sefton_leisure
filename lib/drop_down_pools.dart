import 'package:flutter/material.dart';

class Item {
  const Item(this.name,this.icon);
  final String name;
  final Icon icon;
}
class DropdownScreen extends StatefulWidget {
  DropdownScreen(this.changePool);
  final Function changePool;
  State createState() =>  DropdownScreenState();
}
class DropdownScreenState extends State<DropdownScreen> {

  Item selectedUser;
  List<Item> users = <Item>[
    const Item('Meadows Leisure Centre',Icon(Icons.android,color:  const Color(0xFF167F67),)),
    const Item('Bootle Leisure Centre',Icon(Icons.flag,color:  const Color(0xFF167F67),)),
    const Item('Dunes',Icon(Icons.format_indent_decrease,color:  const Color(0xFF167F67),)),
  ];
  @override
  Widget build(BuildContext context) {
    return   DropdownButton<Item>(
      hint:  Text("Select item"),
      value: selectedUser,
      onChanged: (Item Value) {
        setState(() {
          selectedUser = Value;
          widget.changePool(Value.name);
        });
      },
      items: users.map((Item user) {
        return  DropdownMenuItem<Item>(
          value: user,
          child: Row(
            children: <Widget>[
              user.icon,
              SizedBox(width: 10,),
              Text(
                user.name,
                style:  TextStyle(color: Colors.black),
              ),
            ],
          ),
        );
      }).toList(),
    ) ;
  }
}