// import 'dart:io';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:tobeto_app/widget/profile_widgets/custom_city_dropdown.dart';
// import 'package:tobeto_app/widget/profile_widgets/custom_date_picker.dart';
// import 'package:tobeto_app/widget/profile_widgets/custom_education_dropdown.dart';
// import 'package:tobeto_app/widget/profile_widgets/custom_language_dropdown.dart';
// import 'package:tobeto_app/widget/profile_widgets/custom_skills_dropdown.dart';
// import 'package:tobeto_app/widget/profile_widgets/custom_socialmedia_dropdown.dart';
// import 'package:tobeto_app/widget/profile_widgets/custom_text_field.dart';

// class ProfileInformation extends StatefulWidget {
//   @override
//   _ProfileInformationState createState() => _ProfileInformationState();
// }

// class _ProfileInformationState extends State<ProfileInformation> {
//   File? _image;
//   File? _selectedFile;
//   Language? selectedLanguage;
//   LanguageLevel? selectedLevel;

//   Future<void> _pickFile() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles();

//     if (result != null) {
//       setState(() {
//         _selectedFile = File(result.files.single.path!);
//       });
//     }
//   }
//   Future<void> _pickImage() async {
//     final picker = ImagePicker();
//     final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

//     if (pickedFile != null) {
//       setState(() {
//         _image = File(pickedFile.path);
//       });
//     }
//   }

//   @override
//   TextEditingController _nameController = TextEditingController();
//   TextEditingController _surnameController = TextEditingController();
//   TextEditingController _tcController = TextEditingController();
//   TextEditingController _emailController = TextEditingController();
//   TextEditingController _countryController = TextEditingController();
//   TextEditingController _districtController = TextEditingController();
//   TextEditingController _socialMediaController = TextEditingController();
//   TextEditingController _oldPasswordController = TextEditingController();
//   TextEditingController _newPasswordController = TextEditingController();
//   TextEditingController _newPasswordAgainController = TextEditingController();
//   TextEditingController _phoneController = TextEditingController();

// CustomCity? selectedCity1;
// CustomCity? selectedCity2;
// DateTime? _selectedDate;
// String? selectedEducation;
 
// Skill? selectedSkill;
// SocialMedia? selectedMedia;

//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       initialIndex: 0,
//       length: 8,
//       child: Scaffold(
//         appBar: AppBar(
//           bottom: const TabBar(
//             tabs: <Widget>[
//               Tab(
//                 icon: Icon(Icons.person),
//               ),
//               Tab(
//                 icon: Icon(Icons.work_outline),
//               ),
              
