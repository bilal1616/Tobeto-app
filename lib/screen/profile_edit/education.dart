import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tobeto_app/screen/profile_edit/profile.dart';
import 'package:tobeto_app/screen/profile_edit/work.dart';
import 'package:tobeto_app/widget/profile_widgets/custom_date_picker.dart';
import 'package:tobeto_app/widget/profile_widgets/custom_skills_dropdown.dart';
import 'package:tobeto_app/widget/profile_widgets/custom_socialmedia_dropdown.dart';
import 'package:tobeto_app/widget/profile_widgets/custom_text_field.dart';


List<String> educationList = <String>['Lisans', 'Önlisans', 'Yüksek Lisans', 'Doktora'];
List<String> cityList = <String>['istanbul', 'izmir', 'Ankara', 'Antalya'];

class EductionTab extends StatefulWidget {
  @override
  _EductionTabState createState() => _EductionTabState();
}
class _EductionTabState extends State<EductionTab> {

  @override
  TextEditingController _universityController = TextEditingController();
  TextEditingController _sectionController = TextEditingController();

  TextEditingController _startEducationDateController =TextEditingController();
 
    TextEditingController _graduateDateController = TextEditingController();

  DateTime? _selectedStartEducationDate;
  DateTime? _selectedEndEducationDate;
  String _selectedEducation=educationList.first;
  
  
  
  String _selectedCity=cityList.first;
  
  

  Skill? selectedSkill;
  SocialMedia? selectedMedia;


  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(15.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CompCustomTextField(
              obscureText: false,
              controller: _universityController,
              helperText: 'Üniversite',
              hintText: 'Kampüs 365',
            ),
            CompCustomTextField(
              obscureText: false,
              controller: _sectionController,
              helperText: "Bölüm",
              hintText: 'Yazılım',
            ),
         Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Eğitim Durumu",
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
      value: _selectedEducation,
      decoration: InputDecoration(
        hintText: _selectedEducation,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
      icon: const Icon(Icons.arrow_drop_down),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      onChanged: (String? value) {
        setState(() {
          _selectedEducation = value!;
        });
      },
      items: educationList.map<DropdownMenuItem<String>>((String value) {
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
            _buildEducationStartDateTextField(),
            _buildGradudateDateTextField(),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                  ),
                  onPressed: () {
                     _saveEducationToFirestore();
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



   Widget _buildEducationStartDateTextField() {
    return DatePickerTextField(
      controller: _startEducationDateController,
      labelText: 'Başlangıç Tarihi',
      onDateSelected: (DateTime selectedStartEducationDate) {},
    );
  }

  Widget _buildGradudateDateTextField() {
    return DatePickerTextField(
      controller: _graduateDateController,
      labelText: 'Mezuniyet Tarihi',
      onDateSelected: (DateTime selectedEndEducationDate) {},
    );
  }

  Widget _buildEducationTab() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CompCustomTextField(
              obscureText: false,
              controller: _universityController,
              helperText: 'Üniversite',
              hintText: 'Kampüs 365',
            ),
            CompCustomTextField(
              obscureText: false,
              controller: _sectionController,
              helperText: "Bölüm",
              hintText: 'Yazılım',
            ),
         Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Eğitim Durumu",
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
      value: _selectedEducation,
      decoration: InputDecoration(
        hintText: _selectedEducation,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
      icon: const Icon(Icons.arrow_drop_down),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      onChanged: (String? value) {
        setState(() {
          _selectedEducation = value!;
        });
      },
      items: educationList.map<DropdownMenuItem<String>>((String value) {
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
            _buildEducationStartDateTextField(),
            _buildGradudateDateTextField(),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                  ),
                  onPressed: () {
                     _saveEducationToFirestore();
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


void _saveEducationToFirestore() async {
  // Get the Firestore instance
  
  
final String? userId = FirebaseAuth.instance.currentUser?.uid;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Create a reference to the "profiles" collection
  final CollectionReference<Map<String, dynamic>> workCollection =
      firestore.collection('education');

  // Create a new document in the "profiles" collection with the user's email as the document ID
  await workCollection.doc(userId).set({
      'university': _universityController.text,
    'section': _sectionController.text,
    'educationStatus':  _selectedEducation,
    'startDate':   _startEducationDateController.text.trim(), 
    'graduateDate':  _graduateDateController.text.trim(),    
  });

}


}
