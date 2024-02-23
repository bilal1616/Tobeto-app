import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tobeto_app/widget/profile_widgets/custom_date_picker.dart';
import 'package:tobeto_app/widget/profile_widgets/custom_skills_dropdown.dart';
import 'package:tobeto_app/widget/profile_widgets/custom_socialmedia_dropdown.dart';
import 'package:tobeto_app/widget/profile_widgets/custom_text_field.dart';

List<String> cityList = <String>[
  'İstanbul',
  'İzmir',
  'Ankara',
  'Bursa',
  'Kocaeli'
];

class WorkTab extends StatefulWidget {
  @override
  _WorkTabState createState() => _WorkTabState();
}

class _WorkTabState extends State<WorkTab> {
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
  TextEditingController _emailController = TextEditingController();

  TextEditingController _descriptionController = TextEditingController();

  TextEditingController _startWorkDateController = TextEditingController();

  TextEditingController _endWorkDateController = TextEditingController();

  TextEditingController _companyController = TextEditingController();
  TextEditingController _positionController = TextEditingController();
  TextEditingController _sectorController = TextEditingController();
  String _selectedWorkCity = cityList.first;

  Skill? selectedSkill;
  SocialMedia? selectedMedia;

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CompCustomTextField(
              obscureText: false,
              controller: _companyController,
              helperText: 'Kurum Adı',
              hintText: 'Kampüs 365',
            ),
            CompCustomTextField(
              obscureText: false,
              controller: _positionController,
              helperText: "Pozisyon",
              hintText: 'Front-end Developer',
            ),
            CompCustomTextField(
              obscureText: false,
              controller: _sectorController,
              helperText: "Sektör",
              hintText: 'Yazılım',
            ),
            _buildStartDateTextField(),
            _buildEndDateTextField(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Şehir",
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
                      value: _selectedWorkCity,
                      decoration: InputDecoration(
                        hintText: _selectedWorkCity,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                      icon: const Icon(Icons.arrow_drop_down),
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      onChanged: (String? value) {
                        setState(() {
                          _selectedWorkCity = value!;
                        });
                      },
                      items: cityList
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            CompCustomTextField(
              obscureText: false,
              controller: _descriptionController,
              helperText: "İş Açıklaması",
              hintText: '',
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
                    _saveWorkToFirestore();
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
      ),
    );
  }

  Widget _buildStartDateTextField() {
    return DatePickerTextField(
      controller: _startWorkDateController,
      labelText: 'İş Başlangıcı',
      onDateSelected: (DateTime selectedStartWorkDate) {},
    );
  }

  Widget _buildEndDateTextField() {
    return DatePickerTextField(
      controller: _endWorkDateController,
      labelText: 'İş Bitişi',
      onDateSelected: (DateTime selectedEndWorkDate) {},
    );
  }

  void _saveWorkToFirestore() async {
    final String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    // "users" koleksiyonundaki kullanıcı belgesine referans
    final DocumentReference userDocRef =
        firestore.collection('users').doc(userId);

    // "workExperiences" alt koleksiyonuna yeni bir iş deneyimi belgesi ekle
    final CollectionReference workExperiences =
        userDocRef.collection('workExperiences');

    // Yeni iş deneyimi belgesi oluştur
    await workExperiences.add({
      'company': _companyController.text,
      'position': _positionController.text,
      'sector': _sectorController.text,
      'startDate': _startWorkDateController.text.trim(),
      'endDate': _endWorkDateController.text.trim(),
      'description': _descriptionController.text,
      'city': _selectedWorkCity,
      // Diğer alanlar buraya eklenebilir
    });

    // Başarılı kayıt sonrası kullanıcıyı önceki sayfaya yönlendir
    Navigator.pop(context, true);
  }
}
