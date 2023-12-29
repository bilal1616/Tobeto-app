import 'package:flutter/material.dart';

class Applications extends StatefulWidget {
  const Applications({Key? key}) : super(key: key);

  @override
  _ApplicationsState createState() => _ApplicationsState();
}

class _ApplicationsState extends State<Applications> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          border: Border(
            left: BorderSide(
              color: Theme.of(context).colorScheme.secondary,
              width: 8,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'İstanbul Kodluyor Bilgilendirme',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      overflow: TextOverflow.visible,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                    ),
                    child: Text(
                      'Kabul Edildi',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.background),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              ..._buildListTiles(),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildListTiles() {
    return [
      ListTile(
        leading: Icon(Icons.check, color: Colors.green),
        title: Text('İstanbul Kodluyor Başvuru Formu onaylandı.',
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge?.color ??
                  Theme.of(context).colorScheme.background,
            )),
        dense: true,
      ),
      ListTile(
        leading: Icon(Icons.check, color: Colors.green),
        title: Text(
          'İstanbul Kodluyor Belge Yükleme Formu onaylandı.',
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyLarge?.color ??
                Theme.of(context).colorScheme.background,
          ),
        ),
        dense: true,
      ),
    ];
  }
}
