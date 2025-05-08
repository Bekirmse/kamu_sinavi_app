// Gereksiz lint uyarılarını kapatma
// ignore_for_file: avoid_types_as_parameter_names, use_build_context_synchronously, avoid_unnecessary_containers, unrelated_type_equality_checks, deprecated_member_use

// Gerekli paketleri projeye dahil ediyoruz
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show HapticFeedback;
import 'package:kamu_sinavi_app/models/question.dart';
import 'package:kamu_sinavi_app/pages/notlarim_screen.dart';
import 'package:kamu_sinavi_app/pages/customTestpAGE.dart';
import 'package:kamu_sinavi_app/pages/denemeSinaviPage.dart';
import 'package:kamu_sinavi_app/pages/messageToAdminPage.dart';
import 'package:kamu_sinavi_app/pages/performance_report_screen.dart';
import 'package:kamu_sinavi_app/pages/settingsPage.dart';
import 'package:kamu_sinavi_app/pages/test_screen.dart';
import 'package:kamu_sinavi_app/notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Ana ekran: Kamu Sınavları Ekranı
class KamuSinavlariScreen extends StatefulWidget {
  final bool isDarkMode;
  final Function(bool) onToggleDarkMode;

  const KamuSinavlariScreen({
    super.key,
    required this.isDarkMode,
    required this.onToggleDarkMode,
  });

  @override
  State<KamuSinavlariScreen> createState() => _KamuSinavlariScreenState();
}

class _KamuSinavlariScreenState extends State<KamuSinavlariScreen> {
  // Test ayarları için değişkenler
  bool _isTimerEnabled = false;
  int _testDuration = 5;
  int _selectedQuestionCount = 10;

  @override
  void initState() {
    super.initState();
  }

