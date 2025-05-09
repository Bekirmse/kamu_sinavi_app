// ignore_for_file: unnecessary_to_list_in_spreads, deprecated_member_use, use_build_context_synchronously, duplicate_ignore

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wiredash/wiredash.dart';
import '../services/test_results_service.dart';

class PerformanceReportScreen extends StatefulWidget {
  const PerformanceReportScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PerformanceReportScreenState createState() =>
      _PerformanceReportScreenState();
}

class _PerformanceReportScreenState extends State<PerformanceReportScreen> {
  List<TestResult> testResults = [];

  @override
  void initState() {
    super.initState();
    _loadTestResults();
  }

  Future<void> _loadTestResults() async {
    try {
      await TestResultsService.loadTestResults();
      setState(() {
        testResults = TestResultsService.getAllTestResults();
      });

      // Eğer kart varsa, 3 saniye sonra bilgi kutucuğu göster
      if (testResults.isNotEmpty) {
        Future.delayed(const Duration(seconds: 0), () {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Başlıklara tıklayarak detayları görebilir veya basılı tutarak silebilirsiniz.',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : const Color.fromARGB(221, 255, 255, 255),
                  ),
                ),
                backgroundColor: Colors.blue.shade600,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                duration: const Duration(seconds: 5),
                margin:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              ),
            );
          }
        });
      }
    } catch (e) {
      // Handle error if needed
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.shortestSide >= 600;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? const Color(0xFF121212)
          : Colors.white,
      appBar: AppBar(
        title: Text(
          "Çözülmüş Testler",
          style: TextStyle(
            fontSize: isTablet ? 25 : 20,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
        ),
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF1F1F1F)
            : Colors.white,
        elevation: 2,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever, color: Colors.red),
            tooltip: 'Tüm Testleri Sil',
            onPressed: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Testleri Sil"),
                  content: const Text(
                      "Tüm geçmiş testleri silmek istediğinizden emin misiniz?"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text("İptal"),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text("Sil",
                          style: TextStyle(color: Colors.red)),
                    ),
                  ],
                ),
              );

              if (confirm == true) {
                await TestResultsService
                    .clearTestResults(); // ✅ BU SATIR DÜZELTİLDİ
                setState(() {
                  testResults.clear();
                });

                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Tüm test sonuçları silindi.'),
                    duration: Duration(seconds: 3),
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: testResults.isEmpty
          ? Center(
              child: Text(
                'Henüz tamamlanan test bulunmamaktadır.',
                style: TextStyle(
                  fontSize: isTablet ? 24 : 18,
                  fontWeight: FontWeight.w500,
                  color: isDark ? Colors.white70 : Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: testResults.length,
              itemBuilder: (context, index) {
                TestResult result = testResults[index];
                int totalQuestions = result.questions.length;
                int correctAnswers = 0;
                List<Map<String, dynamic>> questionResults = [];

                for (var question in result.questions) {
                  String questionKey = jsonEncode(question.toJson());
                  String selectedAnswer =
                      result.selectedAnswers[questionKey] ?? '';
                  bool isCorrect = selectedAnswer == question.answer;

                  if (isCorrect) {
                    correctAnswers++;
                  }

                  questionResults.add({
                    'question': question.question,
                    'selected': selectedAnswer,
                    'correct': question.answer,
                    'isCorrect': isCorrect,
                  });
                }

                double successRate = totalQuestions > 0
                    ? (correctAnswers / totalQuestions) * 100
                    : 0;

                return Card(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? const Color(0xFF2A2A2A)
                      : Colors.white,
                  margin: EdgeInsets.symmetric(
                      vertical: isTablet ? 20.0 : 12.0,
                      horizontal: isTablet ? 24.0 : 12.0),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    title: Text(
                      result.testName,
                      style: TextStyle(
                        fontSize: isTablet ? 22 : 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    subtitle: Text(
                      'Puan: ${result.score.toStringAsFixed(2)} - Tarih: ${result.date.day}/${result.date.month}/${result.date.year}',
                      style: TextStyle(
                        fontSize: isTablet ? 20 : 16,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.grey[400]
                            : Colors.grey[700],
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          successRate >= 50 ? Icons.check_circle : Icons.cancel,
                          color: successRate >= 50 ? Colors.green : Colors.red,
                          size: 35,
                        ),
                        const SizedBox(width: 12),
                        InkWell(
                          onTap: () {
                            Wiredash.of(context).show();
                          },
                          child: const Icon(
                            Icons.feedback,
                            size: 35,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            backgroundColor:
                                Theme.of(context).brightness == Brightness.dark
                                    ? const Color(0xFF1E1E1E)
                                    : Colors.white,
                            title: const Row(
                              children: [
                                Icon(Icons.assessment, color: Colors.indigo),
                                SizedBox(width: 8),
                                Text('Test Sonuçları',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                            content: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.6,
                              width: double.maxFinite,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Genel İstatistikler
                                  Card(
                                    color: Colors.indigo[50],
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    elevation: 0,
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Doğru Cevaplar: $correctAnswers/$totalQuestions',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.dark
                                                  ? Colors.black87
                                                  : Colors.black87,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            'Başarı Oranı: ${successRate.toStringAsFixed(2)}%',
                                            style: TextStyle(
                                              color: successRate >= 50
                                                  ? (Theme.of(context)
                                                              .brightness ==
                                                          Brightness.dark
                                                      ? const Color.fromARGB(
                                                          255, 53, 168, 89)
                                                      : Colors.green[700])
                                                  : (Theme.of(context)
                                                              .brightness ==
                                                          Brightness.dark
                                                      ? Colors
                                                          .redAccent.shade100
                                                      : Colors.red[700]),
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  const Text('Soru Detayları:',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 6),
                                  Expanded(
                                    child: ListView.separated(
                                      itemCount: questionResults.length,
                                      separatorBuilder: (_, __) =>
                                          const SizedBox(height: 8),
                                      itemBuilder: (context, index) {
                                        final result = questionResults[index];
                                        final isCorrect = result['isCorrect'];
                                        final selected = result['selected'];
                                        final correct = result['correct'];

                                        return Card(
                                          elevation: 2,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          color: isCorrect
                                              ? Colors.green.withOpacity(0.1)
                                              : selected.isEmpty
                                                  ? Colors.red.withOpacity(0.1)
                                                  : Colors.orange
                                                      .withOpacity(0.1),
                                          child: ListTile(
                                            contentPadding:
                                                const EdgeInsets.all(12),
                                            title: Text(
                                              result['question'],
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                                color: Theme.of(context)
                                                            .brightness ==
                                                        Brightness.dark
                                                    ? Colors.white
                                                    : Colors.black87,
                                              ),
                                            ),
                                            subtitle: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(height: 6),
                                                Text(
                                                  'Seçiminiz: ${selected.isEmpty ? 'CEVAPLANMADI!' : selected}',
                                                  style: TextStyle(
                                                    color: selected.isEmpty
                                                        ? Colors.red
                                                        : isCorrect
                                                            ? Colors.green[800]
                                                            : Colors.red[800],
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                if (!isCorrect)
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 4),
                                                    child: Text(
                                                      'Doğru Cevap: $correct',
                                                      style: const TextStyle(
                                                          color: Colors.green,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            actions: [
                              TextButton.icon(
                                onPressed: () => Navigator.of(context).pop(),
                                icon: const Icon(Icons.close,
                                    color: Colors.redAccent),
                                label: const Text('Kapat',
                                    style: TextStyle(color: Colors.redAccent)),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    onLongPress: () async {
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Testi Sil"),
                          content: const Text(
                              "Bu testi silmek istediğinize emin misiniz?"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text("İptal"),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: const Text("Sil",
                                  style: TextStyle(color: Colors.red)),
                            ),
                          ],
                        ),
                      );

                      if (confirm == true) {
                        await TestResultsService.deleteTestResultAt(
                            index); // 🔥 SADECE SEÇİLEN TESTİ SİLER
                        setState(() {
                          testResults = TestResultsService
                              .getAllTestResults(); // ekranı güncelle
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Test başarıyla silindi")),
                        );
                      }
                    },
                  ),
                );
              },
            ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 40);
    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2, size.height - 30.0);
    var secondControlPoint =
        Offset(size.width - (size.width / 4), size.height - 65);
    var secondEndPoint = Offset(size.width, size.height - 40);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height - 40);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

Future<void> clearAllTestResults() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('test_results');
}