//               Tab(
//                 icon: Icon(Icons.view_agenda),
//               ),
//               Tab(
//                 icon: Icon(Icons.stars),
//               ),
//               Tab(
//                 icon: Icon(Icons.school),
//               ),
//               Tab(
//                 icon: Icon(Icons.share),
//               ),
//               Tab(
//                 icon: Icon(Icons.language),
//               ),
//               Tab(
//                 icon: Icon(Icons.settings),
//               ),
//             ],
//           ),
//         ),
//         body: TabBarView(
//           children: <Widget>[
//             _buildProfilTab(),
//             _buildWorkTab(),
//             _buildEducationTab(),
//             _buildSkills(),
//             _buildCertificates(),
//             _buildSocialMedia(),
//             _buildLanguage(),
//             _buildSettings()
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildProfilTab() {
//     return Padding(
//       padding: const EdgeInsets.all(15.0),
//       child: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             _buildImage(),
//             CompCustomTextField(
//               obscureText: false,
//               controller: _nameController,
//               helperText: 'Adınız',
//               hintText: 'Adınızı girin',
//             ),
//             CompCustomTextField(
//               obscureText: false,
//               controller: _surnameController,
//               helperText: "Soyadınız",
//               hintText: 'Soyadınızı girin',
//             ),
//              CompCustomTextField(
//               obscureText: false,
//               controller: _phoneController,
//               helperText: 'Telefon Numaranız',
//               hintText: 'Telefon numaranızı girin',
//             ),
//             _buildDateTextField(),
//             CompCustomTextField(
//               obscureText: false,
//               controller: _tcController,
//               helperText: "T.C kimlik  numaranız",
//               hintText: 'T.C kimlik no girin',
//             ),
//             CompCustomTextField(
//               obscureText: false,
//               controller: _emailController,
//               helperText: "E-mail",
//               hintText: 'E-mail girin',
//             ),
//             CompCustomTextField(
//               obscureText: false,
//               controller: _surnameController,
//               helperText: "Ülke",
//               hintText: 'Ülkenizi girin',
//             ),
//             CustomCityDropdown(
//               labelText: 'Şehir',
//               selectedCity: selectedCity1,
//               options: allCities,
//               onChanged: (CustomCity? newValue) {
//                 setState(() {
//                   selectedCity1 = newValue;
//                 });
//               },
//             ),
//              Padding(
//           padding: const EdgeInsets.all(15.0),
//           child: Container(
//             width: double.infinity,
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.purple,
//               ),
//               onPressed: () {}, 
//               child: Text(
//                 "Kaydet",
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//           ),
//         ),
//           ],
//         ),
//       ),
//     );
//   }
// Widget _buildDateTextField() {
//   TextEditingController DateController = TextEditingController();
//   return DatePickerTextField(
//     controller: DateController,
//     labelText: 'Doğum Tarihiniz',
//     onDateSelected: (DateTime selectedDate) {
//     },
//   );
// }

//   Widget _buildImage() {
//     return Stack(
//       alignment: Alignment.bottomRight,
//       children: [
//         CircleAvatar(
//           radius: 80,
//           backgroundImage: _image != null ? FileImage(_image!) : null,
//           child: _image == null
//               ? Icon(
//                   Icons.person,
//                   size: 80,
//                   color: Colors.white,
//                 )
//               : null,
//         ),
//         CircleAvatar(
//           radius: 30,
//           backgroundColor: Colors.blue,
//           child: IconButton(
//             icon: Icon(Icons.add),
//             onPressed: _pickImage,
//             color: Colors.white,
//           ),
//         ),
//       ],
//     );
//   }


//   Widget _buildWorkTab() {
//     return  Padding(
//       padding: const EdgeInsets.all(15.0),
//       child: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             CompCustomTextField(
//               obscureText: false,
//               controller: _nameController,
//               helperText: 'Kurum Adı',
//               hintText: 'Kampüs 365',
//             ),
//             CompCustomTextField(
//               obscureText: false,
//               controller: _surnameController,
//               helperText: "Pozisyon",
//               hintText: 'Front-end Developer',
//             ),
//             CompCustomTextField(
//               obscureText: false,
//               controller: _tcController,
//               helperText: "Sektör",
//               hintText: 'Yazılım',
//             ),
//                 _buildStartDateTextField(),
//                 _buildEndDateTextField(),
//           CustomCityDropdown(
//               labelText: 'Şehir',
//               selectedCity: selectedCity2,
//               options: allCities,
//               onChanged: (CustomCity? newValue) {
//                 setState(() {
//                   selectedCity2 = newValue;
//                 });
//               },
//             ),
//             CompCustomTextField(
//               obscureText: false,
//               controller: _emailController,
//               helperText: "İş Açıklaması",
//               hintText: '',
//             ),
//             Padding(
//           padding: const EdgeInsets.all(15.0),
//           child: Container(
//             width: double.infinity,
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.purple,
//               ),
//               onPressed: () {}, 
//               child: Text(
//                 "Kaydet",
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//           ),
//         ),
//           ],
//         ),
//       ),
//     );
//   }


// Widget _buildStartDateTextField() {
//   TextEditingController startDateController = TextEditingController();
//   return DatePickerTextField(
//     controller: startDateController,
//     labelText: 'İş Başlangıcı',
//     onDateSelected: (DateTime selectedDate) {
//     },
//   );
// }


// Widget _buildEndDateTextField() {
//   TextEditingController endDateController = TextEditingController();
//   return DatePickerTextField(
//     controller: endDateController,
//     labelText: 'İş Bitişi',
//     onDateSelected: (DateTime selectedDate) {
//     },
//   );
// }

// Widget _buildEducationStartDateTextField() {
//   TextEditingController startEducationDateController = TextEditingController();
//   return DatePickerTextField(
//     controller: startEducationDateController,
//     labelText: 'Başlangıç Tarihi',
//     onDateSelected: (DateTime selectedDate) {
//     },
//   );
// }
// Widget _buildGradudateDateTextField() {
//   TextEditingController graduateDateController = TextEditingController();
//   return DatePickerTextField(
//     controller: graduateDateController,
//     labelText: 'Mezuniyet Tarihi',
//     onDateSelected: (DateTime selectedDate) {
//     },
//   );
// }

//   Widget _buildEducationTab() {
//     return Padding(
//       padding: const EdgeInsets.all(15.0),
//       child: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             CompCustomTextField(
//               obscureText: false,
//               controller: _nameController,
//               helperText: 'Üniversite',
//               hintText: 'Kampüs 365',
//             ),
//             CompCustomTextField(
//               obscureText: false,
//               controller: _tcController,
//               helperText: "Bölüm",
//               hintText: 'Yazılım',
//             ),
//                CustomEducationDropdown(
//               labelText: 'Eğitim Durumu',
//               selectedValue: selectedEducation,
//               options: ['Lisans', 'Ön Lisans', 'Yüksek Lisans', 'Doktora'],
//               onChanged: (String? newValue) {
//                 setState(() {
//                   selectedEducation = newValue;
//                 });
//               },
//             ),
//             _buildEducationStartDateTextField(),
//              _buildGradudateDateTextField(),
//               Padding(
//           padding: const EdgeInsets.all(15.0),
//           child: Container(
//             width: double.infinity,
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.purple,
//               ),
//               onPressed: () {}, 
//               child: Text(
//                 "Kaydet",
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//           ),
//         ),
//           ],
//         ),
//       ),
//     );
//   }

//  Widget _buildSkills() {
//     return Padding(
//       padding: const EdgeInsets.all(15.0),
//       child: Column(
//         children: [
//           CustomSkillsDropdown(
//             labelText: 'Yetkinliklerim',
//             selectedSkill: selectedSkill,
//             options: skills,
//             onChanged: (Skill? newValue) {
//               setState(() {
//                 selectedSkill = newValue;
//               });
//             },
//           ),
//           Padding(
//           padding: const EdgeInsets.all(15.0),
//           child: Container(
//             width: double.infinity,
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.purple,
//               ),
//               onPressed: () {}, 
//               child: Text(
//                 "Kaydet",
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//           ),
//         ),
//         ],
//       ),
//     );
//   }

// Widget _buildCertificates(){
//   return Padding(
//     padding: const EdgeInsets.all(20.0),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Text('Sertifikalarım',
//           style: TextStyle(fontWeight: FontWeight.bold,
//           fontSize: 20),),
//           SizedBox(height: 10),
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.purple,
//             ),
//             onPressed: _pickFile,
//             child: Text("Dosya Seç",
//             style: TextStyle(
//               color: Colors.white,
//             )),
//           ),
//           SizedBox(height: 20),
//           _selectedFile != null
//               ? Text("Seçilen Dosya: ${_selectedFile!.path}")
//               : Text("Henüz dosya seçilmedi."),
//         ],
//       ),
//   );
// }


// Widget _buildSocialMedia(){
//   return Padding(
//     padding: const EdgeInsets.all(15.0),
//     child: Column(
//       children: [
//         CustomSocialMediaDropdown(
//         labelText: 'Sosyal Medya Seçiniz',
//         selectedSocialMedia: selectedMedia,
//         options: socialMediaOptions,
//         onChanged: (SocialMedia? value) {
//           setState(() {
//             selectedMedia = value;
//           });
//         },
//         ),
//          CompCustomTextField(
//               obscureText: false,
//               controller: _socialMediaController,
//               helperText: '',
//               hintText: 'https://',
//             ),
//             Padding(
//           padding: const EdgeInsets.all(15.0),
//           child: Container(
//             width: double.infinity,
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.purple,
//               ),
//               onPressed: () {}, 
//               child: Text(
//                 "Kaydet",
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// }
// Widget _buildSettings() {
//   return Padding(
//     padding: const EdgeInsets.all(15.0),
//     child: Column(
//       children: [
//         CompCustomTextField(
//           obscureText: false,
//           controller: _oldPasswordController,
//           helperText: 'Eski Şifre',
//           hintText: 'Eski Şifre',
//         ),
//         CompCustomTextField(
//           obscureText: false,
//           controller: _newPasswordController,
//           helperText: 'Yeni Şifre',
//           hintText: 'Yeni Şifre',
//         ),
//         CompCustomTextField(
//           obscureText: false,
//           controller: _newPasswordAgainController,
//           helperText: 'Yeni Şifre Tekrar',
//           hintText: 'Yeni Şifre Tekrar',
//         ),
//         Padding(
//           padding: const EdgeInsets.all(15.0),
//           child: Container(
//             width: double.infinity,
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.purple,
//               ),
//               onPressed: () {}, 
//               child: Text(
//                 "Kaydet",
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//           ),
//         ),
//         SizedBox(width: 8), 
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal:15.0),
//           child: Container(
//             width: double.infinity,
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.red,
//               ),
//               onPressed: () {}, 
//               child: Text(
//                 "Üyeliği Sonlandır",
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// }

