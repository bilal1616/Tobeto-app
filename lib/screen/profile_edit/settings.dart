
import 'package:flutter/material.dart';
import 'package:tobeto_app/screen/splash_screen.dart';
import 'package:tobeto_app/widget/profile_widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SettingsTab extends StatefulWidget {
  @override
  _SettingsTabState createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  TextEditingController _oldPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _newPasswordAgainController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _deleteAccount() async {
  try {
    User? user = _auth.currentUser;

    // Kullanıcının Firebase Authentication üyeliğini silme
    await user!.delete();

    await _auth.signOut();
    // Kullanıcının oturumunu kapatma
  

    // Başarılı bir şekilde hesap silindiğinde ve oturum kapatıldığında kullanıcıyı bilgilendir
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Üyelik İptal Edildi"),
          content: Text("Üyeliğiniz başarıyla iptal edilmiştir."),
          actions: [
            TextButton(
              onPressed: () {
                  Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => SplashScreen()),
                          );
              },
              child: Text("Tamam"),
            ),
          ],
        );
      },
    );
  } catch (e) {
    // Hata durumunda kullanıcıyı bilgilendir
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Üyelik İptali Başarısız"),
          content: Text("Üyelik iptali sırasında bir hata oluştu. Hata: $e"),
          actions: [
            TextButton(
              onPressed: () {
                 Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => SplashScreen()),
                          );
              },
              child: Text("Tamam"),
            ),
          ],
        );
      },
    );
  }
}
void _changePassword() async {
  try {
    User? user = _auth.currentUser;

    // Kullanıcının mevcut şifresiyle giriş yap
    AuthCredential credential = EmailAuthProvider.credential(
      email: user!.email!,
      password: _oldPasswordController.text,
    );

    // Eğer eski şifre doğruysa devam et
    await user.reauthenticateWithCredential(credential);

    // Kontrol: Yeni şifrelerin eşleşip eşleşmediğini kontrol et
    if (_newPasswordController.text == _newPasswordAgainController.text) {
      // Şifre değiştirme işlemi
      await user.updatePassword(_newPasswordController.text);

      // Başarılı bir şekilde şifre güncellendiğinde kullanıcıyı bilgilendir
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Şifre başarıyla değiştirildi."),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      // Yeni şifreler eşleşmiyorsa kullanıcıyı bilgilendir
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Şifreler eşleşmiyor. Şifre değiştirilmedi."),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );
    }
  } catch (e) {
    // Hata durumunda kullanıcıyı bilgilendir (eski şifre yanlışsa buraya düşer)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Şifreyi yanlış girdiniz. Şifre değiştirilmedi."),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          CompCustomTextField(
            obscureText: true,
            controller: _oldPasswordController,
            helperText: 'Eski Şifre',
            hintText: 'Eski Şifre',
          ),
          CompCustomTextField(
            obscureText: true,
            controller: _newPasswordController,
            helperText: 'Yeni Şifre',
            hintText: 'Yeni Şifre',
          ),
          CompCustomTextField(
            obscureText: true,
            controller: _newPasswordAgainController,
            helperText: 'Yeni Şifre Tekrar',
            hintText: 'Yeni Şifre Tekrar',
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                ),
                onPressed: _changePassword,
                child: Text(
                  "Şifreyi Değiştir",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          SizedBox(width: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Container(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                onPressed: () {
                  _deleteAccount();
                },
                child: Text(
                  "Üyeliği Sonlandır",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
