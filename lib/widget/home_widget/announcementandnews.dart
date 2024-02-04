import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AnnouncementAndNews extends StatefulWidget {
  @override
  _AnnouncementAndNewsState createState() => _AnnouncementAndNewsState();
}

class _AnnouncementAndNewsState extends State<AnnouncementAndNews> {
  final String? userId = FirebaseAuth.instance.currentUser?.uid;

  Stream<List<Map<String, dynamic>>> fetchAnnouncements() async* {
    if (userId == null) {
      yield [];
      return;
    }
    DocumentSnapshot<Map<String, dynamic>> userDoc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    List<dynamic> announcementIds = userDoc.data()?['announcements'] ?? [];
    List<Map<String, dynamic>> announcements = [];
    for (var id in announcementIds) {
      DocumentSnapshot<Map<String, dynamic>> announcementDoc =
          await FirebaseFirestore.instance
              .collection('announcements')
              .doc(id)
              .get();
      if (announcementDoc.exists) {
        Map<String, dynamic> announcement = announcementDoc.data()!;
        announcements.add(announcement);
      }
    }
    yield announcements;
  }

  void showAnnouncementDetails(
      BuildContext context, Map<String, dynamic> announcement) {
    showModalBottomSheet(
      context: context,
      isScrollControlled:
          true, // Modalın ekran boyutuna göre ayarlanmasını sağlar.
      builder: (BuildContext bc) {
        return FractionallySizedBox(
          heightFactor: 0.7, // Modalın ekranın %70'ini kaplamasını sağlar.
          child: Container(
            padding: EdgeInsets.all(24), // İçerik padding'i artırıldı.
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment:
                  MainAxisAlignment.center, // İçeriği merkeze alır.
              children: <Widget>[
                Text(
                  announcement['title'],
                  textAlign: TextAlign.center, // Başlığı merkeze alır.
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24, // Başlık fontu büyütüldü.
                  ),
                ),
                SizedBox(
                    height: 16), // Başlık ve içerik arasında boşluk bırakır.
                Text(
                  announcement['content'],
                  textAlign: TextAlign.center, // İçeriği merkeze alır.
                  style: TextStyle(
                    fontSize: 20, // İçerik fontu büyütüldü.
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Duyuru ve Haberler'),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop()),
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: fetchAnnouncements(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("Duyuru bulunamadı."));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final announcement = snapshot.data![index];
              DateTime date = (announcement['date'] as Timestamp).toDate();
              String formattedDate = DateFormat('dd.MM.yyyy').format(date);

              return Card(
                margin: EdgeInsets.all(10),
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Row(
                  children: [
                    Container(
                        width: 5,
                        height: 155,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                bottomLeft: Radius.circular(12)))),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(announcement['type'],
                                      style: TextStyle(color: Colors.green)),
                                  Text(announcement['type2'],
                                      style: TextStyle(color: Colors.green))
                                ]),
                            SizedBox(height: 15),
                            Text(announcement['title'],
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            SizedBox(height: 18),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(children: [
                                  Icon(Icons.calendar_today, size: 20),
                                  SizedBox(width: 8),
                                  Text(formattedDate)
                                ]),
                                Expanded(
                                    child: Align(
                                        alignment: Alignment.centerRight,
                                        child: TextButton(
                                            onPressed: () =>
                                                showAnnouncementDetails(
                                                    context, announcement),
                                            child: Text("Devamını Oku",
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 16),
                                                overflow:
                                                    TextOverflow.ellipsis)))),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
