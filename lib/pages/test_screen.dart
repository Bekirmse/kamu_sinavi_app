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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isTablet = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : Colors.white,
      appBar: AppBar(
        backgroundColor: isDark ? const Color(0xFF1C1C1C) : Colors.white,
        elevation: 2,
        title: Text(
          widget.testName,
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: isTablet ? 25 : 20,
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: isDark ? Colors.white : Colors.black),
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
            return _buildQuestionCard(
                context, index, _shuffledQuestions[index], isDark);
          },
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _selectedAnswers.length == _shuffledQuestions.length
                    ? _navigateToResultScreen
                    : null,
                icon: const Icon(Icons.check_circle_outline),
                label: const Text(
                  "Testi Bitir",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: Colors.grey.shade300,
                  disabledForegroundColor: Colors.grey.shade600,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildQuestionCard(
      BuildContext context, int index, Question question, bool isDark) {
    final selected = _selectedAnswers[question];

    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.indigo.shade50,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black26 : Colors.indigo.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Soru ${index + 1}',
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  question.question,
                  style: TextStyle(
                    fontSize: 16,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: 12),
                ...question.options.map((option) {
                  final isSelected = selected == option;
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color:
                            isSelected ? Colors.indigo : Colors.grey.shade300,
                        width: 1.5,
                      ),
                      color: isSelected
                          ? (isDark
                              ? Colors.indigo.withOpacity(0.3)
                              : Colors.indigo.shade100)
                          : (isDark ? const Color(0xFF2C2C2C) : Colors.white),
                    ),
                    child: ListTile(
                      dense: true,
                      title: Text(
                        option,
                        style: TextStyle(
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          _selectedAnswers[question] = option;
                        });
                      },
                    ),
                  );
                }),
              ],
            ),
          ),
          Positioned(
            right: -13,
            top: -13,
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
