import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:tobeto_app/widget/home_widget/announcementandnews.dart';
import 'package:tobeto_app/widget/home_widget/applications.dart';
import 'package:tobeto_app/widget/home_widget/education.dart';
import 'package:tobeto_app/widget/home_widget/examcard.dart';
import 'package:tobeto_app/widget/home_widget/gradient_buttons.dart';
import 'package:tobeto_app/widget/home_widget/surveys.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedOption = 'Başvurularım';
  Map<String, bool> visibility = {
    "Başvurularım": true, // Başlangıçta sadece bu görünür
    "Eğitimlerim": false,
    "Duyuru ve Haberlerim": false,
    "Anketlerim": false,
  };

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "TOBETO",
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor),
                    children: <TextSpan>[
                      TextSpan(
                        text: "'ya hoş geldin Kullanıcı Adı",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .color),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                Text(
                  "Yeni nesil öğrenme deneyimi ile Tobeto kariyer yolculuğunda senin yanında!",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.bodyLarge!.color),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        )
                      ]),
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/ıstanbulkodluyortobeto.png",
                        width: 200,
                        height: 80,
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        child: Text(
                          "Ücretsiz eğitimlerle, geleceğin mesleklerinde sen de yerini al.",
                          textAlign: TextAlign.center,
                          softWrap: true,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: "Aradığın ",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.color ??
                                    Theme.of(context).colorScheme.background,
                              ),
                          children: <TextSpan>[
                            TextSpan(
                              text: '"',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                            ),
                            TextSpan(
                              text: "İş",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.color ??
                                        Theme.of(context)
                                            .colorScheme
                                            .background,
                                  ),
                            ),
                            TextSpan(
                              text: '"',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                            ),
                            TextSpan(
                              text: " Burada! ",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.color ??
                                        Theme.of(context)
                                            .colorScheme
                                            .background,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Wrap(
                          spacing: 8.0, // yatay boşluk
                          runSpacing: 4.0, // dikey boşluk
                          children: <String>[
                            "Başvurularım",
                            "Eğitimlerim",
                            "Duyuru ve Haberlerim",
                            "Anketlerim"
                          ]
                              .map((title) => _buildOption(context, title))
                              .toList(),
                        ),
                      ),
                      SizedBox(height: 18),
                      if (visibility["Başvurularım"]!) Applications(),
                      if (visibility["Eğitimlerim"]!) _buildEducationCards(),
                      if (visibility["Duyuru ve Haberlerim"]!)
                        Announcementandnews(),
                      if (visibility["Anketlerim"]!) Surveys(),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                ExamCard(), // ExamCard'ı burada kullanıyoruz
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      GradientButton(
                        text: 'Profilini oluştur',
                        onPressed: () {
                          // Profil oluşturma işlemi
                        },
                        onSecondaryPressed: () {
                          // 'Başla' butonuna basıldığında yapılacak işlem
                        },
                        gradientColors: [
                          Theme.of(context).primaryColor,
                          Theme.of(context).colorScheme.secondary
                        ],
                      ),
                      SizedBox(height: 16), // Butonlar arası boşluk
                      GradientButton(
                        text: 'Kendini değerlendir',
                        onPressed: () {
                          // Kendini değerlendirme işlemi
                        },
                        onSecondaryPressed: () {
                          // 'Başla' butonuna basıldığında yapılacak işlem
                        },
                        gradientColors: [
                          Theme.of(context).primaryColorLight,
                          Theme.of(context).primaryColorDark
                        ],
                      ),
                      SizedBox(height: 16), // Butonlar arası boşluk
                      GradientButton(
                        text: 'Öğrenmeye başla',
                        onPressed: () {
                          // Öğrenmeye başlama işlemi
                        },
                        onSecondaryPressed: () {
                          // 'Başla' butonuna basıldığında yapılacak işlem
                        },
                        gradientColors: [
                          Theme.of(context).colorScheme.onPrimary,
                          Theme.of(context).primaryColor
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                // Align(
                //   alignment: Alignment.bottomCenter,
                //   child: Container(
                //     width: MediaQuery.of(context).size.width,
                //     height: MediaQuery.of(context).size.height * 0.15,
                //     decoration: BoxDecoration(
                //         color: Theme.of(context).colorScheme.primary),
                //     child: Padding(
                //         padding: EdgeInsets.all(15),
                //         child: Column(
                //           children: [
                //             Row(
                //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //               children: [
                //                 Image.asset("assets/beyazlogo.png",
                //                     width: 120, height: 60),
                //                 ElevatedButton(
                //                     onPressed: () {},
                //                     child: Text(
                //                       "Bize Ulaşın",
                //                       style: GoogleFonts.poppins(
                //                           color: Theme.of(context)
                //                                   .textTheme
                //                                   .bodyLarge
                //                                   ?.color ??
                //                               Theme.of(context)
                //                                   .colorScheme
                //                                   .background),
                //                     ),
                //                     style: ElevatedButton.styleFrom(
                //                         backgroundColor:
                //                             Theme.of(context).cardColor))
                //               ],
                //             ),
                //             Text(
                //               "© 2022 Tobeto",
                //               style: Theme.of(context)
                //                   .textTheme
                //                   .bodySmall!
                //                   .copyWith(
                //                       color: Theme.of(context)
                //                           .colorScheme
                //                           .background,
                //                       fontWeight: FontWeight.bold),
                //             )
                //           ],
                //         )),
                //   ),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildOption(BuildContext context, String title) {
    bool isSelected = _selectedOption == title;

    return InkWell(
      onTap: () {
        setState(() {
          visibility.updateAll((key, value) => false);
          visibility[title] = true;
          _selectedOption = title;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        decoration: BoxDecoration(
          border: isSelected
              ? Border(bottom: BorderSide(color: Colors.black, width: 2.0))
              : null,
        ),
        child: Text(
          title,
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyLarge?.color ??
                Theme.of(context).colorScheme.background,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildEducationCards() {
    return Container(
      height: 300.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          EducationCard(
            title: 'Dr. Ecmel Ayral\'dan Hoşgeldin Mesajı',
            subtitle: '21 Eylül 2023 15:20',
            buttonText: 'Eğitime Git',
            imageUrl: 'assets/ecmal.jpg',
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          EducationCard(
            title: 'Eğitimlere Nasıl Katılırım?',
            subtitle: '8 Eylül 2023 17:06',
            buttonText: 'Eğitime Git',
            imageUrl: 'assets/ıstanbulkodlyr.jpg',
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          EducationCard(
            title: 'Herkes için Kodlama - 1A',
            subtitle: '18 Eylül 2023 03:00',
            buttonText: 'Eğitime Git',
            imageUrl: 'assets/tobetoarkapln.jpg',
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          EducationCard(
            title: 'İstanbul Kodluyor Proje Aşamaları',
            subtitle: '31 Ağustos 2023 13:01',
            buttonText: 'Eğitime Git',
            imageUrl: 'assets/ıstanbulkodlyr.jpg',
          ),
        ],
      ),
    );
  }
}
