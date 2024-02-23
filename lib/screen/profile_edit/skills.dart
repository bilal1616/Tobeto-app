import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tobeto_app/screen/profile_edit/education.dart';
import 'package:tobeto_app/screen/profile_edit/profile_settings.dart';
import 'package:tobeto_app/screen/profile_edit/work.dart';
import 'package:tobeto_app/widget/profile_widgets/custom_date_picker.dart';
import 'package:tobeto_app/widget/profile_widgets/custom_skills_dropdown.dart';
import 'package:tobeto_app/widget/profile_widgets/custom_socialmedia_dropdown.dart';
import 'package:tobeto_app/widget/profile_widgets/custom_text_field.dart';

List<String> educationList = <String>[
  'Lisans',
  'Önlisans',
  'Yüksek Lisans',
  'Doktora'
];
List<String> cityList = <String>['istanbul', 'izmir', 'Ankara', 'Bursa'];
List<String> skillsList = [
  'C#',
  'Dart / Flutter',
  'SQL',
  'Muhasebe',
  'Javascript',
  'Aktif Öğrenme',
  'Aktif Dinleme',
  'Uyum Sağlama',
  'Yönetim ve İdare',
  'Reklam',
  'Algoritmalar',
  'Android',
  'Mobil',
];

List<String> languageList = <String>[
  'ingilizce',
  'almanca',
  'ispanyolca',
  'fransızca'
];
List<String> languageLevelList = <String>[
  'Temel Seviye(A1-A2)',
  'Orta Seviye(B1-B2)',
  'İleri Seviye(C1-C2)',
  'Anadil'
];

class SkillsTab extends StatefulWidget {
  @override
  _SkillsTabState createState() => _SkillsTabState();
}

class _SkillsTabState extends State<SkillsTab> {
  File? _image;
  File? _selectedFile;

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
      });
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  TextEditingController _nameController = TextEditingController();
  TextEditingController _surnameController = TextEditingController();
  TextEditingController _tcController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _countryController = TextEditingController();
  TextEditingController _districtController = TextEditingController();
  TextEditingController _socialMediaController = TextEditingController();
  TextEditingController _oldPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _newPasswordAgainController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _birthDateController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  TextEditingController _startWorkDateController = TextEditingController();

  TextEditingController _endWorkDateController = TextEditingController();

  TextEditingController _companyController = TextEditingController();
  TextEditingController _positionController = TextEditingController();
  TextEditingController _sectorController = TextEditingController();

  TextEditingController _universityController = TextEditingController();
  TextEditingController _sectionController = TextEditingController();

  TextEditingController _startEducationDateController = TextEditingController();

  TextEditingController _graduateDateController = TextEditingController();

  DateTime? _selectedBirthDate;
  DateTime? _selectedStartEducationDate;
  DateTime? _selectedEndEducationDate;
  String _selectedEducation = educationList.first;

  String _selectedSkill = skillsList.first;

  String _selectedCity = cityList.first;

  String _selectedWorkCity = cityList.first;
  String _selectedLanguage = languageList.first;
  String _selectedLanguageLevel = languageLevelList.first;

  Skill? selectedSkill;
  SocialMedia? selectedMedia;

  final CollectionReference workCollection =
      FirebaseFirestore.instance.collection('work');
  final CollectionReference educationCollection =
      FirebaseFirestore.instance.collection('education');
  final CollectionReference skillsCollection =
      FirebaseFirestore.instance.collection('skills');
  final CollectionReference certificatesCollection =
      FirebaseFirestore.instance.collection('certificates');
  final CollectionReference socialMediaCollection =
      FirebaseFirestore.instance.collection('socialMedia');
  final CollectionReference languageCollection =
      FirebaseFirestore.instance.collection('languages');
  final CollectionReference settingsCollection =
      FirebaseFirestore.instance.collection('settings');

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Yetkinlikler",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 57.0,
                  child: DropdownButtonFormField<String>(
                    value: _selectedSkill,
                    decoration: InputDecoration(
                      hintText: _selectedSkill,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    icon: const Icon(Icons.arrow_drop_down),
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    onChanged: (String? value) {
                      setState(() {
                        _selectedSkill = value!;
                      });
                    },
                    items: skillsList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                ),
                onPressed: () {
                  _saveSkillsToFirestore();
                },
                child: Text(
                  "Kaydet",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _saveSkillsToFirestore() async {
    final String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      print("Kullanıcı girişi yapılmamış.");
      return;
    }
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    // `skills` yerine, `users` koleksiyonu altındaki `userId` ile belirtilen kullanıcıya ve onun `skills` alt koleksiyonuna erişim sağla
    await firestore.collection('users').doc(userId).collection('skills').add({
      'skill': _selectedSkill,
    });

    // Başarılı kayıt sonrası kullanıcıyı önceki sayfaya yönlendir
    Navigator.pop(context, true);
  }
}
