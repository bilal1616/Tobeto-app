import 'package:flutter/material.dart';

class Announcementandnews extends StatefulWidget {
  const Announcementandnews({Key? key}) : super(key: key);

  @override
  _AnnouncementandnewsState createState() => _AnnouncementandnewsState();
}

class _AnnouncementandnewsState extends State<Announcementandnews> {
  @override
  Widget build(BuildContext context) {
    final announcements = [
      {
        'title': 'Yeni Grupların Discord\'a Katılımı',
        'date': '07.12.2023',
      },
      {
        'title': '4 Aralık Online Hoşgeldin Buluşması',
        'date': '29.11.2023',
      },
      {
        'title': 'Önemli Bilgilendirme',
        'date': '23.11.2023',
      },
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: announcements.map((announcement) => _buildAnnouncementCard(announcement, context)).toList(),
      ),
    );
  }

  Widget _buildAnnouncementCard(Map<String, String> announcement, BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.80,
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
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    child: Text(
                      'Duyuru',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  Text(
                    'İstanbul Kodluyor',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                announcement['title']!,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),textAlign: TextAlign.start,
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.date_range_sharp, color: Colors.grey),
                  Text(
                    announcement['date']!,
                    style: TextStyle(color: Colors.grey),
                  ),
                  TextButton(
                    onPressed: () {
                      // Devamını Oku işlemi
                    },
                    child: Text(
                      'Devamını Oku',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyLarge?.color ?? Theme.of(context).colorScheme.background,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