  // Ana yapı: Scaffold
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? const Color(0xFF121212)
          : Colors.white,
      drawer: _buildDrawer(), // Sol menü
      appBar: AppBar(
        title: Text(
          "K A M U C E P",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
        ),
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF121212)
            : Colors.white,
        elevation: 2,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : Colors.black,
        ),
      ),
      body: FutureBuilder<QuerySnapshot>(
        // Firestore'dan tüm test konularını getir
        future: FirebaseFirestore.instance.collection('questions').get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          List<String> allTopics = [];

          if (snapshot.hasData) {
            allTopics = snapshot.data!.docs.map((doc) => doc.id).toList();
          }

          if (allTopics.isEmpty) {
            return const Center(child: Text("Test verisi bulunamadı."));
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                "Testler",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              // Konuları ızgara olarak göster
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.75,
                children: allTopics.map((topicName) {
                  return _buildTestButton(topicName);
                }).toList(),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDrawer() {
    final user = FirebaseAuth.instance.currentUser;

    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF3F51B5), Color(0xFF5C6BC0)],
              ),
            ),
            child: Center(
              child: Image.asset(
                'assets/icons/kamucepicon.png',
                height: 100,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildDrawerTile(
                  icon: Icons.shuffle,
                  text: "Kendi Testini Oluştur",
                  onTap: () {
                    HapticFeedback.mediumImpact(); // Telefon titrer
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const CustomTestScreen()),
                    );
                  },
                ),
                _buildDrawerTile(
                  icon: Icons.support,
                  text: "Destek Al veya Sorun Bildir",
                  onTap: () {
                    HapticFeedback.mediumImpact(); // Telefon titrer
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const MessageToAdminPage()),
                    );
                  },
                ),
                _buildDrawerTile(
                  icon: Icons.quiz,
                  text: "Deneme Sınavı",
                  onTap: () async {
                    HapticFeedback.mediumImpact(); // Telefon titrer
                    if (user == null) {
                      showDialog(
                        context: context,
                        builder: (context) => _buildLoginDialog(context),
                      );
                    } else {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const DenemeSinaviPage()),
                      );
                    }
                  },
                ),
                _buildDrawerTile(
                  icon: Icons.notifications_active,
                  text: "Bildirimler",
                  onTap: () {
                    HapticFeedback.mediumImpact(); // Telefon titrer
                    Navigator.pop(context);
                    showNotificationsPanel(context);
                  },
                ),
                _buildDrawerTile(
                  icon: Icons.note_alt_outlined,
                  text: "Notlarım",
                  onTap: () {
                    HapticFeedback.mediumImpact(); // Telefon titrer
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const NotlarimScreen()));
                  },
                ),
                _buildDrawerTile(
                  icon: Icons.history,
                  text: "Geçmiş",
                  onTap: () {
                    HapticFeedback.mediumImpact(); // Telefon titrer
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const PerformanceReportScreen()),
                    );
                  },
                ),
                _buildDrawerTile(
                  icon: Icons.settings,
                  text: "Ayarlar",
                  onTap: () {
                    HapticFeedback.mediumImpact(); // Telefon titrer
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SettingsPage(
                          isDarkMode: widget.isDarkMode,
                          onToggleDarkMode: widget.onToggleDarkMode,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Konu başlığına ait test butonu tasarımı
  Widget _buildTestButton(String topicName) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            HapticFeedback.mediumImpact(); // Telefon titrer
            _showTestOptionsPanel(topicName);
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1C1C1E) : Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: isDark ? Colors.black45 : Colors.grey.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
              border: Border.all(
                color: isDark ? Colors.grey.shade600 : Colors.blue,
                width: 1.2,
              ),
            ),
            child: Center(
              child: Text(
                topicName.replaceAll('_', ' ').toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDrawerTile({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.indigo),
      title: Text(text, style: const TextStyle(fontWeight: FontWeight.w500)),
      onTap: onTap,
      visualDensity: const VisualDensity(horizontal: -2, vertical: -2),
      horizontalTitleGap: 8,
    );
  }

  Widget _buildLoginDialog(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.lock_outline, size: 48, color: Colors.indigo),
            const SizedBox(height: 16),
            const Text("Giriş Gerekli",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            const Text(
              "Deneme sınavını çözebilmek için lütfen giriş yapın veya kayıt olun.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, "/register");
                    },
                    icon: const Icon(Icons.person_add, color: Colors.green),
                    label: const Text("Kayıt Ol",
                        style: TextStyle(color: Colors.green)),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.green),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, "/login");
                    },
                    icon: const Icon(Icons.login, color: Colors.white),
                    label: const Text("Giriş Yap",
                        style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Test başlamadan önce seçenek paneli
  void _showTestOptionsPanel(String topicName) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Test Ayarları",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Zamanlayıcı",
                      style: TextStyle(fontSize: 16),
                    ),
                    Switch.adaptive(
                      value: _isTimerEnabled,
                      onChanged: (val) {
                        setState(() => _isTimerEnabled = val);
                        HapticFeedback.mediumImpact(); // Telefon titrer
                      },
                    ),
                  ],
                ),
                if (_isTimerEnabled) ...[
                  const SizedBox(height: 12),
                  Text(
                    "Süre: $_testDuration dakika",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  Slider(
                    value: _testDuration.toDouble(),
                    min: 1,
                    max: 60,
                    divisions: 59,
                    label: "$_testDuration dk",
                    activeColor: Colors.indigo,
                    onChanged: (value) {
                      HapticFeedback.selectionClick();
                      setState(() => _testDuration = value.toInt());
                    },
                  ),
                ],
                const SizedBox(height: 20),
                const Text(
                  "Soru Sayısı",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [10, 20, 30].map((count) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: ChoiceChip(
                        label: Text("$count"),
                        selected: _selectedQuestionCount == count,
                        selectedColor: Colors.indigo,
                        backgroundColor: Colors.grey.shade200,
                        labelStyle: TextStyle(
                          color: _selectedQuestionCount == count
                              ? Colors.white
                              : Colors.black87,
                        ),
                        onSelected: (val) {
                          HapticFeedback.mediumImpact(); // Telefon titrer
                          setState(() => _selectedQuestionCount = count);
                        },
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      HapticFeedback.mediumImpact(); // Telefon titrer
                      Navigator.pop(context);
                      _startTest(topicName);
                    },
                    icon: const Icon(Icons.play_arrow),
                    label: const Text(
                      "Testi Başlat",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      iconColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          );
        });
      },
    );
  }

  // Test başlatma işlemi
  Future<void> _startTest(String topicName) async {
    List<Question> allQuestions = [];

    // İnternet bağlantısı kontrolü
    final connectivityResult = await Connectivity().checkConnectivity();
    final isConnected = connectivityResult != ConnectivityResult.none;

    // Eğer bağlantı varsa Firestore'dan sorular alınır
    if (isConnected) {
      try {
        final snapshot = await FirebaseFirestore.instance
            .collection('questions')
            .doc(topicName)
            .collection('questionList')
            .get();

        allQuestions =
            snapshot.docs.map((doc) => Question.fromJson(doc.data())).toList();
      } catch (e) {
        debugPrint("Firestore bağlantı hatası: $e");
      }
    }

    // Eğer bağlantı yoksa veya Firestore boşsa SharedPreferences'tan yüklenir
    if (allQuestions.isEmpty) {
      final prefs = await SharedPreferences.getInstance();
      final offlineData = prefs.getStringList('offline_$topicName');
      debugPrint(
          "📂 Offline kontrol: offline_$topicName bulundu mu? => ${offlineData != null}");
      if (offlineData != null) {
        debugPrint("🧾 Offline veri bulundu. Toplam: ${offlineData.length}");

        for (var i = 0; i < offlineData.length; i++) {
          final raw = offlineData[i];
          debugPrint("🔎 [$i] Raw offline string: $raw");

          try {
            final decoded = json.decode(raw);
            debugPrint("📄 [$i] Decoded JSON: $decoded");
          } catch (e) {
            debugPrint("❌ JSON çözümleme hatası: $e");
          }
        }

        allQuestions =
            offlineData.map((e) => Question.fromJson(json.decode(e))).toList();
      }
    }

    // Hala soru yoksa kullanıcı bilgilendirilir
    if (allQuestions.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Bu konuda çevrimdışı soru bulunamadı.")),
      );
      return;
    }

    // Soruları karıştır ve seçilen sayıda test başlat
    allQuestions.shuffle();
    final selectedQuestions =
        allQuestions.take(_selectedQuestionCount).toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TestScreen(
          testData: selectedQuestions,
          testName: topicName,
          isTimerEnabled: _isTimerEnabled,
          testDuration: _isTimerEnabled ? _testDuration : 0,
          questionCount: _selectedQuestionCount,
        ),
      ),
    );
  }
}
