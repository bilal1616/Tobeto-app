import 'package:flutter/material.dart';
import 'package:tobeto_app/widget/profile_edit_widget/CertificationsPage.dart';
import 'package:tobeto_app/widget/profile_edit_widget/EducationPage.dart';
import 'package:tobeto_app/widget/profile_edit_widget/LanguagesPage.dart';
import 'package:tobeto_app/widget/profile_edit_widget/PersonalInfoPage.dart';
import 'package:tobeto_app/widget/profile_edit_widget/ReviewsPage.dart';
import 'package:tobeto_app/widget/profile_edit_widget/SettingsPage.dart';
import 'package:tobeto_app/widget/profile_edit_widget/SkillsPage.dart';
import 'package:tobeto_app/widget/profile_edit_widget/SocialMediaPage.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 8, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Bilgileri'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () =>
              Navigator.pop(context), // Go back to the previous page
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(icon: Icon(Icons.person), text: 'Kişisel Bilgilerim'),
            Tab(icon: Icon(Icons.rate_review), text: 'Değerlendirmeler'),
            Tab(icon: Icon(Icons.school), text: 'Eğitim Hayatım'),
            Tab(icon: Icon(Icons.build), text: 'Yetkinliklerim'),
            Tab(icon: Icon(Icons.card_membership), text: 'Sertifikalarım'),
            Tab(icon: Icon(Icons.social_distance), text: 'Medya Hesaplarım'),
            Tab(icon: Icon(Icons.language), text: 'Yabancı Dillerim'),
            Tab(icon: Icon(Icons.settings), text: 'Ayarlar'),
          ],
          isScrollable: true,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          PersonalInfoPage(),
          ReviewsPage(),
          EducationPage(),
          SkillsPage(),
          CertificationsPage(),
          SocialMediaPage(),
          LanguagesPage(),
          SettingsPage(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
