// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wiredash/wiredash.dart';
import '../models/question.dart';
import '../test_data.dart';
import 'result_screen.dart';

class TestScreen extends StatefulWidget {
  final List<Question> testData;
  final String testName;
  final bool isTimerEnabled;
  final int testDuration;

  const TestScreen({
    required this.testData,
    required this.testName,
    required this.isTimerEnabled,
    required this.testDuration,
    super.key,
    required int questionCount,
  });

  @override
  // ignore: library_private_types_in_public_api
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen>
    with SingleTickerProviderStateMixin {
  final Map<Question, String> _selectedAnswers = {};
  late List<Question> _shuffledQuestions;
  Timer? _timer;
  int _remainingTime = 0;

  @override
  void initState() {
    super.initState();
    _shuffledQuestions =
        getRandomQuestions(widget.testData, widget.testData.length);
    if (widget.isTimerEnabled) {
      _remainingTime = widget.testDuration * 60;
      _startTimer();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() => _remainingTime--);
      } else {
        _timer?.cancel();
        _navigateToResultScreen();
      }
    });
  }

  void _navigateToResultScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          testName: widget.testName,
          questions: _shuffledQuestions,
          selectedAnswers: _selectedAnswers,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isTablet = MediaQuery.of(context).size.width > 600;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        title: Text(
          widget.testName,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: isTablet ? 25 : 20,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: widget.isTimerEnabled
            ? [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      "${_remainingTime ~/ 60}:${(_remainingTime % 60).toString().padLeft(2, '0')}",
                      style: TextStyle(
                        fontSize: isTablet ? 24 : 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ]
            : [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.builder(
          itemCount: _shuffledQuestions.length,
          itemBuilder: (context, index) {
            return _buildQuestionCard(index, _shuffledQuestions[index]);
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
        child: ElevatedButton.icon(
          onPressed: _navigateToResultScreen,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          icon: const Icon(Icons.check_circle, color: Colors.white),
          label: const Text(
            "Testi Bitir",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionCard(int index, Question question) {
    bool isTablet = MediaQuery.of(context).size.width > 600;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 5,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${index + 1}. ${question.question}',
                  style: TextStyle(
                    fontSize: isTablet ? 22 : 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 12),
                ...question.options.map((option) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _selectedAnswers[question] = option;
                          });
                        },
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          decoration: BoxDecoration(
                            color: _selectedAnswers[question] == option
                                ? Colors.blueAccent.withOpacity(0.1)
                                : Colors.transparent,
                            border: Border.all(
                              color: _selectedAnswers[question] == option
                                  ? Colors.blueAccent
                                  : Colors.grey.shade300,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ListTile(
                            dense: true,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            leading: Radio<String>(
                              value: option,
                              groupValue: _selectedAnswers[question],
                              onChanged: (value) {
                                setState(() {
                                  _selectedAnswers[question] = value!;
                                });
                              },
                              activeColor: Colors.blueAccent,
                            ),
                            title: Text(
                              option,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    )),
              ],
            ),
          ),
          // Hatalı soru bildir ikonu
          Positioned(
            right: 0,
            top: 0,
            child: IconButton(
              icon:
                  const Icon(Icons.report_problem_outlined, color: Colors.red),
              tooltip: "Hatalı Soru Bildir",
              onPressed: () {
                Wiredash.of(context).show();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ProgressBarPainter extends CustomPainter {
  final double progress;

  ProgressBarPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF007BFF)
      ..strokeWidth = size.height / 2
      ..strokeCap = StrokeCap.round;

    final double width = size.width * progress;

    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(width, size.height / 2),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
