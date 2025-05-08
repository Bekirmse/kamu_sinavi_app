// ignore_for_file: unused_local_variable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kamu_sinavi_app/pages/Kamu_sinavlari.dart';

import 'package:wiredash/wiredash.dart';
import '../models/question.dart';
import '../services/test_results_service.dart';
import 'package:url_launcher/url_launcher.dart';

class ResultScreen extends StatefulWidget {
  final String testName;
  final List<Question> questions;
  final Map<Question, String> selectedAnswers;

  const ResultScreen({
    required this.testName,
    required this.questions,
    required this.selectedAnswers,
    super.key,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  int viewCount = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isTablet = MediaQuery.of(context).size.width > 600;
    int totalQuestions = widget.questions.length;
    int correctAnswers = 0;
    List<Map<String, String>> questionResults = [];

    for (var question in widget.questions) {
      String selectedAnswer = widget.selectedAnswers[question] ?? '';
      bool isCorrect = selectedAnswer == question.answer;

      if (isCorrect) {
        correctAnswers++;
      }

      questionResults.add({
        'question': question.question,
        'selected': selectedAnswer,
        'correct': question.answer,
        'isCorrect': isCorrect.toString(),
      });
    }

    double successRate =
        totalQuestions > 0 ? (correctAnswers / totalQuestions) * 100 : 0;

    TestResultsService.saveTestResult(
      testName: widget.testName,
      questions: widget.questions,
      selectedAnswers: widget.selectedAnswers,
    );

    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? const Color(0xFF121212)
          : Colors.white,

      appBar: AppBar(
          backgroundColor: Theme.of(context).brightness == Brightness.dark
              ? const Color(0xFF121212)
              : Colors.white,
          elevation: 2.0,
          title: Text(
            'Sonuçlar',
            style: GoogleFonts.roboto(
              fontSize: isTablet ? 28 : 25,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          leading: Container()),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Card(
              color: const Color(0xFFEEF5FF),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Icon(
                      successRate >= 50 ? Icons.emoji_events : Icons.warning,
                      color: successRate >= 50 ? Colors.green : Colors.red,
                      size: 40,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Doğru Cevaplar: $correctAnswers / $totalQuestions',
                            style: GoogleFonts.roboto(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            'Başarı Oranı: ${successRate.toStringAsFixed(2)}%',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color:
                                  successRate >= 50 ? Colors.green : Colors.red,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: _buildAnswersList(questionResults),
            ),

            const SizedBox(
                height: 10), // Ana Menü butonu ile Liste arasında boşluk

            // Ana Menü Butonu
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => KamuSinavlariScreen(
                              isDarkMode:
                                  false, // Replace with the actual value
                              onToggleDarkMode: (bool value) {
                                // Replace with the actual toggle logic
                              },
                            )),
                    (route) => false,
                  );
                },
                icon: const Icon(Icons.home, color: Colors.white),
                label: Text(
                  'Ana Menüye Dön',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isTablet ? 22 : 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 4,
                ),
              ),
            ),

            const SizedBox(
                height: 105), // Ana Menü Butonu ile FAB arasında boşluk
          ],
        ),
      ),

      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerFloat, // FAB'i ortada tut
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Wiredash.of(context).show();
        },
        backgroundColor: Colors.deepOrange,
        icon: const Icon(Icons.feedback, color: Colors.white),
        label: const Text(
          "Geri Bildirim",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

Widget _buildAnswersList(List<Map<String, String>> questionResults) {
  return Expanded(
    child: ListView.builder(
      itemCount: questionResults.length,
      itemBuilder: (context, index) {
        final result = questionResults[index];
        bool isCorrect = result['isCorrect'] == 'true';
        bool isTablet = MediaQuery.of(context).size.width > 600;
        return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              elevation: 3,
              color: const Color(0xFFF8F8F8),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      result['question']!,
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w600,
                        fontSize: isTablet ? 18 : 16,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          result['isCorrect'] == 'true'
                              ? Icons.check
                              : Icons.close,
                          color: result['isCorrect'] == 'true'
                              ? Colors.green
                              : Colors.red,
                          size: 20,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            'Seçiminiz: ${result['selected']!.isEmpty ? 'CEVAPLANMADI!' : result['selected']}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: result['isCorrect'] == 'true'
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (result['isCorrect'] != 'true')
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          'Doğru Cevap: ${result['correct']}',
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ));
      },
    ),
  );
}

class FullScreenSponsorAd extends StatefulWidget {
  final String sponsorImage;
  final String sponsorUrl;

  const FullScreenSponsorAd({
    required this.sponsorImage,
    required this.sponsorUrl,
    super.key,
  });

  @override
  // ignore: library_private_types_in_public_api
  _FullScreenSponsorAdState createState() => _FullScreenSponsorAdState();
}

class _FullScreenSponsorAdState extends State<FullScreenSponsorAd> {
  int _secondsLeft = 5;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _secondsLeft = 5;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsLeft > 1) {
          _secondsLeft--;
        } else {
          _secondsLeft--;
          timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isTablet = MediaQuery.of(context).size.width > 600;
    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              _launchURL(widget.sponsorUrl);
            },
            child: Image.asset(
              widget.sponsorImage,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    try {
      // ignore: deprecated_member_use
      if (await canLaunch(url)) {
        // ignore: deprecated_member_use
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      debugPrint("Error launching URL: $e");
    }
  }
}
