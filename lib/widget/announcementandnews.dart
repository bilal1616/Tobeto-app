import 'package:flutter/material.dart';

class Announcementandnews extends StatefulWidget {
  const Announcementandnews({Key? key}) : super(key: key);

  @override
  _AnnouncementandnewsState createState() => _AnnouncementandnewsState();
}

class _AnnouncementandnewsState extends State<Announcementandnews> {
  @override
  Widget build(BuildContext context) {
    // Örnek duyuru verileri
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

    return Container(
      child: Column(
        children: [
          ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: announcements.length,
              itemBuilder: (context, index) {
                return Card(
                  margin:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 4,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      border: Border(
                        left: BorderSide(
                          color: Theme.of(context)
                              .colorScheme
                              .secondary, // Burada temanızın rengini kullanabilirsiniz
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
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                                child: Text(
                                  'Duyuru',
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Text(
                                'İstanbul Kodluyor',
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Text(
                            announcements[index]['title']!,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                Icons.date_range_sharp,
                                color: Colors.grey,
                              ),
                              Expanded(
                                child: Text(
                                  announcements[index]['date']!,
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  // Devamını Oku işlemi
                                },
                                child: Text(
                                  'Devamını Oku',
                                  style: TextStyle(
                                    color: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.color ??
                                        Theme.of(context)
                                            .colorScheme
                                            .background,
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
              }),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: Icon(
                  Icons.navigate_next,
                  color: Colors.black,
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: CircleBorder(
                        side: BorderSide(style: BorderStyle.solid))),
              ),
              Text(
                "Daha fazla göster",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Theme.of(context).textTheme.bodyLarge?.color ??
                        Theme.of(context).colorScheme.background),
              ),
              SizedBox(height: 18)
            ],
          ),
        ],
      ),
    );
  }
}