//  Widget _buildLanguage(){
//   return Padding(
//     padding: const EdgeInsets.all(15.0),
//     child: Column(
//       children: [
//         CustomLanguageDropdown(
//                 labelText: 'Yabancı Dil Seçin',
//                 selectedLanguage: selectedLanguage,
//                 options: languages,
//                 onChanged: (Language? language) {
//                   setState(() {
//                     selectedLanguage = language;
//                   });
//                 },
//               ),
//               CustomLanguageLevelDropdown(
//           labelText: 'Seviye Seçin',
//           selectedLevel: selectedLevel,
//           options: languageLevels,
//           onChanged: (LanguageLevel? level) {
//             setState(() {
//               selectedLevel = level;
//             });
//           },
//         ),
//          Padding(
//           padding: const EdgeInsets.all(15.0),
//           child: Container(
//             width: double.infinity,
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.purple,
//               ),
//               onPressed: () {}, 
//               child: Text(
//                 "Kaydet",
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
//  }

// }




import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tobeto_app/widget/profile_widgets/custom_date_picker.dart';
import 'package:tobeto_app/widget/profile_widgets/custom_skills_dropdown.dart';
import 'package:tobeto_app/widget/profile_widgets/custom_socialmedia_dropdown.dart';
import 'package:tobeto_app/widget/profile_widgets/custom_text_field.dart';

  List<String> educationList = <String>['Lisans', 'Önlisans', 'Yüksek Lisans', 'Doktora'];

   List<String> cityList = <String>['istanbul', 'izmir', 'Ankara', 'Antalya'];
