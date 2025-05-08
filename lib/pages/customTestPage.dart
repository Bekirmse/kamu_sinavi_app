// ignore_for_file: use_build_context_synchronously, avoid_types_as_parameter_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kamu_sinavi_app/models/question.dart';
import 'package:kamu_sinavi_app/pages/test_screen.dart';

class CustomTestScreen extends StatefulWidget {
  const CustomTestScreen({super.key});

  @override
  State<CustomTestScreen> createState() => _CustomTestScreenState();
}

class _CustomTestScreenState extends State<CustomTestScreen> {
  List<String> selectedTopics = [];
  int selectedQuestionCount = 10;
  int selectedDuration = 10;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xFF121212) : const Color(0xFFF7F9FC),
      appBar: AppBar(
        title: Text(
          "Kendi Testini Oluştur",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        backgroundColor: isDark ? const Color(0xFF1F1F1F) : Colors.white,
        elevation: 1,
        centerTitle: true,
        iconTheme: IconThemeData(color: isDark ? Colors.white : Colors.black),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection('questions').get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final topics = snapshot.data!.docs.map((doc) => doc.id).toList();

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildCard(
                title: "📚 Konular",
                child: Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: topics.map((topic) {
                    final isSelected = selectedTopics.contains(topic);
                    return ChoiceChip(
                      label: Text(
                        topic.replaceAll("_", " ").toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isSelected
                              ? Colors.white
                              : isDark
                                  ? Colors.white
                                  : Colors.black87,
                        ),
                      ),
                      selected: isSelected,
                      selectedColor: Colors.indigo,
                      backgroundColor:
                          isDark ? Colors.grey[800] : Colors.grey[200],
                      onSelected: (val) {
                        setState(() {
                          if (val) {
                            selectedTopics.add(topic);
                          } else {
                            selectedTopics.remove(topic);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
                isDark: isDark,
              ),
              const SizedBox(height: 12),
              _buildCard(
                title: "❓ Soru Sayısı",
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [10, 20, 30].map((count) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: ChoiceChip(
                        label: Text(
                          "$count",
                          style: TextStyle(
                            color: selectedQuestionCount == count
                                ? Colors.white
                                : isDark
                                    ? Colors.white70
                                    : Colors.black,
                          ),
                        ),
                        selected: selectedQuestionCount == count,
                        selectedColor: Colors.indigo,
                        backgroundColor:
                            isDark ? Colors.grey[800] : Colors.grey[200],
                        onSelected: (val) {
                          setState(() => selectedQuestionCount = count);
                        },
                      ),
                    );
                  }).toList(),
                ),
                isDark: isDark,
              ),
              const SizedBox(height: 12),
              _buildCard(
                title: "⏱ Süre (dakika)",
                child: Column(
                  children: [
                    Text(
                      "$selectedDuration dakika",
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                    Slider(
                      value: selectedDuration.toDouble(),
                      min: 1,
                      max: 60,
                      divisions: 59,
                      label: "$selectedDuration dk",
                      activeColor: Colors.indigo,
                      onChanged: (value) {
                        HapticFeedback.selectionClick();
                        setState(() => selectedDuration = value.toInt());
                      },
                    ),
                  ],
                ),
                isDark: isDark,
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  icon: isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Icon(Icons.play_arrow, color: Colors.white),
                  label: Text(
                    isLoading ? "Test oluşturuluyor..." : "Testi Başlat",
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  onPressed: isLoading ? null : _startCustomTest,
                ),
              ),
              const SizedBox(height: 10),
              if (selectedTopics.isNotEmpty)
                Center(
                  child: Text(
                    "Seçilen Konular: ${selectedTopics.map((e) => e.replaceAll("_", " ").toUpperCase()).join(", ")}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? Colors.grey[400] : Colors.grey,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCard(
      {required String title, required Widget child, required bool isDark}) {
    return Card(
      color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }

  Future<void> _startCustomTest() async {
    if (selectedTopics.length < 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Lütfen en az 2 konu seçin.")),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    List<Question> allQuestions = [];

    for (String topic in selectedTopics) {
      final snapshot = await FirebaseFirestore.instance
          .collection('questions')
          .doc(topic)
          .collection('questionList')
          .get();

      final questions =
          snapshot.docs.map((doc) => Question.fromJson(doc.data())).toList();
      allQuestions.addAll(questions);
    }

    if (allQuestions.isEmpty) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Seçilen konularda soru bulunamadı.")),
      );
      return;
    }

    allQuestions.shuffle();
    final selected = allQuestions.take(selectedQuestionCount).toList();

    setState(() {
      isLoading = false;
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TestScreen(
          testData: selected,
          testName: "Özel Test",
          isTimerEnabled: true,
          testDuration: selectedDuration,
          questionCount: selectedQuestionCount,
        ),
      ),
    );
  }
}
