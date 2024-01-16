import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tobeto_app/screen/drawermainscreen.dart';
import 'package:tobeto_app/theme/app_color.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController =
      TextEditingController(); // Kayıt için e-posta
  bool _isPasswordVisible = false;
  bool _isRegisterScreen = false; // Hangi ekranın gösterileceğini kontrol et

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    String imagePath =
        isDarkMode ? "assets/tobeto-logo-dark.png" : "assets/tobeto-logo.png";
    String imagePath1 = isDarkMode ? "assets/dark.png" : "assets/light.png";

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imagePath1),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height:
                  MediaQuery.of(context).size.height * 0.63, // Konteyner boyutu
              decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(24)),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center, // İçeriği ortalama
                    children: [
                      Image.asset(imagePath, width: 150, height: 75),
                      SizedBox(
                          height: MediaQuery.of(context).size.height *
                              0.02), // Boşluk ekleme
                      _isRegisterScreen
                          ? TextField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.email),
                                label: const Text("E-Posta"),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                contentPadding: const EdgeInsets.all(8),
                              ),
                            )
                          : Container(),
                      SizedBox(
                          height: MediaQuery.of(context).size.height *
                              0.02), // Boşluk ekleme
                      TextField(
                        controller: _usernameController,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.person_outline),
                          label: const Text("Kullanıcı Ad"),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          contentPadding: const EdgeInsets.all(8),
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height *
                              0.02), // Boşluk ekleme
                      TextField(
                        controller: _passwordController,
                        obscureText: !_isPasswordVisible,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                              child: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                            label: const Text("Parola"),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            contentPadding: const EdgeInsets.all(8)),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height *
                              0.015), // Boşluk ekleme
                      ElevatedButton(
                        onPressed: () {
                          if (_isRegisterScreen) {
                            // Kayıt işlemleri
                          } else {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const DrawerMainScreen()),
                            );
                          }
                        },
                        child:
                            Text(_isRegisterScreen ? "Kayıt Ol" : "Giriş Yap"),
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(double.infinity, 35)),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height *
                              0.015), // Boşluk ekleme
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // Google ile giriş yapma işlemleri
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.favoriteButtonColor,
                              minimumSize: Size(60, 60),
                              shape: CircleBorder(),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Icon(FontAwesomeIcons.google,
                                  color: Colors.white),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // GitHub ile giriş yapma işlemleri
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              minimumSize: Size(60, 60),
                              shape: CircleBorder(),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Icon(FontAwesomeIcons.github,
                                  color: Colors.white),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Apple ile giriş yapma işlemleri
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              minimumSize: Size(60, 60),
                              shape: CircleBorder(),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Icon(FontAwesomeIcons.apple,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height *
                              0.015), // Boşluk ekleme
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _isRegisterScreen = !_isRegisterScreen;
                          });
                        },
                        child: Text(
                          _isRegisterScreen ? "Giriş Ekranına Dön" : "Kayıt Ol",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Divider(), // Divider ekleyin
                      SizedBox(
                          height: MediaQuery.of(context).size.height *
                              0.009), // Boşluk ekleme
                      InkWell(
                        onTap: () {},
                        child: const Text("Parolamı Unuttum"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
