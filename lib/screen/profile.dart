import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({ Key? key }) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(),
        body: Center(child: Text("Profilim", style: TextStyle(color: Theme.of(context).colorScheme.onBackground))),);
  }
}