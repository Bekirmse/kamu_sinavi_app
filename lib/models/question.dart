class Question {
  final String question;
  final List<String> options;
  final String answer;
  final String? imagePath;

  Question({
    required this.question,
    required this.options,
    required this.answer,
    this.imagePath,
  });

  /// Firestore'a kaydedilecek hale getirir
  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'options': options,
      'answer': answer,
      'imagePath': imagePath,
    };
  }

  /// Firestore'dan gelen JSON'dan Question nesnesi oluşturur
  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      question: json['question'] ?? '',
      options: List<String>.from(json['options'] ?? []),
      answer: json['answer'] ?? '',
      imagePath: json['imagePath'],
    );
  }

  @override
  String toString() {
    return 'Question(question: $question, options: $options, answer: $answer, imagePath: $imagePath)';
  }
}
