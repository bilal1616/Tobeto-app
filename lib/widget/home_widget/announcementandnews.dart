import 'package:flutter/material.dart';

class Announcementandnews extends StatelessWidget {
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

    return Scaffold(
      appBar: AppBar(
        title: Text('Duyuru ve Haberlerim'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView(
        children: announcements.map((announcement) => _buildAnnouncementCard(announcement, context)).toList(),
      ),
    );
  }

  Widget _buildAnnouncementCard(Map<String, String> announcement, BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.80,
        height: MediaQuery.of(context).size.height * 0.19, // Card yüksekliği azaltıldı
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
