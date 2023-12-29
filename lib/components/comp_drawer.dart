import 'package:flutter/material.dart';
import 'package:tobeto_app/screen/calendar.dart';
import 'package:tobeto_app/screen/catalog.dart';
import 'package:tobeto_app/screen/homescreen.dart';
import 'package:tobeto_app/screen/loginscreen.dart';
import 'package:tobeto_app/screen/profile.dart';
import 'package:tobeto_app/screen/reviews.dart';
import 'package:tobeto_app/theme/app_color.dart';

class CompDrawer extends StatelessWidget {
  const CompDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    String imagePath =
        isDarkMode ? "assets/tobeto-logo-dark.png" : "assets/tobeto-logo.png";

    return Drawer(
        child: ListView(
      children: [
        Column(
          children: [
            ListTile(
              leading: Image.asset(
                imagePath,
                scale: 2,
              ),
              trailing: Icon(Icons.cancel_outlined),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(height: 20),
            ListTile(
              leading: Text(
                'Anasayfa',
                style: TextStyle(fontSize: 16),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => HomeScreen()),
                );
              },
            ),
            ListTile(
              leading: Text(
                'Değerlendirmeler',
                style: TextStyle(fontSize: 16),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => Reviews()),
                );
              },
            ),
            ListTile(
              leading: Text(
                'Profilim',
                style: TextStyle(fontSize: 16),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => Profile()),
                );
              },
            ),
            ListTile(
              leading: Text(
                'Katalog',
                style: TextStyle(fontSize: 16),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => Catalog()),
                );
              },
            ),
            ListTile(
              leading: Text(
                'Takvim',
                style: TextStyle(fontSize: 16),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => Calendar()),
                );
              },
            ),
            SizedBox(height: 15),
            ListTile(
              title: Text('© 2022 Tobeto', style: TextStyle(fontSize: 15)),
            ),
            SizedBox(height: 45),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    AppColor.favoriteButtonColor, // Renk burada belirleniyor
                fixedSize: Size(
                    200, 40), // Düğmenin sabit genişlik ve yükseklik değerleri
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => LoginScreen()),
                );
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Çıkış Yap",
                      style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.background),
                    )
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    ));
  }
}
