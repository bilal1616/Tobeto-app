import 'package:flutter/material.dart';
import 'package:tobeto_app/screen/profil_edit.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
             _buildIcons(),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                     boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                              Container(
                height: screenHeight / 6,
                width: double.infinity, 
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFF5a60d1),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child:  CircleAvatar(
                    backgroundColor: Color(0xFF41528f),
                        radius: 80,
                      
                          child: Icon(
                Icons.person,
                size: 80,
                color: Color(0xFF9e91f0),
                              )
                          
                      ),
                ),
                              ),
                _buildPersonalInfo("Ad Soyad","Oya Özcan", "assets/cv-name.png"),
                      SizedBox(height: 10),
                   _buildPersonalInfo("Doğum Tarihi","28.09.1998", "assets/cv-date.png"),
                  SizedBox(height: 10),
                 _buildPersonalInfo("E-mail","oyaozcan98@gmail.com", "assets/cv-mail.png"),
                  SizedBox(height: 10),
                   _buildPersonalInfo("Telefon","+905333475652", "assets/cv-phone.png"),
                    ],
                  ),
                ),
              ),
            _buildContainerWithTitle("Hakkımda", ""),
            _buildContainerWithTitle("Yetkinliklerim", "Henüz bir yetkinlik eklemedin"),
            _buildContainerWithTitle("Yabancı Dillerim", "Henüz bir yabancı dil eklemedin"),
            _buildContainerWithTitle("Sertifikalarım", "Henüz bir sertifika eklemedin"),
            _buildContainerWithTitle("Medya Hesaplarım", "Henüz bir hesap eklemedin"),
              
                Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  height: screenHeight / 5,
                    width: double.infinity, 
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                       boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Tobeto İşte Başarı Modelim',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),),
                              Icon(Icons.remove_red_eye_outlined)
                            ],
                          ),
                        ),
                         Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Container(
                                               width: double.infinity,
                                               height: 1,
                                               color: Colors.black,
                                             ),
                         ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("İşte Başarı Modeli değerlendirmesiyle Yetkinliklerini Ölç "),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.purple,
                                  ),
                                  onPressed: (){}, 
                                  child: Text('Başla',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),)
                                  ),
                            ],
                          ),
                        ),
                      ],
                    ),
                ),
              ),
              _buildContainerWithAsset(),
               _buildContainerWithTitle("Eğitim Hayatı ve Deneyimlerim", "Henüz bir eğitim ve deneyim eklemedin"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcons(){
    return Padding(
                padding: const EdgeInsets.only(right:30, top: 45),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.end, 
              crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileInformation()),
              );
            },
                      child: Icon(Icons.edit_note)
                      ),
                    Icon(Icons.share),
                  ],
                ),
              );
  }
Widget _buildPersonalInfo(String name, String email, String assetPath) {
  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Image.asset(assetPath),
          ),
        ),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name),
            Text(
              email,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    ),
  );
}

    Widget _buildContainerWithTitle(String title, String subtitle) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        height: screenHeight / 10,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:10.0),
              child: Container(
                width: double.infinity,
                height: 1,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 5),
             Padding(
              padding: const EdgeInsets.symmetric(horizontal:10.0),
              child: Text(subtitle),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildContainerWithAsset() {
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        height: screenHeight / 6,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/rozet1.jpg'),
              SizedBox(width: 20),
              Image.asset('assets/rozet2.jpg'),
            ],
          ),
        )
      ),
    );
  }
}
