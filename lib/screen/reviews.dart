import 'package:flutter/material.dart';

class Reviews extends StatefulWidget {
  const Reviews({ Key? key }) : super(key: key);

  @override
  _ReviewsState createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(),
        body: Center(child: Text("Değerlendirmeler", style: TextStyle(color: Theme.of(context).colorScheme.onBackground))),);
  }
}