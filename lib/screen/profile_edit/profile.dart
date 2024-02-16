import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tobeto_app/widget/profile_widgets/custom_date_picker.dart';
import 'package:tobeto_app/widget/profile_widgets/custom_skills_dropdown.dart';
import 'package:tobeto_app/widget/profile_widgets/custom_socialmedia_dropdown.dart';
import 'package:tobeto_app/widget/profile_widgets/custom_text_field.dart';

List<String> cityList = <String>['istanbul', 'izmir', 'Ankara', 'Antalya'];


class ProfilTab extends StatefulWidget {
  @override
  _ProfilTabState createState() => _ProfilTabState();
}
class _ProfilTabState extends State<ProfilTab> {
  File? _image;

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
 

  DateTime? _selectedBirthDate;
  DateTime? _selectedStartEducationDate;
  DateTime? _selectedEndEducationDate;
  
  String _selectedCity=cityList.first;
  
  

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildImage(),
            CompCustomTextField(
              obscureText: false,
              controller: _nameController,
              helperText: 'Adınız',
              hintText: 'Adınızı girin',
            ),
            CompCustomTextField(
              obscureText: false,
              controller: _surnameController,
              helperText: "Soyadınız",
              hintText: 'Soyadınızı girin',
            ),
            CompCustomTextField(
              obscureText: false,
              controller: _phoneController,
              helperText: 'Telefon Numaranız',
              hintText: 'Telefon numaranızı girin',
            ),
            _buildDateTextField(),
            CompCustomTextField(
              obscureText: false,
              controller: _tcController,
              helperText: "T.C kimlik  numaranız",
              hintText: 'T.C kimlik no girin',
            ),
            CompCustomTextField(
              obscureText: false,
              controller: _emailController,
              helperText: "E-mail",
              hintText: 'E-mail girin',
            ),
            CompCustomTextField(
              obscureText: false,
              controller: _countryController,
              helperText: "Ülke",
              hintText: 'Ülkenizi girin',
            ),
            // CustomCityDropdown(
            //   labelText: 'Şehir',
            //   selectedCity: selectedCity1,
            //   options: allCities,
            //   onChanged: (CustomCity? newValue) {
            //     setState(() {
            //       selectedCity1 = newValue;
            //     });
            //   },
            // ),
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
      value: _selectedCity,
      decoration: InputDecoration(
        hintText: _selectedCity,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
      icon: const Icon(Icons.arrow_drop_down),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      onChanged: (String? value) {
        setState(() {
          _selectedCity = value!;
        });
      },
      items: cityList.map<DropdownMenuItem<String>>((String value) {
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
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                  ),
                  onPressed: () {
                    _saveProfileToFirestore();
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

  Widget _buildDateTextField() {
    return DatePickerTextField(
      controller: _birthDateController,
      labelText: 'Doğum Tarihiniz',
      onDateSelected: (DateTime selectedBirthDate) {},
    );
  }

  Widget _buildImage() {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CircleAvatar(
          radius: 80,
          backgroundImage: _image != null ? FileImage(_image!) : null,
          child: _image == null
              ? Icon(
                  Icons.person,
                  size: 80,
                  color: Colors.white,
                )
              : null,
        ),
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.blue,
          child: IconButton(
            icon: Icon(Icons.add),
            onPressed: _pickImage,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
void _saveProfileToFirestore() async {  
final String? userId = FirebaseAuth.instance.currentUser?.uid;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final CollectionReference<Map<String, dynamic>> profilesCollection =
      firestore.collection('profiles');
      
  await profilesCollection.doc(userId).set({
    'name': _nameController.text,
    'surname': _surnameController.text,
    'phone': _phoneController.text,
    'birthdate': _birthDateController.text.trim(),
    'tc': _tcController.text,
    'email': _emailController.text,
    'country': _countryController.text,
    'city': _selectedCity,
  });

  if (_image != null) {
    String fileName = 'profilePictures/${userId}.jpg';
    Reference storageReference = FirebaseStorage.instance.ref().child(fileName);

    await storageReference.putFile(_image!);
    String downloadURL = await storageReference.getDownloadURL();
    await profilesCollection.doc(userId).update({
      'profilePictureURL': downloadURL,
    });
  }
}
}