List<String> skillsList = [
    'C#', 'SQL','Muhasebe','Javascript', 'Aktif Öğrenme',
     'Aktif Dinleme',
     'Uyum Sağlama',
     'Yönetim ve İdare',
     'Reklam',
     'Algoritmalar',
     'Android',
  ];

 List<String> languageList = <String>['ingilizce', 'almanca', 'ispanyolca', 'fransızca'];
 List<String> languageLevelList = <String>[

    'Temel Seviye(A1-A2)',
    'Orta Seviye(B1-B2)',
    'İleri Seviye(C1-C2)',
     'Anadil'];
class ProfileInformation extends StatefulWidget {
  @override
  _ProfileInformationState createState() => _ProfileInformationState();
}
class _ProfileInformationState extends State<ProfileInformation> {
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

  TextEditingController _startEducationDateController =TextEditingController();
 
    TextEditingController _graduateDateController = TextEditingController();

  DateTime? _selectedBirthDate;
  DateTime? _selectedStartEducationDate;
  DateTime? _selectedEndEducationDate;
  String _selectedEducation=educationList.first;
  
  String _selectedSkill=skillsList.first;
  
  String _selectedCity=cityList.first;
  
  String _selectedWorkCity=cityList.first;
  String _selectedLanguage=languageList.first;
  String _selectedLanguageLevel=languageLevelList.first;


  Skill? selectedSkill;
  SocialMedia? selectedMedia;

