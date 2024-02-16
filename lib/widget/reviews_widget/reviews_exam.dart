import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewsExam extends StatefulWidget {
  final String examTitle;

  const ReviewsExam({Key? key, required this.examTitle}) : super(key: key);

  @override
  _ReviewsExamState createState() => _ReviewsExamState();
}

class _ReviewsExamState extends State<ReviewsExam> {
  Map<int, int?> selectedOptions = {};
  late List<Map<String, dynamic>> questions =
      []; // Firestore'dan gelen soruları tutacak liste

  @override
  void initState() {
    super.initState();
    fetchQuestions(); // Firestore'dan soruları getir
  }

  void fetchQuestions() async {
    try {
      // Firestore'dan "reviews-exam" koleksiyonundaki belgeleri getir
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('reviews-exam').get();

      // Her belgeyi dönerek soruları listeye ekle
      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic> question = {
          'question': doc['question'],
          'options': List<String>.from(doc['options']),
          'correctAnswer': doc['correctAnswer'],
        };
        questions.add(question);
      });

      // setState ile yeniden çizilmesini sağla
      setState(() {});
    } catch (e) {
      print('Error fetching questions: $e');
    }
  }

  void showExamResult() async {
    try {
      String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
      var userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      var examResult = userDoc.data()?['reviews-exam-result'];

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Sınav Sonucu'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 20),
                Text('Sınav: ${examResult['examTitle']}',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                SizedBox(height: 20),
                Text('Doğru Cevap Sayısı: ${examResult['Doğru']}',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                SizedBox(height: 20),
                Text('Yanlış Cevap Sayısı: ${examResult['Yanlış']}',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Tamam'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      print('Error showing exam result: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.examTitle),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (questions.isNotEmpty)
                Column(
                  children: List.generate(questions.length, (index) {
                    Map<String, dynamic> question = questions[index];
                    return buildQuestion(
                      index + 1,
                      question['question'],
                      List<String>.from(question['options']),
                      question['correctAnswer'],
                    );
                  }),
                )
              else
                Center(
                  child:
                      CircularProgressIndicator(), // Sorular yüklenene kadar dön
                ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: finishExam,
                child: Text('Sınavı Bitir'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: showExamResult,
                child: Text('Sınav Sonuçları'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Sınavdan Çık'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildQuestion(
    int questionNumber,
    String question,
    List<String> options,
    int correctAnswer,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$questionNumber) $question',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        RadioButtonGroup(
          options: options,
          onChanged: (value) {
            setState(() {
              selectedOptions[questionNumber] = value;
            });
          },
          selectedOption: selectedOptions[questionNumber],
        ),
        Divider(),
      ],
    );
  }

  void finishExam() {
    int correctCount = 0;
    int totalCount = questions.length;

    selectedOptions.forEach((questionNumber, selectedOption) {
      if (selectedOption == questions[questionNumber - 1]['correctAnswer']) {
        correctCount++;
      }
    });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
              '${widget.examTitle}\nSınav Sonucu:'), // Sınav başlığı eklendi
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 20),
              Text('Doğru Cevap Sayısı: $correctCount',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
              SizedBox(height: 20),
              Text('Yanlış Cevap Sayısı: ${totalCount - correctCount}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                saveResult(correctCount, totalCount - correctCount);
              },
              child: Text('Tamam'),
            ),
          ],
        );
      },
    );
  }

  void saveResult(int correctCount, int incorrectCount) async {
    try {
      String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'reviews-exam-result': {
          'examTitle': widget.examTitle, // İlgili sınav başlığı eklendi
          'Doğru': correctCount,
          'Yanlış': incorrectCount,
        }
      });
    } catch (e) {
      print('Error saving result: $e');
    }
  }
}

class RadioButtonGroup extends StatelessWidget {
  final List<String> options;
  final Function(int?) onChanged;
  final int? selectedOption;

  const RadioButtonGroup({
    Key? key,
    required this.options,
    required this.onChanged,
    required this.selectedOption,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: options.map((option) {
        int index = options.indexOf(option);
        return RadioListTile<int>(
          title: Text(
            option,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyMedium?.color ??
                  Theme.of(context).colorScheme.background,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          value: index,
          groupValue: selectedOption,
          onChanged: onChanged,
        );
      }).toList(),
    );
  }
}
