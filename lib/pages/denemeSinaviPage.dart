import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DenemeSinaviPage extends StatefulWidget {
  const DenemeSinaviPage({super.key});

  @override
  _DenemeSinaviPageState createState() => _DenemeSinaviPageState();
}

class _DenemeSinaviPageState extends State<DenemeSinaviPage> {
  Map<String, dynamic>? examData;
  int currentQuestionIndex = 0;
  int score = 0;
  bool isLoading = true;
  String? selectedTopic;

  @override
  void initState() {
    super.initState();
    loadExam();
  }

  Future<Map<String, dynamic>?> fetchActiveExam() async {
    final doc = await FirebaseFirestore.instance
        .collection('practice_exams')
        .doc('active_exam')
        .get();

    if (!doc.exists) return null;

    final data = doc.data();
    final Timestamp? endTime = data?['end_time'];
    if (endTime != null && endTime.toDate().isBefore(DateTime.now())) {
      return null;
    }

    return data;
  }

  Future<void> loadExam() async {
    final data = await fetchActiveExam();
    setState(() {
      examData = data;
      isLoading = false;
    });
  }

  void answerQuestion(String selectedOption) {
    final correctAnswer =
        getSelectedQuestions()[currentQuestionIndex]['answer'];
    if (selectedOption == correctAnswer) {
      score++;
    }

    if (currentQuestionIndex < getSelectedQuestions().length - 1) {
      setState(() => currentQuestionIndex++);
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('Sınav Tamamlandı'),
          content: Text('Skorunuz: $score / ${getSelectedQuestions().length}'),
          actions: [
            TextButton(
              onPressed: () =>
                  Navigator.of(context).popUntil((route) => route.isFirst),
              child: const Text('Ana Sayfaya Dön'),
            ),
          ],
        ),
      );
    }
  }

  List<dynamic> getSelectedQuestions() {
    if (selectedTopic == null) return [];
    return (examData!['questions'] as List)
        .where((q) => q['topic'] == selectedTopic)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (examData == null) {
      return const Scaffold(
        body: Center(child: Text('Aktif bir deneme sınavı bulunamadı.')),
      );
    }

    if (selectedTopic == null) {
      final questionsList = (examData!['questions'] as List<dynamic>);
      final topics = questionsList
          .map((q) => q['topic']?.toString())
          .toSet()
          .where((element) => element != null)
          .cast<String>()
          .toList();

      final endTime = (examData!['end_time'] as Timestamp?)?.toDate();
      final now = DateTime.now();
      final durationLeft = endTime?.difference(now);

      if (endTime != null && durationLeft!.isNegative) {
        return const Scaffold(
          body: Center(child: Text('Bu sınav süresi dolmuştur.')),
        );
      }

      return Scaffold(
        appBar: AppBar(
          title: const Text('Konu Seç',
              style: TextStyle(fontWeight: FontWeight.bold)),
          centerTitle: true,
        ),
        body: Column(
          children: [
            if (durationLeft != null)
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Kalan Süre: ${durationLeft.inHours} saat ${durationLeft.inMinutes.remainder(60)} dakika',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            Expanded(
              child: ListView.builder(
                itemCount: topics.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    elevation: 2,
                    child: ListTile(
                      title: Text(topics[index],
                          style: const TextStyle(fontWeight: FontWeight.w600)),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                      onTap: () {
                        setState(() {
                          selectedTopic = topics[index];
                          currentQuestionIndex = 0;
                          score = 0;
                        });
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    }

    final questions = getSelectedQuestions();
    final question = questions[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('${examData!['title']} - $selectedTopic',
            style: const TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Soru ${currentQuestionIndex + 1} / ${questions.length}',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 12),
            Text(
              question['question'],
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            ...List<Widget>.generate(question['options'].length, (index) {
              final option = question['options'][index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black87,
                    elevation: 1,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: const BorderSide(color: Colors.indigo),
                    ),
                  ),
                  onPressed: () => answerQuestion(option),
                  child: Text(
                    option,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              );
            }),
            const Spacer(),
            const Center(
              child: Text(
                'Soruyu dikkatlice okuyup doğru seçeneği işaretleyiniz.',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
