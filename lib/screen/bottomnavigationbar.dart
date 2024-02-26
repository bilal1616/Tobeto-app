import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tobeto_app/screen/calendar.dart';
import 'package:tobeto_app/screen/catalog.dart';
import 'package:tobeto_app/screen/floatactionmenu.dart';
import 'package:tobeto_app/screen/homescreen.dart';
import 'package:tobeto_app/screen/loginscreen.dart';
import 'package:tobeto_app/screen/profil_edit.dart';
import 'package:tobeto_app/screen/profile.dart';
import 'package:tobeto_app/screen/reviews.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  const BottomNavigationBarScreen({Key? key}) : super(key: key);

  @override
  _BottomNavigationBarScreenState createState() => _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  int _selectedPageIndex = 0;
  String? _username;

  final List<Widget> _pages = [
    const HomeScreen(),
    const Reviews(),
    const ProfilePage(),
    const Catalog(),
    const CalendarPage(),
  ];

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  void _loadUsername() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userDocSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      String? username;
      if (userDocSnapshot.exists &&
          userDocSnapshot.data()!.containsKey('username')) {
        username = userDocSnapshot.data()!['username'];
      } else {
        username = user.displayName;
      }

      setState(() {
        _username = username ?? 'Kullanıcı Adı';
      });
    }
  }

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
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: _username != null
                  ? Text(_username!)
                  : const Text("Kullanıcı Adı"),
              onTap: () => _showProfileMenu(ctx),
            ),
            ListTile(
              leading: const Icon(Icons.arrow_back),
              title: const Text('Ana Menü'),
              onTap: () {
                Navigator.pop(ctx);
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
                Navigator.pop(ctx);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileInformation()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Oturumu Kapat'),
              onTap: () async {
                Navigator.pop(context);
                await FirebaseAuth.instance.signOut();
                final GoogleSignIn googleSignIn = GoogleSignIn();
                if (await googleSignIn.isSignedIn()) {
                  await googleSignIn.signOut();
                }
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (Route<dynamic> Route) => false,
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.arrow_back),
              title: const Text('Önceki Sayfa'),
              onTap: () {
                Navigator.pop(ctx);
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
      ),
      body: _pages[_selectedPageIndex],
      floatingActionButton: const FloatingActionMenuButton(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        selectedItemColor: Theme.of(context).iconTheme.color,
        unselectedItemColor: Theme.of(context).iconTheme.color,
        selectedLabelStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w700),
        unselectedLabelStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w700),
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
