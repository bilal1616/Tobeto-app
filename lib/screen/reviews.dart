import 'package:flutter/material.dart';
import 'package:tobeto_app/widget/reviews_widget/reviews_button.dart';
import 'package:tobeto_app/widget/reviews_widget/reviews_descriptioncard.dart';
import 'package:tobeto_app/widget/reviews_widget/reviews_notbutton.dart';

class Reviews extends StatefulWidget {
  const Reviews({Key? key}) : super(key: key);

  @override
  _ReviewsState createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  @override
  Widget build(BuildContext context) {
    // Bu liste kartların her biri için bilgileri içerir.
    final List<Map<String, dynamic>> categories = [
      {
        'title': 'Front End',
        'icon': Icons.list_outlined,
        'buttonText': 'Başla',
        'color': Theme.of(context).primaryColor,
      },
      {
        'title': 'Full Stack',
        'icon': Icons.list_outlined,
        'buttonText': 'Başla',
        'color': Theme.of(context).primaryColor,
      },
      {
        'title': 'Back End',
        'icon': Icons.list_outlined,
        'buttonText': 'Başla',
        'color': Theme.of(context).primaryColor,
      },
      {
        'title': 'Microsoft SQL Server',
        'icon': Icons.list_outlined,
        'buttonText': 'Başla',
        'color': Theme.of(context).primaryColor,
      },
      {
        'title': 'Masaüstü Programlama',
        'icon': Icons.list_outlined,
        'buttonText': 'Başla',
        'color': Theme.of(context).primaryColor,
      },
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.07),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(children: [
                    TextSpan(
                        text: 'Yetkin',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor)),
                    TextSpan(
                      text: 'liklerini ücretsiz ölç,\n',
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
                    TextSpan(
                      text: 'bilgi',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor),
                    ),
                    TextSpan(
                      text: 'lerini test et.',
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
                  ]),
                ),
              ),
              ReviewsButton(),
              ReviewsNotbutton(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              ...categories.map((category) => Card(
                        elevation: 4.0,
                        margin: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(
                              category['icon'],
                              color: category['color'],
                            ),
                          ),
                          title: Text(
                            category['title'],
                            style: TextStyle(color: Colors.white),
                          ),
                          trailing: ElevatedButton(
                            onPressed: () {},
                            child: Text(
                              category['buttonText'],
                              style: TextStyle(
                                color: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.color ??
                                    Theme.of(context).colorScheme.background,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.background,
                              foregroundColor:
                                  Theme.of(context).colorScheme.onBackground,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                            ),
                          ),
                          tileColor: category['color'],
                        ),
                      ))
                  .toList(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.09),
              _buildDecoratedImage(context), // Dekore edilmiş resmi ekleyin.
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 0.1),
                child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(children: [
                      TextSpan(
                          text: 'Aboneliğe özel\n',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor)),
                      TextSpan(
                        text: 'değerlendirme araçları için',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .color),
                      ),
                    ])),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              const Reviewsdescriptioncard(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDecoratedImage(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(1.0),
      width: MediaQuery.of(context).size.width *
          0.2, // Resmin genişliğini ayarlayın.
      height: MediaQuery.of(context).size.height *
          0.2, // Resmin yüksekliğini ayarlayın.
      child: Opacity(
        opacity: 0.8, // Resmin opaklığını ayarlayın.
        child: Image.asset(
          "assets/images.png",
          fit: BoxFit.fitHeight, // Resmi kaplayacak şekilde boyutlandırın.
        ),
      ),
    );
  }
}