  final CollectionReference profileCollection =
      FirebaseFirestore.instance.collection('profiles');
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
    return DefaultTabController(
      initialIndex: 0,
      length: 8,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.person),
              ),
              Tab(
                icon: Icon(Icons.work_outline),
              ),
              Tab(
                icon: Icon(Icons.view_agenda),
              ),
              Tab(
                icon: Icon(Icons.stars),
              ),
              Tab(
                icon: Icon(Icons.school),
              ),
              Tab(
                icon: Icon(Icons.share),
              ),
              Tab(
                icon: Icon(Icons.language),
              ),
              Tab(
                icon: Icon(Icons.settings),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            _buildProfilTab(),
            _buildWorkTab(),
            _buildEducationTab(),
            _buildSkills(),
            _buildCertificates(),
            _buildSocialMedia(),
            _buildLanguage(),
            _buildSettings()
          ],
        ),
      ),
    );
  }

  Widget _buildProfilTab() {
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
            height: 45.0,
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
    await profileCollection.doc(_emailController.text).set({
      'name': _nameController.text,
      'surname': _surnameController.text,
      'phone': _phoneController.text,
      'birthdate': _birthDateController.text.trim(),
      'tc': _tcController.text,
      'email': _emailController.text,
      'country': _countryController.text,
      'city': _selectedCity ,
    });

    if (_image != null) {
      String fileName = 'profilePictures/${_emailController.text}.jpg';
      Reference storageReference =
          FirebaseStorage.instance.ref().child(fileName);

      await storageReference.putFile(_image!);
      String downloadURL = await storageReference.getDownloadURL();

      await profileCollection.doc(_emailController.text).update({
        'profilePictureURL': downloadURL,
      });
    }
  }

  Widget _buildWorkTab() {
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
            height: 45.0,
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
            height: 45.0,
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

  Widget _buildSkills() {
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
            height: 45.0,
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
      items: skillsList.map<DropdownMenuItem<String>>((String value) {
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
    await skillsCollection.doc(_emailController.text).set({
      'skill': _selectedSkill,
    });
  }

  Widget _buildCertificates() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Sertifikalarım',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
            ),
            onPressed: _pickFile,
            child: Text("Dosya Seç",
                style: TextStyle(
                  color: Colors.white,
                )),
          ),
          SizedBox(height: 20),
          _selectedFile != null
              ? Text("Seçilen Dosya: ${_selectedFile!.path}")
              : Text("Henüz dosya seçilmedi."),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                ),
                onPressed: () {
                 // _saveCertificatesToFirestore();
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

  // void _saveCertificatesToFirestore() async {
  //  
  // }

  Widget _buildSocialMedia() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          CustomSocialMediaDropdown(
            labelText: 'Sosyal Medya Seçiniz',
            selectedSocialMedia: selectedMedia,
            options: socialMediaOptions,
            onChanged: (SocialMedia? value) {
              setState(() {
                selectedMedia = value;
              });
            },
          ),
          CompCustomTextField(
            obscureText: false,
            controller: _socialMediaController,
            helperText: '',
            hintText: 'https://',
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
                  _saveSocialMediaToFirestore();
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

  void _saveSocialMediaToFirestore() async {
    await socialMediaCollection.doc(_emailController.text).set({
      'selectedMedia': selectedMedia?.name,
      'socialMediaLink': _socialMediaController.text,
    });
  }

  Widget _buildLanguage() {
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
            "Yabancı Dil Seçin",
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
            height: 45.0,
            child: DropdownButtonFormField<String>(
      value: _selectedLanguage,
      decoration: InputDecoration(
        hintText: _selectedLanguage,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
      icon: const Icon(Icons.arrow_drop_down),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      onChanged: (String? value) {
        setState(() {
          _selectedLanguage = value!;
        });
      },
      items: languageList.map<DropdownMenuItem<String>>((String value) {
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
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Seviye Seçin",
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
            height: 45.0,
            child: DropdownButtonFormField<String>(
      value: _selectedLanguageLevel,
      decoration: InputDecoration(
        hintText: _selectedLanguageLevel,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
      icon: const Icon(Icons.arrow_drop_down),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      onChanged: (String? value) {
        setState(() {
          _selectedLanguageLevel = value!;
        });
      },
      items: languageLevelList.map<DropdownMenuItem<String>>((String value) {
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
                  _saveLanguageToFirestore();
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

  void _saveLanguageToFirestore() async {
    await languageCollection.doc(_emailController.text).set({
      'selectedLanguage': _selectedLanguage,
      'selectedLevel': _selectedLanguageLevel,
    });
  }

  Widget _buildSettings() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          CompCustomTextField(
            obscureText: false,
            controller: _oldPasswordController,
            helperText: 'Eski Şifre',
            hintText: 'Eski Şifre',
          ),
          CompCustomTextField(
            obscureText: false,
            controller: _newPasswordController,
            helperText: 'Yeni Şifre',
            hintText: 'Yeni Şifre',
          ),
          CompCustomTextField(
            obscureText: false,
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
                onPressed: () {
               //   _saveSettingsToFirestore();
                },
                child: Text(
                  "Kaydet",
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
                  //_deleteProfile();
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

  // void _saveSettingsToFirestore() async {
  //   
  // }

  // void _deleteProfile() async {
  //   
  // }
  void _saveWorkToFirestore() async {
  await workCollection.doc(_emailController.text).set({
    'company': _companyController.text,
    'position': _positionController.text,
    'sector': _sectorController.text,
    'startDate':  _startWorkDateController.text.trim(), 
    'endDate':  _endWorkDateController.text.trim(),     
    'email': _emailController.text,
    'description': _descriptionController.text,
  });
}

void _saveEducationToFirestore() async {
  await educationCollection.doc(_emailController.text).set({
    'university': _universityController.text,
    'section': _sectionController.text,
    'educationStatus':  _selectedEducation,
    'startDate':   _startEducationDateController.text.trim(), 
    'graduateDate':  _graduateDateController.text.trim(),    
    'email': _emailController.text,
  });
}
}
