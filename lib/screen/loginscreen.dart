import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
  var _username = '';

  void _submit() async {
    _formKey.currentState!.save();

    try {
      if (_isLogin) {
        // Giriş sayfası için işlemler
        final userCredentials = await firebaseAuthInstance
            .signInWithEmailAndPassword(email: _email, password: _password);
        print(userCredentials);
      } else {
        // Kayıt sayfası için işlemler
        final userCredentials = await firebaseAuthInstance
            .createUserWithEmailAndPassword(email: _email, password: _password);
        await firebaseFirestore
            .collection("users")
            .doc(userCredentials.user!.uid)
            .set({'email': _email, 'username': _username});
      }
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const DrawerMainScreen(),
        ),
      );
    } on FirebaseAuthException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.message ?? "Giriş/Kayıt başarısız.")),
      );
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return null;
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    String imagePath =
        isDarkMode ? "assets/tobeto-logo-dark.png" : "assets/tobeto-logo.png";
    String imagePath1 = isDarkMode ? "assets/siyah.png" : "assets/beyaz.png";
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              imagePath1,
              fit: BoxFit
                  .cover, // Resmi tüm ekranı kaplayacak şekilde ölçeklendir
            ),
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.625,
              decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(24)),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(imagePath, width: 150, height: 75),
                        // Kullanıcı adı alanı sadece kayıt ol durumunda görünür
                        if (!_isLogin)
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: "Kullanıcı Adı"),
                            autocorrect: false,
                            onSaved: (newValue) => _username = newValue!,
                          ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.005),
                        TextFormField(
                          decoration:
                              const InputDecoration(labelText: "E-posta"),
                          autocorrect: false,
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (newValue) => _email = newValue!,
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.005),
                        TextFormField(
                          decoration: const InputDecoration(labelText: "Şifre"),
                          autocorrect: false,
                          obscureText: true,
                          onSaved: (newValue) => _password = newValue!,
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.015),
                        ElevatedButton(
                          onPressed: _submit,
                          child: Text(_isLogin ? "Giriş Yap" : "Kayıt Ol"),
                        ),
                        TextButton(
                          onPressed: () => setState(() => _isLogin = !_isLogin),
                          child: Text(_isLogin
                              ? "Kayıt Sayfasına Git"
                              : "Giriş Sayfasına Git"),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height *
                                0.015), // Boşluk ekleme
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () async {
                                UserCredential? userCredential =
                                    await signInWithGoogle();
                                if (userCredential != null) {
                                  // Google ile giriş başarılı, ana ekrana yönlendir
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const DrawerMainScreen(),
                                    ),
                                  );
                                }
                              },
                              icon: Icon(FontAwesomeIcons.google,
                                  color: Colors.white),
                              label: Text("Google ile Giriş Yap"),
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: AppColor
                                    .favoriteButtonColor, // Butonun metin ve ikon rengi
                                textStyle: TextStyle(
                                    color: Colors.white), // Metin stili
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8), // Padding
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
