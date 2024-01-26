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

class DrawerMainScreen extends StatefulWidget {
  const DrawerMainScreen({Key? key}) : super(key: key);

  @override
  _DrawerMainScreenState createState() => _DrawerMainScreenState();
}

class _DrawerMainScreenState extends State<DrawerMainScreen> {
  int _selectedPageIndex = 0;
  String? _username;

  final List<Widget> _pages = [
    const HomeScreen(),
    const Reviews(),
    const ProfilePage(),
    const Catalog(),
    const Calendar(),
  ];

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  void _loadUsername() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String? username;

      //Firebase den kullanıcı adını çek
      DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore
          .instance
          .collection("users")
          .doc(user.uid)
          .get();

      if (userDoc.exists) {
        username = userDoc["username"];
      }

      //Google ile giriş yapıldıysa ve firebase den kullanıcı adı çekilmediyse
      if (user.providerData.isNotEmpty && username == null) {
        //google kullanıcı adını kullan
        username = user.providerData.first.displayName;
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
                // Tobeto ana sayfasına yönlendirme
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
              onTap: () async {
                Navigator.pop(context);

                //Firebaseden çıkış yap
                await FirebaseAuth.instance.signOut();

                //Google ile giriş yapılmışsa googledan çıkış yap
                final GoogleSignIn googleSignIn = GoogleSignIn();
                if (await googleSignIn.isSignedIn()) {
                  await googleSignIn.signOut();
                }

                //Login ekranına yönlendir
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
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(_username ?? 'Kullanıcı Adı'),
              accountEmail: null,
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.person,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
