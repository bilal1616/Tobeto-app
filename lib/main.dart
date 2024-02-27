import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tobeto_app/firebase_options.dart';
import 'package:tobeto_app/screen/welcomepage.dart';
import 'package:tobeto_app/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: WelcomePage(),
    );
  }
}
