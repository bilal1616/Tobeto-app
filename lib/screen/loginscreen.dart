import 'package:flutter/material.dart';
import 'package:tobeto_app/screen/drawermainscreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

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
                image: AssetImage(
                  imagePath1
                ),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(24)),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Image.asset(
                      imagePath,
                      width: 150,
                      height: 75,
                    ),
                    const Spacer(),
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
                    const Spacer(),
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
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DrawerMainScreen(),
                          ),
                        );
                      },
                      child: const Text("Giriş Yap"),
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 35)),
                    ),
                    const Spacer(),
                    const Divider(height: 0.1),
                    const Spacer(),
                    InkWell(
                      onTap: () {},
                      child: const Text("Parolamı Unuttum"),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
