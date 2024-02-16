import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tobeto_app/screen/profil_edit.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late String name="";
  late String birthDate="";
  late String email="";
  late String phone="";
  late String city="";
  late String skill="";
  late String socialMedia="";
  late String language="";
  late String education="";
  late String work="";
  late String profilePictureURL="";
  late String certificateURL="";
  
  @override
  void initState() {
    super.initState();
    fetchUserProfileData();
    fetchUserSkillData();
    fetchUserLanguageData();
    fetchUserSocialMediaData();
    fetchUserWorkData();
    fetchUserEducationData();
    fetchUserCertificateData();
  }

  Future<void> fetchUserProfileData() async {
    try {
      final String? userId = FirebaseAuth.instance.currentUser?.uid;
      final DocumentSnapshot<Map<String, dynamic>> userProfile =
          await FirebaseFirestore.instance.collection('profiles').doc(userId).get();

      setState(() {
        name = userProfile['name'] ?? '';
        birthDate = userProfile['birthdate'] ?? '';
        email = userProfile['email'] ?? '';
        phone = userProfile['phone'] ?? '';
        city = userProfile['city'] ?? '';
        profilePictureURL = userProfile['profilePictureURL'] ?? '';
      });
    } catch (e) {
      print('Error fetching user profile data: $e');
    }
  }
  
  Future<void> fetchUserCertificateData() async {
    try {
      final String? userId = FirebaseAuth.instance.currentUser?.uid;
      final DocumentSnapshot<Map<String, dynamic>> userCertificate =
          await FirebaseFirestore.instance.collection('certificates').doc(userId).get();

      setState(() {
        certificateURL = userCertificate['certificateURL'] ?? '';
      });
    } catch (e) {
      print('Error fetching user profile data: $e');
    }
  }

  Future<void> fetchUserSkillData() async {
  try {
    final String? userId = FirebaseAuth.instance.currentUser?.uid;
    final DocumentSnapshot<Map<String, dynamic>> userSkills =
        await FirebaseFirestore.instance.collection('skills').doc(userId).get();

    // Null kontrolü yapılıyor
    if (userSkills['skill'].isNotEmpty) {
      setState(() {
        skill = userSkills['skill'];
      });
    } else {
      setState(() {
        skill = "Henüz bir yetkinlik eklemedin";
      });
    }
  } catch (e) {
    print('Error fetching user profile data: $e');
  }
}
  Future<void> fetchUserWorkData() async {
  try {
    final String? userId = FirebaseAuth.instance.currentUser?.uid;
    final DocumentSnapshot<Map<String, dynamic>> userWork =
        await FirebaseFirestore.instance.collection('work').doc(userId).get();

    // Null kontrolü yapılıyor
    if (userWork['position'].isNotEmpty) {
      setState(() {
        work = userWork['position'];
      });
    } else {
      setState(() {
        work = "Henüz bir deneyim eklemedin";
      });
    }
  } catch (e) {
    print('Error fetching user profile data: $e');
  }
}
  Future<void> fetchUserEducationData() async {
  try {
    final String? userId = FirebaseAuth.instance.currentUser?.uid;
    final DocumentSnapshot<Map<String, dynamic>> userEducation =
        await FirebaseFirestore.instance.collection('education').doc(userId).get();

    // Null kontrolü yapılıyor
    if (userEducation['section'].isNotEmpty) {
      setState(() {
        education = userEducation['section'];
      });
    } else {
      setState(() {
        education = "Henüz bir deneyim eklemedin";
      });
    }
  } catch (e) {
    print('Error fetching user profile data: $e');
  }
}


