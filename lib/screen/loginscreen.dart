import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tobeto_app/screen/drawermainscreen.dart';
import 'package:tobeto_app/theme/app_color.dart';

final firebaseAuthInstance = FirebaseAuth.instance;
final firebaseFirestore = FirebaseFirestore.instance;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _email = '';
  var _password = '';

  void _submit() async {
    _formKey.currentState!.save();

    try {
      if (_isLogin) {
        // Giriş Sayfası
        final userCredentials = await firebaseAuthInstance.signInWithEmailAndPassword(
          email: _email,
          password: _password,
        );
        print(userCredentials);
      } else {
        // Kayıt Sayfası
        final userCredentials = await firebaseAuthInstance.createUserWithEmailAndPassword(
          email: _email,
          password: _password,
        );
        print(userCredentials);

        await firebaseFirestore
            .collection("users")
            .doc(userCredentials.user!.uid)
            .set({'email': _email});
      }

      // Navigate to DrawerMainScreen after successful login or registration
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const DrawerMainScreen(),
        ),
      );
    } on FirebaseAuthException catch (error) {
      // Hata mesajı göster..
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.message ?? "Giriş/Kayıt başarısız.")),
      );
    }
  }

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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment:
                          MainAxisAlignment.center, // İçeriği ortalama
                      children: [
                        Image.asset(imagePath, width: 150, height: 75),
                        SizedBox(
                            height: MediaQuery.of(context).size.height *
                                0.02), // Boşluk ekleme
                          TextFormField(
                            decoration: const InputDecoration(labelText: "E-posta"),
                            autocorrect: false,
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (newValue) {
                              _email = newValue!;
                            },
                          ),
                            
                        SizedBox(
                            height: MediaQuery.of(context).size.height *
                                0.02), // Boşluk ekleme
                          TextFormField(
                            decoration: const InputDecoration(labelText: "Şifre"),
                            autocorrect: false,
                            obscureText: true,
                            onSaved: (newValue) {
                              _password = newValue!;
                            },
                          ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height *
                                0.015), // Boşluk ekleme
                         ElevatedButton(
                            onPressed: () {
                              _submit();
                            },
                            child: Text(_isLogin ? "Giriş Yap" : "Kayıt Ol"),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _isLogin = !_isLogin;
                              });
                            },
                            child: Text(_isLogin ? "Kayıt Sayfasına Git" : "Giriş Sayfasına Git"),
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
          ),
        ],
      ),
    );
  }
}
