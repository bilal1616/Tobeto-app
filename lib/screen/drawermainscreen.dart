import 'package:flutter/material.dart';
import 'package:tobeto_app/screen/calendar.dart';
import 'package:tobeto_app/screen/catalog.dart';
import 'package:tobeto_app/screen/floatactionmenu.dart';
import 'package:tobeto_app/screen/homescreen.dart';
import 'package:tobeto_app/screen/loginscreen.dart';
import 'package:tobeto_app/screen/profil_edit.dart';
import 'package:tobeto_app/screen/profile.dart';
import 'package:tobeto_app/screen/reviews.dart';

class DrawerMainScreen extends StatefulWidget {
  const DrawerMainScreen({Key? key}) : super(key: key);

  @override
  _DrawerMainScreenState createState() => _DrawerMainScreenState();
}

class _DrawerMainScreenState extends State<DrawerMainScreen> {
  int _selectedPageIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const Reviews(),
    const ProfilePage(),
    const Catalog(),
    const Calendar(),
  ];

  void _selectPage(int index) {
    if (index < 5) {
      setState(() {
        _selectedPageIndex = index;
      });
    } else {
      _showMoreOptions();
    }
  }

  void _showMoreOptions() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return Wrap(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Tobeto'),
              onTap: () {
                Navigator.pop(ctx);
                // Tobeto ana sayfasına yönlendirme
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Kullanıcı Adı'),
              onTap: () => _showProfileMenu(ctx),
            ),
            ListTile(
              leading: const Icon(Icons.arrow_back),
              title: const Text('Ana Menü'),
              onTap: () {
                Navigator.pop(ctx); // Açılır menüyü kapat ve ana menüye dön
              },
            ),
          ],
        );
      },
    );
  }

  void _showProfileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return Wrap(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Profil Bilgileri'),
              onTap: () {
                Navigator.pop(ctx); // İç menüyü kapat
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileInformation()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Oturumu Kapat'),
              onTap: () {
                Navigator.pop(ctx); // İç menüyü kapat
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (Route<dynamic> route) => false,
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.arrow_back),
              title: const Text('Önceki Sayfa'),
              onTap: () {
                Navigator.pop(ctx); // İç menüyü kapat ve üst menüye dön
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    String imagePath =
        isDarkMode ? "assets/tobeto-logo-dark.png" : "assets/tobeto-logo.png";
    Color? iconColor = isDarkMode
        ? Theme.of(context).iconTheme.color
        : Theme.of(context).iconTheme.color;

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          imagePath,
          width: 120,
          height: 60,
        ),
        // Diğer AppBar ayarları
      ),
      body: _pages[_selectedPageIndex],
      floatingActionButton:
          const FloatingActionMenuButton(), // Özel FAB widget'ınızı buraya ekleyin
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        selectedItemColor: Theme.of(context).iconTheme.color,
        unselectedItemColor: Theme.of(context).iconTheme.color,
        selectedLabelStyle: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w700), // Seçili label stilini ayarla
        unselectedLabelStyle: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w700), // Seçilmemiş label stilini ayarla
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: iconColor),
            label: 'Anasayfa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star, color: iconColor),
            label: 'Değerlendirmeler',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: iconColor),
            label: 'Profil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book, color: iconColor),
            label: 'Katalog',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today, color: iconColor),
            label: 'Takvim',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz, color: iconColor),
            label: 'Daha Fazla',
          ),
        ],
      ),
    );
  }
}
