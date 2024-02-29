import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tobeto_app/screen/profil_edit.dart';
import 'package:tobeto_app/screen/profile_edit/work_experience.dart';
import 'package:tobeto_app/widget/reviews_widget/view_report.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late String name = "";
  late String surname = "";
  late String birthDate = "";
  late String email = "";
  late String phone = "";
  late String city = "";
  late String country = "";
  late String tc = "";
  late String skill = "";
  late String socialMedia = "";
  late String language = "";
  late String education = "";
  late String work = "";
  late String profilePictureURL = "";
  late String certificateURL = "";
  // Diğer değişken tanımlamalarınızın altına bu listeyi ekleyin
  List<String> userSkills = [];
  late List<Map<String, String>> socialMediaLinks = [];

  @override
  void initState() {
    super.initState();
    fetchUserProfileData();
    fetchUserWorkData();
    fetchUserEducationData();
    fetchUserSkills();
    fetchUserCertificates();
    fetchUserSocialMediaLinks();
    fetchUserLanguageData();
  }

  Future<void> fetchUserProfileData() async {
    final String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    final QuerySnapshot<Map<String, dynamic>> profileSnapshot =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('profiles')
            .get();

    if (profileSnapshot.docs.isNotEmpty) {
      final Map<String, dynamic> userProfile =
          profileSnapshot.docs.first.data();

      setState(() {
        name = userProfile['name'] ?? '';
        surname = userProfile['surname'] ?? '';
        birthDate = userProfile['birthdate'] ?? '';
        email = userProfile['email'] ?? '';
        phone = userProfile['phone'] ?? '';
        city = userProfile['city'] ?? '';
        country = userProfile['country'] ?? '';
        tc = userProfile['tc'] ?? '';
        profilePictureURL = userProfile['profilePictureURL'] ?? '';
      });
    }
  }

  Future<void> fetchUserSkills() async {
    final String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      print("Kullanıcı girişi yapılmamış.");
      return;
    }

    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final QuerySnapshot skillSnapshot = await firestore
        .collection('users')
        .doc(userId)
        .collection('skills')
        .get();

    List<String> fetchedSkills = [];
    for (var doc in skillSnapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      String skill = data['skill'] ?? 'Bilinmeyen Yetenek';
      fetchedSkills.add(skill);
    }

    // UI'da göstermek üzere yetenek listesini güncelle
    setState(() {
      userSkills = fetchedSkills; // skillsList yerine userSkills kullanın
    });
  }

  List<WorkExperience> workExperiences =
      []; // Sınıfın üstünde bir state değişkeni olarak tanımlayın
  Future<void> fetchUserWorkData() async {
    try {
      final String? userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) {
        throw Exception("Kullanıcı girişi yapılmamış.");
      }
      // Firestore'dan kullanıcının iş deneyimlerini çek
      final QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .collection('workExperiences')
              .get();

      // Firestore'dan çekilen verileri WorkExperience modeline dönüştür ve listeyi güncelle
      final List<WorkExperience> newWorkExperiences =
          querySnapshot.docs.map((doc) {
        return WorkExperience.fromFirestore(doc.data() as Map<String, dynamic>);
      }).toList();

      // UI'da göstermek üzere state güncelleme
      setState(() {
        workExperiences = newWorkExperiences;
        // Her bir iş deneyimi için detaylı bir açıklama oluştur
        work = workExperiences
            .map((e) => '${e.position}\n${e.sector}\n${e.company}\n${e.city}')
            .join('');
      });
    } catch (e) {
      print('Error fetching user work data: $e');
    }
  }

  Future<void> fetchUserEducationData() async {
    final String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      print("User ID is null. Cannot fetch education data.");
      return;
    }

    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final QuerySnapshot educationSnapshot = await firestore
        .collection('users')
        .doc(userId)
        .collection('education')
        .get();

    String fetchedEducation = "";

    if (educationSnapshot.docs.isNotEmpty) {
      for (var doc in educationSnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        String university = data['university'] ?? 'Unknown University';
        String section = data['section'] ?? 'Unknown Section';
        String educationStatus = data['educationStatus'] ?? 'Unknown Status';
        String startDate = data['startDate'] ?? 'Unknown Start Date';
        String graduateDate = data['graduateDate'] ?? 'Unknown Graduate Date';

        fetchedEducation +=
            "$university\n$section\n$educationStatus\n$startDate - $graduateDate\n";
      }

      setState(() {
        education = fetchedEducation;
      });
    }
  }

  Future<void> fetchUserLanguageData() async {
    final String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      print("User ID is null. Cannot fetch language data.");
      return;
    }

    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Kullanıcının kaydettiği dilleri çekiyoruz.
    final QuerySnapshot languageSnapshot = await firestore
        .collection('users')
        .doc(userId)
        .collection('languages')
        .get();

    List<String> languages = [];
    languageSnapshot.docs.forEach((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      String language = data['language'] ?? '';
      String level = data['level'] ?? '';
      languages.add("$language ($level)");
    });

    // UI'da göstermek üzere dilleri ve seviyeleri birleştirilmiş string olarak güncelle
    setState(() {
      language = languages.join('\n');
    });
  }

  Future<void> fetchUserCertificates() async {
    final String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      print("Kullanıcı girişi yapılmamış.");
      return;
    }

    final QuerySnapshot certificateSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('certificates')
        .orderBy('uploadedAt', descending: true)
        .get();

    List<String> certificateURLs = certificateSnapshot.docs.map((doc) {
      // Hatanın giderilmesi için ek açıklık
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return data['certificateURL'] as String;
    }).toList();

    setState(() {
      // Hata nedeniyle mevcut olmayabilir, control eklenmeli
      certificateURL = certificateURLs.isNotEmpty ? certificateURLs.first : '';
    });
  }

  Widget _buildCertificateSection() {
    return certificateURL.isNotEmpty
        ? Image.network(certificateURL)
        : Text("Henüz bir sertifika yüklenmedi.");
  }

  Future<void> fetchUserSocialMediaLinks() async {
    final String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    final QuerySnapshot<Map<String, dynamic>> socialMediaSnapshot =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('socialMedia')
            .get();

    // Her bir dokümanı Map<String, String> olarak dönüştür
    List<Map<String, String>> links = socialMediaSnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data();
      // Veriyi Map<String, String> olarak dönüştür
      return {
        "platform":
            data['platform'] is String ? data['platform'] as String : 'Unknown',
        "link": data['link'] is String ? data['link'] as String : '',
      };
    }).toList();

    setState(() {
      socialMediaLinks = links;
    });
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch $url')),
      );
    }
  }

  Widget _buildSocialMediaContainer(
      String title, List<Map<String, String>> links) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Container(
                width: double.infinity,
                height: 1,
                color: Colors.black,
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: links.length,
              itemBuilder: (context, index) {
                final item = links[index];
                return ListTile(
                  title: Text(
                    item['platform']!,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    item['link']!,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  onTap: () => _launchURL(item['link']!),
                );
              },
            ),
          ],
        ),
      ),
    );
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
                  height: screenHeight / 1.1,
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
                        height: screenHeight / 4,
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
                              ? CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    profilePictureURL,
                                  ),
                                )
                              : CircleAvatar(
                                  backgroundColor: Color(0xFF41528f),
                                  radius: 80,
                                  child: Icon(
                                    Icons.person,
                                    size: 80,
                                    color: Color(0xFF9e91f0),
                                  )),
                        ),
                      ),
                      _buildPersonalInfo(
                          "Ad Soyad", "$name $surname", "assets/cv-name.png"),
                      SizedBox(height: 10),
                      _buildPersonalInfo(
                          "Doğum Tarihi", birthDate, "assets/cv-date.png"),
                      SizedBox(height: 10),
                      _buildPersonalInfo("E-mail", email, "assets/cv-mail.png"),
                      SizedBox(height: 10),
                      _buildPersonalInfo(
                          "Telefon", phone, "assets/cv-phone.png"),
                      _buildPersonalInfo("Şehir", city, "assets/city.png"),
                      _buildPersonalInfo("Ülke", country, "assets/country.png"),
                      _buildPersonalInfo("TC Kimlik No", tc, "assets/tc.png"),
                    ],
                  ),
                ),
              ),
              _buildContainerWithTitle("Hakkımda",
                  "$name $surname\n$birthDate\n$email\n$city\n$country"),
              _buildContainerWithTitle("Yetkinliklerim", userSkills.join("\n")),
              _buildContainerWithTitle("Yabancı Dillerim", language),
              _buildContainerWithCertificate("Sertifikalarım", certificateURL),
              _buildSocialMediaContainer("Medya Hesaplarım", socialMediaLinks),
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
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ViewReport()),
                                  );
                                },
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
              _buildContainerWithTitle("Eğitim Hayatı", education),
              _buildContainerWithTitle("Deneyimlerim", work),
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
                // Profil düzenleme sayfasına yönlendir
                Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileInformation()))
                    .then((value) {
                  if (value == true) {
                    // Kullanıcı bilgilerini yeniden fetch et
                    fetchUserProfileData();
                  }
                });
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
              Text(
                name,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                email,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.bold),
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
        height: screenHeight / 5,
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
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.bold),
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
              child: Text(
                subtitle,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
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
          height: screenHeight / 5,
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
                    child: Text("Henüz bir sertifika eklemediniz."),
                  ),
          ],
        ),
      ),
    );
  }
}
