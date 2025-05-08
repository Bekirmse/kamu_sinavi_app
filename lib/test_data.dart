import 'dart:math';

import 'models/question.dart';

// Rastgele soru seçme fonksiyonu
List<Question> getRandomQuestions(List<Question> questions, int count) {
  final random = Random();
  final randomQuestions = questions.toList()..shuffle(random);
  return randomQuestions.take(count).toList();
}
