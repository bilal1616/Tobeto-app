import 'package:flutter/material.dart';
import 'package:tobeto_app/widget/home_widget/education_video.dart';

class EducationPage extends StatefulWidget {
  const EducationPage({Key? key}) : super(key: key);

  @override
  _EducationPageState createState() => _EducationPageState();
}

class _EducationPageState extends State<EducationPage> {
  late List<EducationCard> _educationCards;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _educationCards = _getInitialCards();
  }

  List<EducationCard> _getInitialCards() {
    return [
      // Başlangıçta gösterilecek kartlar
      EducationCard(
          title: 'Dr. Ecmel Ayral\'dan Hoşgeldin Mesajı',
          subtitle: '21 Eylül 2023 15:20',
          buttonText: 'Eğitime Git',
          imageUrl: 'assets/ecmal.jpg',
          videoPath: 'videos/26AralıkSalı-BloCPatternDersi.mp4'),
      EducationCard(
        title: 'Eğitimlere Nasıl Katılırım?',
        subtitle: '8 Eylül 2023 17:06',
        buttonText: 'Eğitime Git',
        imageUrl: 'assets/ıstanbulkodlyr.jpg',
        videoPath:
            'videos/26AralıkSalı-BloCPatternDersi.mp4', // Firebase Storage yolu
      ),
      EducationCard(
        title: 'Herkes için Kodlama - 1A',
        subtitle: '18 Eylül 2023 03:00',
        buttonText: 'Eğitime Git',
        imageUrl: 'assets/tobetoarkapln.jpg',
        videoPath:
            'videos/26AralıkSalı-BloCPatternDersi.mp4', // Firebase Storage yolu
      ),
      EducationCard(
        title: 'İstanbul Kodluyor Proje Aşamaları',
        subtitle: '31 Ağustos 2023 13:01',
        buttonText: 'Eğitime Git',
        imageUrl: 'assets/ıstanbulkodlyr.jpg',
        videoPath:
            'videos/26AralıkSalı-BloCPatternDersi.mp4', // Firebase Storage yolu
      ),
    ];
  }

  List<EducationCard> _getAllCards() {
    return [
      // Tüm kartlar
      // İlk kartlar tekrar listelenmeli ve sonrasında yeni kartlar eklenmeli
      EducationCard(
          title: 'Dr. Ecmel Ayral\'dan Hoşgeldin Mesajı',
          subtitle: '21 Eylül 2023 15:20',
          buttonText: 'Eğitime Git',
          imageUrl: 'assets/ecmal.jpg',
          videoPath: 'videos/26AralıkSalı-BloCPatternDersi.mp4'),
      EducationCard(
        title: 'Eğitimlere Nasıl Katılırım?',
        subtitle: '8 Eylül 2023 17:06',
        buttonText: 'Eğitime Git',
        imageUrl: 'assets/ıstanbulkodlyr.jpg',
        videoPath:
            'videos/26AralıkSalı-BloCPatternDersi.mp4', // Firebase Storage yolu
      ),
      EducationCard(
        title: 'Herkes için Kodlama - 1A',
        subtitle: '18 Eylül 2023 03:00',
        buttonText: 'Eğitime Git',
        imageUrl: 'assets/tobetoarkapln.jpg',
        videoPath:
            'videos/26AralıkSalı-BloCPatternDersi.mp4', // Firebase Storage yolu
      ),
      EducationCard(
        title: 'İstanbul Kodluyor Proje Aşamaları',
        subtitle: '31 Ağustos 2023 13:01',
        buttonText: 'Eğitime Git',
        imageUrl: 'assets/ıstanbulkodlyr.jpg',
        videoPath:
            'videos/26AralıkSalı-BloCPatternDersi.mp4', // Firebase Storage yolu
      ),
      EducationCard(
        title: 'İstanbul Kodluyor Proje Aşamaları',
        subtitle: '31 Ağustos 2023 13:01',
        buttonText: 'Eğitime Git',
        imageUrl: 'assets/ıstanbulkodlyr.jpg',
        videoPath:
            'videos/26AralıkSalı-BloCPatternDersi.mp4', // Firebase Storage yolu
      ),
      EducationCard(
        title: 'İstanbul Kodluyor Proje Aşamaları',
        subtitle: '31 Ağustos 2023 13:01',
        buttonText: 'Eğitime Git',
        imageUrl: 'assets/ıstanbulkodlyr.jpg',
        videoPath:
            'videos/26AralıkSalı-BloCPatternDersi.mp4', // Firebase Storage yolu
      ),
    ];
  }

  void _toggleCardDisplay() {
    setState(() {
      if (_isExpanded) {
        _educationCards = _getInitialCards();
        _isExpanded = false;
      } else {
        _educationCards = _getAllCards();
        _isExpanded = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Eğitimlerim'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ..._educationCards,
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            ElevatedButton.icon(
              onPressed: _toggleCardDisplay,
              icon:
                  Icon(_isExpanded ? Icons.arrow_upward : Icons.arrow_downward),
              label: Text(_isExpanded ? 'Daha Az Göster' : 'Daha Fazla Göster'),
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(42, 42), backgroundColor: Colors.black38),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          ],
        ),
      ),
    );
  }
}

class EducationCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String buttonText;
  final String imageUrl;
  final String videoPath;

  const EducationCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.imageUrl,
    required this.videoPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VideoApp(videoPath: videoPath),
          ),
        );
      },
      child: Container(
        width: double.infinity, // Genişliği ekrana uydur
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 200, // Sabit yükseklik
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                image: DecorationImage(
                  image: AssetImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 14),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                VideoApp(videoPath: videoPath),
                          ),
                        );
                      },
                      child: Text(
                        buttonText,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 36),
                          backgroundColor: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
