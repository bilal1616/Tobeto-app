import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tobeto_app/widget/profile_widgets/custom_city_dropdown.dart';
import 'package:tobeto_app/widget/profile_widgets/custom_date_picker.dart';
import 'package:tobeto_app/widget/profile_widgets/custom_education_dropdown.dart';
import 'package:tobeto_app/widget/profile_widgets/custom_language_dropdown.dart';
import 'package:tobeto_app/widget/profile_widgets/custom_skills_dropdown.dart';
import 'package:tobeto_app/widget/profile_widgets/custom_socialmedia_dropdown.dart';
import 'package:tobeto_app/widget/profile_widgets/custom_text_field.dart';

class ProfileInformation extends StatefulWidget {
  @override
  _ProfileInformationState createState() => _ProfileInformationState();
}

class _ProfileInformationState extends State<ProfileInformation> {
  File? _image;
  File? _selectedFile;
  Language? selectedLanguage;
  LanguageLevel? selectedLevel;

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
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

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

CustomCity? selectedCity1;
CustomCity? selectedCity2;
DateTime? _selectedDate;
String? selectedEducation;
 
Skill? selectedSkill;
SocialMedia? selectedMedia;

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
              controller: _surnameController,
              helperText: "Ülke",
              hintText: 'Ülkenizi girin',
            ),
            CustomCityDropdown(
              labelText: 'Şehir',
              selectedCity: selectedCity1,
              options: allCities,
              onChanged: (CustomCity? newValue) {
                setState(() {
                  selectedCity1 = newValue;
                });
              },
            ),
             Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
              ),
              onPressed: () {}, 
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
  TextEditingController DateController = TextEditingController();
  return DatePickerTextField(
    controller: DateController,
    labelText: 'Doğum Tarihiniz',
    onDateSelected: (DateTime selectedDate) {
    },
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


  Widget _buildWorkTab() {
    return  Padding(
      padding: const EdgeInsets.all(15.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CompCustomTextField(
              obscureText: false,
              controller: _nameController,
              helperText: 'Kurum Adı',
              hintText: 'Kampüs 365',
            ),
            CompCustomTextField(
              obscureText: false,
              controller: _surnameController,
              helperText: "Pozisyon",
              hintText: 'Front-end Developer',
            ),
            CompCustomTextField(
              obscureText: false,
              controller: _tcController,
              helperText: "Sektör",
              hintText: 'Yazılım',
            ),
                _buildStartDateTextField(),
                _buildEndDateTextField(),
          CustomCityDropdown(
              labelText: 'Şehir',
              selectedCity: selectedCity2,
              options: allCities,
              onChanged: (CustomCity? newValue) {
                setState(() {
                  selectedCity2 = newValue;
                });
              },
            ),
            CompCustomTextField(
              obscureText: false,
              controller: _emailController,
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
              onPressed: () {}, 
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
  TextEditingController startDateController = TextEditingController();
  return DatePickerTextField(
    controller: startDateController,
    labelText: 'İş Başlangıcı',
    onDateSelected: (DateTime selectedDate) {
    },
  );
}


Widget _buildEndDateTextField() {
  TextEditingController endDateController = TextEditingController();
  return DatePickerTextField(
    controller: endDateController,
    labelText: 'İş Bitişi',
    onDateSelected: (DateTime selectedDate) {
    },
  );
}

Widget _buildEducationStartDateTextField() {
  TextEditingController startEducationDateController = TextEditingController();
  return DatePickerTextField(
    controller: startEducationDateController,
    labelText: 'Başlangıç Tarihi',
    onDateSelected: (DateTime selectedDate) {
    },
  );
}
Widget _buildGradudateDateTextField() {
  TextEditingController graduateDateController = TextEditingController();
  return DatePickerTextField(
    controller: graduateDateController,
    labelText: 'Mezuniyet Tarihi',
    onDateSelected: (DateTime selectedDate) {
    },
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
              controller: _nameController,
              helperText: 'Üniversite',
              hintText: 'Kampüs 365',
            ),
            CompCustomTextField(
              obscureText: false,
              controller: _tcController,
              helperText: "Bölüm",
              hintText: 'Yazılım',
            ),
               CustomEducationDropdown(
              labelText: 'Eğitim Durumu',
              selectedValue: selectedEducation,
              options: ['Lisans', 'Ön Lisans', 'Yüksek Lisans', 'Doktora'],
              onChanged: (String? newValue) {
                setState(() {
                  selectedEducation = newValue;
                });
              },
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
              onPressed: () {}, 
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
          CustomSkillsDropdown(
            labelText: 'Yetkinliklerim',
            selectedSkill: selectedSkill,
            options: skills,
            onChanged: (Skill? newValue) {
              setState(() {
                selectedSkill = newValue;
              });
            },
          ),
          Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
              ),
              onPressed: () {}, 
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

Widget _buildCertificates(){
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Sertifikalarım',
          style: TextStyle(fontWeight: FontWeight.bold,
          fontSize: 20),),
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
        ],
      ),
  );
}


Widget _buildSocialMedia(){
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
              onPressed: () {}, 
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
              onPressed: () {}, 
              child: Text(
                "Kaydet",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        SizedBox(width: 8), 
        Padding(
          padding: const EdgeInsets.symmetric(horizontal:15.0),
          child: Container(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () {}, 
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

 Widget _buildLanguage(){
  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: Column(
      children: [
        CustomLanguageDropdown(
                labelText: 'Yabancı Dil Seçin',
                selectedLanguage: selectedLanguage,
                options: languages,
                onChanged: (Language? language) {
                  setState(() {
                    selectedLanguage = language;
                  });
                },
              ),
              CustomLanguageLevelDropdown(
          labelText: 'Seviye Seçin',
          selectedLevel: selectedLevel,
          options: languageLevels,
          onChanged: (LanguageLevel? level) {
            setState(() {
              selectedLevel = level;
            });
          },
        ),
         Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
              ),
              onPressed: () {}, 
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

}