Future<void> fetchUserLanguageData() async {
  try {
    final String? userId = FirebaseAuth.instance.currentUser?.uid;
    final DocumentSnapshot<Map<String, dynamic>> userLanguages =
        await FirebaseFirestore.instance.collection('languages').doc(userId).get();

    // Null kontrolü yapılıyor
    if (userLanguages['selectedLanguage'].isNotEmpty) {
      setState(() {
        language = userLanguages['selectedLanguage'];
      });
    } else {
      setState(() {
        language = "Henüz bir yabancı dil eklemedin";
      });
    }
  } catch (e) {
    print('Error fetching user profile data: $e');
  }
}


 
  Future<void> fetchUserSocialMediaData() async {
  try {
    final String? userId = FirebaseAuth.instance.currentUser?.uid;
    final DocumentSnapshot<Map<String, dynamic>> userSocialMedia =
        await FirebaseFirestore.instance.collection('socialMedia').doc(userId).get();

    // Null kontrolü yapılıyor
    if (userSocialMedia['socialMediaLink'].isNotEmpty) {
      setState(() {
        socialMedia = userSocialMedia['socialMediaLink'];
      });
    } else {
      setState(() {
        socialMedia = "Henüz bir sosyal medya hesabı eklemedin";
      });
    }
  } catch (e) {
    print('Error fetching user profile data: $e');
  }
}



  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildIcons(),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                       color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: screenHeight / 6,
                        width: double.infinity,
                       decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
             gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).primaryColorDark,
                  Theme.of(context).primaryColor,
                ],
             ),
                       ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          
                          child: profilePictureURL.isNotEmpty
                           ?  CircleAvatar(
                    backgroundImage: NetworkImage(
                      profilePictureURL,
                    ),
                  ) :
                  CircleAvatar(
                             backgroundColor: Color(0xFF41528f),
                              radius: 80,
                              child: Icon(
                                Icons.person,
                                size: 80,
                                color: Color(0xFF9e91f0),
                              )
                              ),
                
                        
                        ),
                      ),
                      _buildPersonalInfo(
                          "Ad Soyad", name, "assets/cv-name.png"),
                      SizedBox(height: 10),
                      _buildPersonalInfo(
                          "Doğum Tarihi", birthDate, "assets/cv-date.png"),
                      SizedBox(height: 10),
                      _buildPersonalInfo("E-mail", email,
                          "assets/cv-mail.png"),
                      SizedBox(height: 10),
                      _buildPersonalInfo(
                          "Telefon", phone, "assets/cv-phone.png"),
                    ],
                  ),
                ),
              ),
              _buildContainerWithTitle("Hakkımda", ""),
              _buildContainerWithTitle("Yetkinliklerim", skill),
              _buildContainerWithTitle(
                  "Yabancı Dillerim",language),
              _buildContainerWithCertificate(
                  "Sertifikalarım",  certificateURL),
              _buildContainerWithTitle(
                  "Medya Hesaplarım", socialMedia),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  height: screenHeight / 4.5,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Tobeto İşte Başarı Modelim',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(Icons.remove_red_eye_outlined)
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: double.infinity,
                          height: 1,
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                                "İşte Başarı Modeli değerlendirmesiyle Yetkinliklerini Ölç "),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.purple,
                                ),
                                onPressed: () {},
                                child: Text(
                                  'Başla',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              _buildContainerWithAsset(),
              _buildContainerWithTitle("Eğitim Hayatı",
                  education),
                  _buildContainerWithTitle("Deneyimlerim",
                  work),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcons() {
    return Padding(
      padding: const EdgeInsets.only(right: 30, top: 45),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileInformation()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 1, right: 10),
                child: Icon(Icons.edit_note),
              )),
          Icon(Icons.share_outlined),
        ],
      ),
    );
  }

  Widget _buildPersonalInfo(String name, String email, String assetPath) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Image.asset(assetPath),
            ),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name),
              Text(
                email,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContainerWithTitle(String title, String subtitle) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        height: screenHeight / 10,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
             color: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                width: double.infinity,
                height: 1,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(subtitle),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContainerWithAsset() {
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
          height: screenHeight / 6,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
              color: Theme.of(context).scaffoldBackgroundColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/rozet1.jpg'),
                SizedBox(width: 20),
                Image.asset('assets/rozet2.jpg'),
              ],
            ),
          )),
    );
  }
  Widget _buildContainerWithCertificate(String title, String certificateURL) {
  double screenHeight = MediaQuery.of(context).size.height;

  return Padding(
    padding: const EdgeInsets.all(20),
    child: Container(
      height: screenHeight / 6,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
           color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Container(
              width: double.infinity,
              height: 1,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 5),
          certificateURL.isNotEmpty
              ? Center(
                  child: Container(
                    height: screenHeight / 10,
                    child: Image.network(
                      certificateURL,
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : Center(
                  child: Text(
                    "Henüz bir sertifika eklemediniz."),
                ),
        ],
      ),
    ),
  );
}

}
