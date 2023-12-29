import 'package:flutter/material.dart';

class Catalog extends StatefulWidget {
  const Catalog({ Key? key }) : super(key: key);

  @override
  _CatalogState createState() => _CatalogState();
}

class _CatalogState extends State<Catalog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(),
        body: Center(child: Text("Katalog", style: TextStyle(color: Theme.of(context).colorScheme.onBackground))),);
  }
}