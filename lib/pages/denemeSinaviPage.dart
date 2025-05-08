// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DenemeSinaviPage extends StatefulWidget {
  const DenemeSinaviPage({super.key});

  @override
  _DenemeSinaviPageState createState() => _DenemeSinaviPageState();
}

class _DenemeSinaviPageState extends State<DenemeSinaviPage> {
  Map<String, dynamic>? examData;
  Map<int, String> selectedAnswers = {};
  bool isLoading = true;
  String? selectedTopic;
  bool showResult = false;
  int score = 0;
  List<dynamic> sortedResults = [];
  bool hasUserTakenExam = false;
  DateTime? endTime;
  String formatDurationFromSeconds(int seconds) {
    final minutes = seconds ~/ 60;
    final sec = seconds % 60;
    return '$minutes dk $sec sn';
  }

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
    final Timestamp? end = data?['end_time'];
    if (end != null && end.toDate().isBefore(DateTime.now())) {
      return null;
    }

    endTime = end?.toDate();
    return data;
  }

  Future<void> loadExam() async {
    final data = await fetchActiveExam();
    await fetchResults();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final resultDoc = await FirebaseFirestore.instance
          .collection('practice_exams')
          .doc('active_exam')
          .collection('results')
          .doc(user.uid)
          .get();
      hasUserTakenExam = resultDoc.exists;
    }
    setState(() {
      examData = data;
      isLoading = false;
    });
  }

  List<dynamic> getSelectedQuestions() {
    if (selectedTopic == null) return [];
    return (examData!['questions'] as List)
        .where((q) => q['topic'] == selectedTopic)
        .toList();
  }

  Future<String> getUserFullName(String uid) async {
    final userDoc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    return userDoc.data()?['full_name'] ?? "İsimsiz";
  }

  Future<void> fetchResults() async {
    final results = await FirebaseFirestore.instance
        .collection('practice_exams')
        .doc('active_exam')
        .collection('results')
        .orderBy('score', descending: true)
        .get();

    setState(() {
      sortedResults = results.docs.map((e) => e.data()).toList();
    });
  }

  void finishTest() async {
    if (hasUserTakenExam) return;

    final questions = getSelectedQuestions();
    score = 0;
    for (var i = 0; i < questions.length; i++) {
      if (selectedAnswers[i] == questions[i]['answer']) {
        score++;
      }
    }

    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final fullName = await getUserFullName(user.uid);
      await FirebaseFirestore.instance
          .collection('practice_exams')
          .doc('active_exam')
          .collection('results')
          .doc(user.uid)
          .set({
        'score': score,
        'displayName': user.email ?? "User",
        'full_name': fullName,
        'timestamp': FieldValue.serverTimestamp(),
        'answers': selectedAnswers.map((k, v) => MapEntry(k.toString(), v)),
      });
    }

    await fetchResults();
    setState(() {
      showResult = true;
      hasUserTakenExam = true;
    });

    // 🔁 Aynı sayfaya yeniden yönlendirme (refresh için)
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const DenemeSinaviPage()),
    );
  }

  bool hasTakenTopic(String topic) => hasUserTakenExam;

  String formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    return 'Kalan süre $hours saat $minutes dakika';
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (examData == null || endTime == null) {
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.of(context).pushReplacementNamed('/'); // Ana ekrana yönlendir
      });

      return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.hourglass_empty,
                    size: 64, color: Colors.indigo.shade200),
                const SizedBox(height: 20),
                const Text(
                  "Şu anda aktif bir deneme sınavı bulunmuyor.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Ana ekrana yönlendiriliyorsunuz...",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final remaining = endTime!.difference(DateTime.now());
    final isExpired = remaining.isNegative;

    if (selectedTopic == null) {
      final questionsList = (examData!['questions'] as List<dynamic>);
      final topics = questionsList
          .map((q) => q['topic']?.toString())
          .toSet()
          .where((element) => element != null)
          .cast<String>()
          .toList();

      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.history),
              tooltip: "Sınav Geçmişi",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => SinavGecmisiPage(examData: examData!)),
                );
              },
            )
          ],
          title: const Text(
            'Deneme Sınavı',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: isDark ? const Color(0xFF1C1C1C) : Colors.white,
          foregroundColor: isDark ? Colors.white : Colors.black,
          elevation: 2,
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Konu Seçimi',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : const Color(0xFF000000),
                  ),
                ),
                if (!isExpired)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.indigo.shade100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.access_time,
                            size: 16, color: Colors.indigo),
                        const SizedBox(width: 6),
                        Text(
                          formatDuration(remaining),
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            if (isExpired)
              Container(
                margin: const EdgeInsets.symmetric(vertical: 32),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.red.shade200),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.warning_amber_rounded, color: Colors.red),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Bu deneme sınavının süresi doldu. Artık katılım yapılamaz.',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            else ...[
              ...topics.map((topic) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF2A2A2A) : Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        if (!isDark)
                          BoxShadow(
                            color: Colors.indigo.withOpacity(0.08),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                      ],
                      border: Border.all(
                        color: hasTakenTopic(topic)
                            ? Colors.grey.shade300
                            : Colors.indigo,
                        width: 1.2,
                      ),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 20),
                      title: Text(
                        topic,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      trailing: Icon(
                        hasTakenTopic(topic)
                            ? Icons.lock_outline
                            : Icons.play_circle_fill_rounded,
                        color:
                            hasTakenTopic(topic) ? Colors.grey : Colors.indigo,
                        size: 28,
                      ),
                      onTap: () {
                        if (hasTakenTopic(topic)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Bu testi daha önce çözdünüz."),
                              backgroundColor: Colors.red,
                            ),
                          );
                        } else {
                          setState(() {
                            selectedTopic = topic;
                            selectedAnswers.clear();
                            score = 0;
                            showResult = false;
                          });
                        }
                      },
                    ),
                  )),
              const SizedBox(height: 30),
              const Divider(height: 32),
              Text(
                'Genel Sıralama',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                ),
              ),
              const SizedBox(height: 14),
              ...sortedResults.asMap().entries.map((entry) {
                final index = entry.key;
                final user = entry.value;

                final bgColor = index == 0
                    ? Colors.amber.shade50
                    : index == 1
                        ? Colors.grey.shade100
                        : index == 2
                            ? Colors.brown.shade100
                            : Colors.white;

                final borderColor =
                    index < 3 ? Colors.indigo : Colors.grey.shade300;
                final placeIcon = index == 0
                    ? Icons.emoji_events
                    : index == 1
                        ? Icons.emoji_events_outlined
                        : index == 2
                            ? Icons.military_tech
                            : null;

                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: borderColor.withOpacity(0.3)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.02),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      )
                    ],
                  ),
                  child: Row(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          CircleAvatar(
                            radius: 22,
                            backgroundColor: isDark
                                ? Colors.indigo.withOpacity(0.3)
                                : Colors.indigo.shade100,
                            child: Text(
                              "${index + 1}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: isDark ? Colors.white : Colors.indigo,
                              ),
                            ),
                          ),
                          if (placeIcon != null)
                            Positioned(
                              bottom: -2,
                              right: -2,
                              child: Icon(
                                placeIcon,
                                size: 18,
                                color: Colors.amber,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user['full_name'] ?? 'Bilinmiyor',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: Colors.black87,
                              ),
                            ),
                            if (user['displayName'] != null)
                              Text(
                                user['displayName'],
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                ),
                              ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${user['score']} puan",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isDark
                                  ? Colors.indigo.shade200
                                  : Colors.indigo,
                              fontSize: 14,
                            ),
                          ),
                          if (user['duration'] != null)
                            Text(
                              formatDurationFromSeconds(user['duration']),
                              style: TextStyle(
                                fontSize: 11,
                                color: isDark ? Colors.grey[400] : Colors.grey,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                );
              }),
            ],
          ],
        ),
      );
    }

    final questions = getSelectedQuestions();

    return Scaffold(
      appBar: AppBar(
        title: Text('${examData!['title']} - $selectedTopic'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        elevation: 3,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: questions.length + 1,
        itemBuilder: (context, index) {
          if (index == questions.length) {
            // Testi Bitir Butonu
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: selectedAnswers.length == questions.length &&
                          !hasUserTakenExam
                      ? finishTest
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
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            );
          }

          final q = questions[index];
          final selected = selectedAnswers[index];

          return Container(
            margin: const EdgeInsets.only(bottom: 24),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E1E1E) : Colors.indigo.shade50,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color:
                      isDark ? Colors.black26 : Colors.indigo.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                )
              ],
            ),
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
                  q['question'],
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 12),
                ...List.generate(q['options'].length, (i) {
                  final option = q['options'][i];
                  final isSelected = selected == option;

                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isSelected
                            ? Colors.indigo
                            : (isDark ? Colors.grey : Colors.grey.shade300),
                        width: 1.5,
                      ),
                      color: isSelected
                          ? (isDark
                              ? Colors.indigo.withOpacity(0.3)
                              : Colors.indigo.shade100)
                          : (isDark ? const Color(0xFF2C2C2C) : Colors.white),
                    ),
                    child: ListTile(
                      title: Text(option),
                      onTap: () {
                        setState(() {
                          selectedAnswers[index] = option;
                        });
                      },
                    ),
                  );
                }),
              ],
            ),
          );
        },
      ),
    );
  }
}

class SinavGecmisiPage extends StatelessWidget {
  final Map<String, dynamic> examData;

  const SinavGecmisiPage({super.key, required this.examData});

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final ref = FirebaseFirestore.instance
        .collection('practice_exams')
        .doc('active_exam')
        .collection('results')
        .doc(uid);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Sınav Geçmişi"),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: ref.get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data!.data() as Map<String, dynamic>?;
          final answers = data?['answers'] as Map<String, dynamic>?;

          if (answers == null || answers.isEmpty) {
            return const Center(child: Text("Henüz geçmiş kayıt yok."));
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: answers.entries.map((entry) {
              final index = int.parse(entry.key);
              final selected = entry.value;
              final question = examData['questions'][index];
              final correct = question['answer'];

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  title: Text(
                    question['question'],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 6),
                      Text("Senin cevabın: $selected"),
                      Text("Doğru cevap: $correct"),
                    ],
                  ),
                  trailing: Icon(
                    selected == correct ? Icons.check_circle : Icons.cancel,
                    color: selected == correct ? Colors.green : Colors.red,
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
