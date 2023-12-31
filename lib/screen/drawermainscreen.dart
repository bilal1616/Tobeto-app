import 'package:flutter/material.dart';
import 'package:tobeto_app/screen/calendar.dart';
import 'package:tobeto_app/screen/catalog.dart';
import 'package:tobeto_app/screen/homescreen.dart';
import 'package:tobeto_app/screen/loginscreen.dart';
import 'package:tobeto_app/screen/profile.dart';
import 'package:tobeto_app/screen/reviews.dart';

List<Widget> pages = [
  const HomeScreen(),
  const Reviews(),
  const Profile(),
  const Catalog(),
  const Calendar(),
];

class DrawerMainScreen extends StatefulWidget {
  const DrawerMainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<DrawerMainScreen> {
  var currentPage = 0;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    String imagePath =
        isDarkMode ? "assets/tobeto-logo-dark.png" : "assets/tobeto-logo.png";
    return Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0.0,
          automaticallyImplyLeading: false,
          actions: [
            Builder(builder: (context) {
              return IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: Icon(Icons.menu));
            })
          ],
          title: Image.asset(
            imagePath,
            width: 120,
            height: 60,
          ),
          bottom: PreferredSize(
              preferredSize: Size.fromHeight(1.0),
              child: Divider(
                color: Colors.black26,
                height: 1.0,
              )),
        ),
        floatingActionButton: FloatingActionButton(
          elevation: 15,
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Theme.of(context).colorScheme.background,
          onPressed: () {},
          child: const Icon(Icons.messenger),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      imagePath,
                      width: 120,
                      height: 60,
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
              ),
              ListTile(
                title: Text(
                  "Anasayfa",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  if (currentPage == 0) {
                    Navigator.pop(context);
                  } else {
                    setState(() {
                      currentPage = 0;
                    });

                    Navigator.pop(context);
                  }
                },
              ),
              ListTile(
                title: Text(
                  "Değerlendirmeler",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  if (currentPage == 1) {
                    Navigator.pop(context);
                  } else {
                    setState(() {
                      currentPage = 1;
                    });

                    Navigator.pop(context);
                  }
                },
              ),
              ListTile(
                title: Text(
                  "Profilim",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  if (currentPage == 2) {
                    Navigator.pop(context);
                  } else {
                    setState(() {
                      currentPage = 2;
                    });
                    Navigator.pop(context);
                  }
                },
              ),
              ListTile(
                title: Text(
                  "Katalog",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  if (currentPage == 3) {
                    Navigator.pop(context);
                  } else {
                    setState(() {
                      currentPage = 3;
                    });
                    Navigator.pop(context);
                  }
                },
              ),
              ListTile(
                title: Text(
                  "Takvim",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  if (currentPage == 4) {
                    Navigator.pop(context);
                  } else {
                    setState(() {
                      currentPage = 4;
                    });
                    Navigator.pop(context);
                  }
                },
              ),
              const Divider(),
              ListTile(
                title: Row(
                  children: [
                    Text(
                      "Tobeto",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 9),
                    Icon(
                      Icons.home,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  title: Text(
                    "Kullanıcı Adı",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  trailing: const CircleAvatar(
                    foregroundColor: Colors.grey,
                    backgroundColor: Colors.deepPurple,
                    child: Icon(Icons.person_outline_outlined),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ListTile(
                title: Text(
                  "Çıkış Yap",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                trailing: Icon(
                  Icons.exit_to_app_outlined,
                  color: Theme.of(context).iconTheme.color,
                ),
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ));
                },
              ),
              const Padding(
                padding: EdgeInsets.all(10),
                child: Text("© 2022 Tobeto"),
              ),
            ],
          ),
        ),
        body: pages[currentPage]);
  }
}
