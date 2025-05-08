import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/question.dart';

// Test sonuçlarını yönetmek için kullanılan servis sınıfı
class TestResultsService {
  static final List<TestResult> _testResults = [];

  // Test sonucunu kaydeden fonksiyon
  static Future<void> saveTestResult({
    required String testName,
    required List<Question> questions,
    required Map<Question, String> selectedAnswers,
  }) async {
    int correctAnswersCount = 0;
    for (var question in questions) {
      if (selectedAnswers.containsKey(question) &&
          selectedAnswers[question] == question.answer) {
        correctAnswersCount++;
      }
    }
    double score = (correctAnswersCount / questions.length) * 100;

    Map<String, String> stringSelectedAnswers = selectedAnswers
        .map((key, value) => MapEntry(jsonEncode(key.toJson()), value));

    TestResult result = TestResult(
      testName: testName,
      score: score,
      date: DateTime.now(),
      questions: questions,
      selectedAnswers: stringSelectedAnswers,
    );

    _testResults.add(result);
    await _saveToPreferences();
  }

  // SharedPreferences'a kayıt
  static Future<void> _saveToPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final resultsJson = _testResults.map((result) => result.toJson()).toList();
    final jsonString = jsonEncode(resultsJson);
    await prefs.setString('testResults', jsonString);
  }

  // SharedPreferences'tan verileri yükleme
  static Future<void> loadTestResults() async {
    final prefs = await SharedPreferences.getInstance();
    final resultsJson = prefs.getString('testResults');
    if (resultsJson != null) {
      try {
        final List<dynamic> decoded = jsonDecode(resultsJson);
        _testResults.clear();
        _testResults.addAll(decoded.map((json) {
          return TestResult.fromJson(json);
        }).toList());
      } catch (e) {
        // hata yönetimi
      }
    }
  }

  // Tüm test sonuçlarını alma
  static List<TestResult> getAllTestResults() {
    return _testResults;
  }

  // Tüm testleri silme
  static Future<void> clearTestResults() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('testResults');
    _testResults.clear();
  }

  // 🔥 Belirli bir testi silme
  static Future<void> deleteTestResultAt(int index) async {
    if (index >= 0 && index < _testResults.length) {
      _testResults.removeAt(index);
      final prefs = await SharedPreferences.getInstance();
      final updatedList = _testResults.map((e) => e.toJson()).toList();
      await prefs.setString('testResults', jsonEncode(updatedList));
    }
  }
}

// Test sonucu model sınıfı
class TestResult {
  final String testName;
  final double score;
  final DateTime date;
  final List<Question> questions;
  final Map<String, String> selectedAnswers;

  TestResult({
    required this.testName,
    required this.score,
    required this.date,
    required this.questions,
    required this.selectedAnswers,
  });

  Map<String, dynamic> toJson() {
    return {
      'testName': testName,
      'score': score,
      'date': date.toIso8601String(),
      'questions': questions.map((q) => q.toJson()).toList(),
      'selectedAnswers': selectedAnswers,
    };
  }

  factory TestResult.fromJson(Map<String, dynamic> json) {
    final questions =
        (json['questions'] as List).map((q) => Question.fromJson(q)).toList();
    final selectedAnswers =
        Map<String, String>.from(json['selectedAnswers'] as Map);

    return TestResult(
      testName: json['testName'],
      score: json['score'],
      date: DateTime.parse(json['date']),
      questions: questions,
      selectedAnswers: selectedAnswers,
    );
  }
}
