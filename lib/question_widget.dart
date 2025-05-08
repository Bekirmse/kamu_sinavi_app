import 'package:flutter/material.dart';
import 'package:kamu_sinavi_app/models/question.dart';

class QuestionWidget extends StatelessWidget {
  final Question question;

  const QuestionWidget({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (question.imagePath != null)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(question.imagePath!),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              question.question,
              style: const TextStyle(fontSize: 18),
            ),
          ),
          for (var option in question.options)
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
              child: ElevatedButton(
                onPressed: () {
                  // Seçeneğin seçilmesi durumunda yapılacaklar
                },
                child: Text(option),
              ),
            ),
        ],
      ),
    );
  }
}
