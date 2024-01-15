import 'package:flutter/material.dart';

class ExamCard extends StatelessWidget {
  const ExamCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background, // Beyaz arkaplan rengi
        borderRadius: BorderRadius.circular(20), // Kutunun köşe yuvarlaklığı
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3), // Daha belirgin gölgelendirme
            spreadRadius: 2,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Sınavlarım",
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.titleLarge?.color ??
                    Colors.black,
              ),
            ),
            SizedBox(height: 16),
            SizedBox(
              height: 200, // Yükseklik ayarı
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: List.generate(3, (index) => _buildExamCard(context)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExamCard(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 4,
      color: Theme.of(context).cardColor, // Card arkaplan rengi beyaz
      child: Container(
        color: Theme.of(context).cardColor,
        width: 150, // Card genişliği
        height: 190, // Card yüksekliği
        padding: EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Herkes için Kodlama 1D Değerlendirme Sınavı",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Herkes İçin",
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color ??
                        Theme.of(context).colorScheme.background,
                    fontSize: 12,
                  ),
                ),
                Text(
                  "Kodlama - 1D",
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color ??
                        Theme.of(context).colorScheme.background,
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Icon(Icons.timer_outlined,
                        color:
                            Theme.of(context).colorScheme.primary, // Tema rengi
                        size: 20),
                    SizedBox(width: 8.0),
                    Text(
                      "45 Dakika",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
                top: 0, right: 0, child: Image.asset("assets/converted.png")),
          ],
        ),
      ),
    );
  }
}
