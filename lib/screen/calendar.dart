import 'package:flutter/material.dart';

class Calendar extends StatefulWidget {
  const Calendar({ Key? key }) : super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(),
        body: Center(child: Text("Takvim", style: TextStyle(color: Theme.of(context).colorScheme.onBackground))),);
  }
}