// ignore_for_file: use_build_context_synchronously, curly_braces_in_flow_control_structures
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kamu_sinavi_app/pages/admin_chat_screen.dart';
import 'package:kamu_sinavi_app/pages/chat_utils.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

final Map<String, IconData> iconMap = {
  'Bildirimler': Icons.notifications,
  'Bilgi': Icons.info,
  'Uyarı': Icons.warning,
  'Hata': Icons.error,
  'Güncelleme': Icons.system_update,
};

class _AdminDashboardState extends State<AdminDashboard> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _subtitleController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  String _selectedColor = 'Mavi';
  String _selectedIcon = 'Bildirimler';
  String _searchQuery = '';
  int _selectedIndex = 0;

  final List<String> colorOptions = [
    'Mavi',
    'Kırmızı',
    'Yeşil',
    'Turuncu',
    'Mor'
  ];
  final List<String> iconOptions = [
    'Bildirimler',
    'Bilgi',
    'Uyarı',
    'Hata',
    'Güncelleme'
  ];

  @override
  void initState() {
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.toLowerCase();
      });
    });
    super.initState();
  }

  Future<void> addNotification(
      String title, String subtitle, String color, String icon) async {
    await FirebaseFirestore.instance.collection('notifications').add({
      'title': title,
      'subtitle': subtitle,
      'color': color,
      'icon': icon,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Widget buildDrawer() {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.indigo),
            child: Center(
              child: Text(
                'Admin Paneli',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Kullanıcılar"),
            selected: _selectedIndex == 0,
            onTap: () {
              setState(() => _selectedIndex = 0);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.question_answer),
            title: const Text("Sorular"),
            selected: _selectedIndex == 2,
            onTap: () {
              setState(() => _selectedIndex = 2);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text("Bildirim Oluştur"),
            selected: _selectedIndex == 1,
            onTap: () {
              setState(() => _selectedIndex = 1);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.timer, color: Colors.indigo),
            title: const Text("Deneme Sınavı Başlat"),
            selected: _selectedIndex == 3,
            onTap: () {
              setState(() => _selectedIndex = 3);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.chat),
            title: const Text("Mesajlar"),
            selected: _selectedIndex == 4,
            onTap: () {
              setState(() => _selectedIndex = 4);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Future<void> sendPushNotificationToUser({
    required String userId,
    required String title,
    required String body,
  }) async {
    await FirebaseFirestore.instance.collection('notifications_queue').add({
      'to': userId,
      'title': title,
      'body': body,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Widget buildQuestionManager() {
    final questionController = TextEditingController();
    final optionControllers = List.generate(4, (_) => TextEditingController());
    final newTopicController = TextEditingController();
    final searchController = TextEditingController();
    String? selectedAnswer;

    String? selectedTopic;
    String searchText = '';

    return StatefulBuilder(builder: (context, setState) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Yeni Soru Ekle",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 24),

                    // ➤ Konu Bilgileri
                    const Text("📘 Konu Bilgileri",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 10),
                    FutureBuilder<QuerySnapshot>(
                      future: FirebaseFirestore.instance
                          .collection('questions')
                          .get(),
                      builder: (context, snapshot) {
                        final topics =
                            snapshot.data?.docs.map((e) => e.id).toList() ?? [];
                        return Column(
                          children: [
                            DropdownButtonFormField<String>(
                              value: selectedTopic,
                              decoration: _inputDecoration("Konu Seçiniz"),
                              items: topics.map((topic) {
                                return DropdownMenuItem(
                                    value: topic, child: Text(topic));
                              }).toList(),
                              onChanged: (val) =>
                                  setState(() => selectedTopic = val),
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              controller: newTopicController,
                              decoration: _inputDecoration(
                                  "Yeni Konu Başlığı (opsiyonel)"),
                            ),
                          ],
                        );
                      },
                    ),

                    const SizedBox(height: 24),
                    const Text("✏️ Soru Metni",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 10),
                    TextField(
                      controller: questionController,
                      maxLines: 3,
                      decoration: _inputDecoration("Soru Metni"),
                    ),

                    const SizedBox(height: 24),
                    const Text("🅰️ Şıklar",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 10),
                    for (int i = 0; i < 4; i++)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: TextField(
                          controller: optionControllers[i],
                          onChanged: (_) =>
                              setState(() {}), // dropdown'ı tetiklemek için
                          decoration: _inputDecoration(
                              "Şık ${String.fromCharCode(65 + i)}"),
                        ),
                      ),

                    const SizedBox(height: 24),
                    const Text("✅ Doğru Cevap",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      value: optionControllers
                              .map((c) => c.text)
                              .contains(selectedAnswer)
                          ? selectedAnswer
                          : null,
                      decoration: _inputDecoration("Doğru Cevap"),
                      items: optionControllers
                          .map((controller) => controller.text.trim())
                          .where((text) => text.isNotEmpty)
                          .map((text) =>
                              DropdownMenuItem(value: text, child: Text(text)))
                          .toList(),
                      onChanged: (val) => setState(() => selectedAnswer = val),
                    ),

                    const SizedBox(height: 24),
                    Center(
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          final topic =
                              selectedTopic ?? newTopicController.text.trim();
                          if (topic.isEmpty ||
                              questionController.text.isEmpty ||
                              selectedAnswer == null) {
                            return;
                          }

                          final newQuestion = {
                            'question': questionController.text,
                            'options':
                                optionControllers.map((e) => e.text).toList(),
                            'answer': selectedAnswer,
                            'imagePath': null,
                          };

                          final topicDoc = FirebaseFirestore.instance
                              .collection('questions')
                              .doc(topic);
                          final topicSnapshot = await topicDoc.get();
                          if (!topicSnapshot.exists) {
                            await topicDoc.set({'title': topic});
                          }

                          await topicDoc
                              .collection('questionList')
                              .add(newQuestion);

                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Soru başarıyla eklendi.")));

                          questionController.clear();
                          for (final c in optionControllers) {
                            c.clear();
                          }
                        },
                        icon: const Icon(Icons.add),
                        label: const Text("Soru Ekle"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            if (selectedTopic != null) ...[
              const Text("Seçilen Konudaki Sorular",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              TextField(
                controller: searchController,
                decoration: _inputDecoration("Soru içinde ara..."),
                onChanged: (value) =>
                    setState(() => searchText = value.toLowerCase()),
              ),
              const SizedBox(height: 10),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('questions')
                    .doc(selectedTopic)
                    .collection('questionList')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final docs = snapshot.data!.docs.where((doc) {
                    final data = doc.data() as Map<String, dynamic>;
                    final questionText =
                        data['question']?.toString().toLowerCase() ?? '';
                    return questionText.contains(searchText);
                  }).toList();

                  if (docs.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.all(12),
                      child: Text("Bu konuda eşleşen soru yok."),
                    );
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      final doc = docs[index];
                      final data = doc.data() as Map<String, dynamic>;

                      return Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: ListTile(
                          title: Text(data['question'] ?? ""),
                          subtitle: Text("Cevap: ${data['answer']}"),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit,
                                    color: Colors.orange),
                                onPressed: () {
                                  _showEditQuestionDialog(context, doc, data,
                                      selectedTopic!, setState);
                                },
                              ),
                              IconButton(
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                                tooltip: 'Soruyu Sil',
                                onPressed: () async {
                                  final ref = doc.reference;
                                  final parentCollection = ref.parent;

                                  try {
                                    final allQuestionsSnapshot =
                                        await parentCollection.get();
                                    final totalQuestions =
                                        allQuestionsSnapshot.docs.length;

                                    if (totalQuestions == 1) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              "Son kalan soruyu silemezsiniz. Önce konuyu silmelisiniz."),
                                        ),
                                      );
                                      return;
                                    }

                                    final confirm = await showDialog<bool>(
                                      context: context,
                                      builder: (ctx) => AlertDialog(
                                        title: const Text("Soruyu Sil"),
                                        content: const Text(
                                            "Bu soruyu silmek istediğinize emin misiniz?"),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(ctx, false),
                                            child: const Text("İptal"),
                                          ),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.red),
                                            onPressed: () =>
                                                Navigator.pop(ctx, true),
                                            child: const Text("Sil"),
                                          ),
                                        ],
                                      ),
                                    );

                                    if (confirm != true) return;

                                    await ref.delete();

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text("Soru başarıyla silindi.")),
                                    );
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text("Hata oluştu: $e")),
                                    );
                                  }
                                },
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () async {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text("Konu Başlığını Sil"),
                      content: Text(
                          "$selectedTopic konusunu silmek istiyor musunuz?"),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(ctx, false),
                          child: const Text("İptal"),
                        ),
                        ElevatedButton(
                          onPressed: () => Navigator.pop(ctx, true),
                          child: const Text("Sil"),
                        ),
                      ],
                    ),
                  );

                  if (confirm == true) {
                    await FirebaseFirestore.instance
                        .collection('questions')
                        .doc(selectedTopic)
                        .delete();
                    setState(() => selectedTopic = null);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Konu başlığı silindi.")),
                    );
                  }
                },
                icon: const Icon(Icons.delete_forever),
                label: const Text("Konu Başlığını Sil"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ]
          ],
        ),
      );
    });
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.grey[100],
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    );
  }

  void _showEditQuestionDialog(
    BuildContext context,
    DocumentSnapshot doc,
    Map<String, dynamic> data,
    String topicId,
    void Function(void Function()) setState,
  ) {
    final questionController = TextEditingController(text: data['question']);
    final options = List<String>.from(data['options'] ?? []);
    final optionControllers = List.generate(
      4,
      (i) => TextEditingController(text: i < options.length ? options[i] : ''),
    );
    String selectedAnswer = data['answer'] ?? 'A';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Soruyu Düzenle"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: questionController,
                maxLines: 3,
                decoration: const InputDecoration(labelText: "Soru Metni"),
              ),
              const SizedBox(height: 8),
              for (int i = 0; i < 4; i++)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: TextField(
                    controller: optionControllers[i],
                    decoration: InputDecoration(
                      labelText: "Şık ${String.fromCharCode(65 + i)}",
                    ),
                  ),
                ),
              DropdownButtonFormField<String>(
                value: selectedAnswer,
                decoration: const InputDecoration(labelText: "Doğru Cevap"),
                items: ['A', 'B', 'C', 'D']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (val) {
                  selectedAnswer = val!;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("İptal"),
          ),
          ElevatedButton(
            onPressed: () async {
              final updatedData = {
                'question': questionController.text.trim(),
                'options': optionControllers.map((c) => c.text.trim()).toList(),
                'answer': selectedAnswer,
              };

              await FirebaseFirestore.instance
                  .collection('questions')
                  .doc(topicId)
                  .collection('questionList')
                  .doc(doc.id)
                  .update(updatedData);

              setState(() {}); // UI'yı yenile
              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Soru güncellendi")),
              );
            },
            child: const Text("Kaydet"),
          ),
        ],
      ),
    );
  }

  Widget buildNotificationForm() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Yeni Bildirim Oluştur',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24),

                  // ➤ Başlık ve Açıklama
                  const Text("📋 Temel Bilgiler",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: 'Başlık',
                      prefixIcon: const Icon(Icons.title),
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _subtitleController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: 'Açıklama',
                      prefixIcon: const Icon(Icons.description),
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),

                  const SizedBox(height: 24),
                  const Text("🎨 Görsel Ayarlar",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 12),

                  // ➤ Renk Seçimi
                  DropdownButtonFormField<String>(
                    value: _selectedColor,
                    decoration: InputDecoration(
                      labelText: 'Renk',
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    items: colorOptions
                        .map((color) =>
                            DropdownMenuItem(value: color, child: Text(color)))
                        .toList(),
                    onChanged: (value) =>
                        setState(() => _selectedColor = value!),
                  ),
                  const SizedBox(height: 16),

                  // ➤ İkon Seçimi
                  DropdownButtonFormField<String>(
                    value: _selectedIcon,
                    decoration: InputDecoration(
                      labelText: 'İkon',
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    items: iconOptions
                        .map((icon) =>
                            DropdownMenuItem(value: icon, child: Text(icon)))
                        .toList(),
                    onChanged: (value) =>
                        setState(() => _selectedIcon = value!),
                  ),

                  const SizedBox(height: 30),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        if (_titleController.text.isNotEmpty &&
                            _subtitleController.text.isNotEmpty) {
                          await addNotification(
                            _titleController.text,
                            _subtitleController.text,
                            _selectedColor,
                            _selectedIcon,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('Bildirim başarıyla oluşturuldu')),
                          );
                          _titleController.clear();
                          _subtitleController.clear();
                        }
                      },
                      icon: const Icon(Icons.send),
                      label: const Text('Bildirim Oluştur'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 32),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text('Mevcut Bildirimler',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('notifications')
                .orderBy('timestamp', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final docs = snapshot.data!.docs;

              if (docs.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  child: Center(
                    child: Text(
                      "Hiç bildirim yok.",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                );
              }

              return ListView.builder(
                itemCount: docs.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final notif = docs[index];
                  final data = notif.data() as Map<String, dynamic>;
                  final title = data['title'] ?? '';
                  final subtitle = data['subtitle'] ?? '';
                  final color = data['color'] ?? 'Mavi';

                  return Card(
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            iconMap[data['icon']] ?? Icons.notifications,
                            color: Colors.blueAccent,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(title,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                                const SizedBox(height: 6),
                                Text(
                                  subtitle,
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.black87),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit,
                                    color: Colors.orange),
                                tooltip: 'Düzenle',
                                onPressed: () {
                                  _showEditDialog(
                                      notif.id, title, subtitle, color);
                                },
                              ),
                              IconButton(
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                                tooltip: 'Sil',
                                onPressed: () async {
                                  await FirebaseFirestore.instance
                                      .collection('notifications')
                                      .doc(notif.id)
                                      .delete();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Bildirim silindi')),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }

  void _showEditDialog(String docId, String currentTitle,
      String currentSubtitle, String currentColor) {
    final editTitleController = TextEditingController(text: currentTitle);
    final editSubtitleController = TextEditingController(text: currentSubtitle);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Bildirimi Düzenle"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: editTitleController,
              decoration: const InputDecoration(labelText: 'Başlık'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: editSubtitleController,
              maxLines: 3,
              decoration: const InputDecoration(labelText: 'Açıklama'),
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("İptal")),
          ElevatedButton(
            onPressed: () async {
              await FirebaseFirestore.instance
                  .collection('notifications')
                  .doc(docId)
                  .update({
                'title': editTitleController.text,
                'subtitle': editSubtitleController.text,
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Bildirim güncellendi")),
              );
            },
            child: const Text("Kaydet"),
          ),
        ],
      ),
    );
  }

  Widget buildUsersList() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '👥 Kayıtlı Kullanıcılar',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: "Ad, soyad veya e-posta ara...",
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('users').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final users = snapshot.data!.docs.where((user) {
                  final data = user.data() as Map<String, dynamic>? ?? {};
                  final name =
                      data['full_name']?.toString().toLowerCase() ?? '';
                  final email = data['email']?.toString().toLowerCase() ?? '';
                  final role = data['role']?.toString() ?? 'user';

                  // 🔴 Admin kullanıcıları gösterme
                  if (role == 'admin') return false;

                  return name.contains(_searchQuery) ||
                      email.contains(_searchQuery);
                }).toList();

                if (users.isEmpty) {
                  return const Center(child: Text("Hiç kullanıcı bulunamadı."));
                }

                return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    final data = user.data() as Map<String, dynamic>? ?? {};
                    final role = data['role']?.toString() ?? 'user';
                    final email = data['email']?.toString() ?? 'E-posta yok';
                    final name = role == 'user'
                        ? data['full_name']?.toString() ?? 'Ad Soyad yok'
                        : 'Admin Kullanıcı';
                    final isAdmin = role == 'admin';
                    final userId = user.id;

                    return StreamBuilder<DatabaseEvent>(
                      stream: FirebaseDatabase.instanceFor(
                        app: Firebase.app(),
                        databaseURL:
                            'https://kamucep-f819e-default-rtdb.firebaseio.com/',
                      ).ref('presence/$userId').onValue,
                      builder: (context, snapshot) {
                        final val = snapshot.data?.snapshot.value;
                        final isOnline = val == true ||
                            (val is Map && val['online'] == true);

                        return Card(
                          margin: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 4),
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          color: isAdmin
                              ? Colors.purple[50]
                              : (isOnline ? Colors.green[50] : Colors.white),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: isAdmin
                                  ? Colors.purple
                                  : (isOnline ? Colors.green : Colors.grey),
                              child:
                                  const Icon(Icons.person, color: Colors.white),
                            ),
                            title: Text(
                              name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("E-mail: $email"),
                                  Text("Rol: $role"),
                                  Row(
                                    children: [
                                      Icon(Icons.circle,
                                          size: 10,
                                          color: isOnline
                                              ? Colors.green
                                              : Colors.grey),
                                      const SizedBox(width: 6),
                                      Text(
                                        isOnline ? 'Aktif' : 'Çevrimdışı',
                                        style: TextStyle(
                                          color: isOnline
                                              ? Colors.green[800]
                                              : Colors.grey[600],
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            trailing: Wrap(
                              spacing: 8,
                              children: [
                                FutureBuilder<DocumentSnapshot>(
                                  future: FirebaseFirestore.instance
                                      .collection('messages')
                                      .doc(getChatId(
                                          userId,
                                          FirebaseAuth
                                              .instance.currentUser!.uid))
                                      .get(),
                                  builder: (context, chatMetaSnapshot) {
                                    final lastSeen =
                                        chatMetaSnapshot.data?.data() != null
                                            ? (chatMetaSnapshot.data!.data()
                                                    as Map<String, dynamic>)[
                                                'lastSeenByAdmin'] as Timestamp?
                                            : null;

                                    return StreamBuilder<QuerySnapshot>(
                                      stream: FirebaseFirestore.instance
                                          .collection('messages')
                                          .doc(getChatId(
                                              userId,
                                              FirebaseAuth
                                                  .instance.currentUser!.uid))
                                          .collection('chat')
                                          .orderBy('timestamp',
                                              descending: true)
                                          .limit(1)
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        bool hasNewMessage = false;

                                        if (snapshot.hasData &&
                                            snapshot.data!.docs.isNotEmpty) {
                                          final latestMessage =
                                              snapshot.data!.docs.first;
                                          final latestTimestamp =
                                              latestMessage['timestamp']
                                                  as Timestamp;

                                          if (lastSeen == null ||
                                              latestTimestamp
                                                  .toDate()
                                                  .isAfter(lastSeen.toDate())) {
                                            hasNewMessage = true;
                                          }
                                        }

                                        return SizedBox(
                                          width: 48,
                                          height: 48,
                                          child: Stack(
                                            alignment: Alignment.topRight,
                                            children: [
                                              IconButton(
                                                icon: const Icon(Icons.message,
                                                    color: Colors.indigo),
                                                tooltip: "Mesajlara Git",
                                                onPressed: () async {
                                                  final latest =
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                              'messages')
                                                          .doc(getChatId(
                                                              userId,
                                                              FirebaseAuth
                                                                  .instance
                                                                  .currentUser!
                                                                  .uid))
                                                          .collection('chat')
                                                          .orderBy('timestamp',
                                                              descending: true)
                                                          .limit(1)
                                                          .get();

                                                  if (latest.docs.isNotEmpty) {
                                                    final lastTimestamp = latest
                                                        .docs
                                                        .first['timestamp'];
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection('messages')
                                                        .doc(getChatId(
                                                            userId,
                                                            FirebaseAuth
                                                                .instance
                                                                .currentUser!
                                                                .uid))
                                                        .set({
                                                      'lastSeenByAdmin':
                                                          lastTimestamp
                                                    }, SetOptions(merge: true));
                                                  }

                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          AdminChatScreen(
                                                        userId: userId,
                                                        userName: name,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                              if (hasNewMessage)
                                                Positioned(
                                                  top: 6,
                                                  right: 6,
                                                  child: Container(
                                                    width: 12,
                                                    height: 12,
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Colors.red,
                                                      shape: BoxShape.circle,
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.refresh,
                                      color: Colors.orange),
                                  tooltip: "Şifre Sıfırla",
                                  onPressed: () async {
                                    await FirebaseAuth.instance
                                        .sendPasswordResetEmail(email: email);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              "Şifre sıfırlama bağlantısı gönderildi: $email")),
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.redAccent),
                                  tooltip: "Kullanıcıyı Sil",
                                  onPressed: () async {
                                    final confirm = await showDialog<bool>(
                                      context: context,
                                      builder: (ctx) => AlertDialog(
                                        title: const Text("Kullanıcıyı sil"),
                                        content: Text(
                                            "$email adresli kullanıcı silinsin mi?"),
                                        actions: [
                                          TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(ctx, false),
                                              child: const Text("İptal")),
                                          ElevatedButton(
                                              onPressed: () =>
                                                  Navigator.pop(ctx, true),
                                              child: const Text("Sil")),
                                        ],
                                      ),
                                    );
                                    if (confirm == true) {
                                      await FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(userId)
                                          .delete();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                "Kullanıcı silindi: $email")),
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPracticeExamForm() {
    final titleController = TextEditingController();
    final durationController = TextEditingController();
    final List<QuestionForm> questions = [QuestionForm()];

    return Padding(
      padding: const EdgeInsets.all(16),
      child: StatefulBuilder(
        builder: (context, setState) => ListView(
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Deneme Sınavı Başlat",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                          labelText: "Sınav Başlığı",
                          border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: durationController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          labelText: "Süre (dakika)",
                          border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 24),
                    const Text("Sorular", style: TextStyle(fontSize: 16)),
                    const SizedBox(height: 8),
                    ...questions.asMap().entries.map((entry) {
                      final i = entry.key;
                      final question = entry.value;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text("Soru ${i + 1}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              const Spacer(),
                              IconButton(
                                icon: const Icon(Icons.delete_forever,
                                    color: Colors.red),
                                onPressed: () {
                                  setState(() {
                                    questions.removeAt(i);
                                  });
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: question.topicController,
                            decoration: const InputDecoration(
                                labelText: "Konu Başlığı",
                                border: OutlineInputBorder()),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: question.questionController,
                            decoration: const InputDecoration(
                                labelText: "Soru Metni",
                                border: OutlineInputBorder()),
                          ),
                          const SizedBox(height: 8),
                          ...List.generate(4, (j) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: TextField(
                                controller: question.optionControllers[j],
                                decoration: InputDecoration(
                                  labelText:
                                      "Şık ${String.fromCharCode(65 + j)}",
                                  border: const OutlineInputBorder(),
                                ),
                                onChanged: (_) {
                                  setState(() {});
                                },
                              ),
                            );
                          }),
                          DropdownButtonFormField<String>(
                            value: question.correctAnswer.isNotEmpty
                                ? question.correctAnswer
                                : null,
                            decoration:
                                const InputDecoration(labelText: "Doğru Cevap"),
                            items: question.optionControllers
                                .map((c) => c.text.trim())
                                .where((text) => text.isNotEmpty)
                                .map((text) => DropdownMenuItem(
                                    value: text, child: Text(text)))
                                .toList(),
                            onChanged: (val) => setState(
                                () => question.correctAnswer = val ?? ""),
                          ),
                          const Divider(),
                        ],
                      );
                    }),
                    const SizedBox(height: 10),
                    Center(
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.add),
                        label: const Text("Soru Ekle"),
                        onPressed: () {
                          setState(() => questions.add(QuestionForm()));
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          final title = titleController.text.trim();
                          final duration =
                              int.tryParse(durationController.text.trim()) ?? 0;

                          if (title.isEmpty || duration <= 0) return;

                          final List<Map<String, dynamic>> preparedQuestions =
                              [];

                          for (final q in questions) {
                            final question = q.questionController.text.trim();
                            final topic = q.topicController.text.trim();
                            final options = q.optionControllers
                                .map((e) => e.text.trim())
                                .toList();
                            final answer = q.correctAnswer;

                            if (question.isEmpty ||
                                topic.isEmpty ||
                                options.any((o) => o.isEmpty) ||
                                answer.isEmpty) continue;

                            preparedQuestions.add({
                              'question': question,
                              'options': options,
                              'answer': answer,
                              'topic': topic,
                            });
                          }

                          if (preparedQuestions.isEmpty) return;

                          await FirebaseFirestore.instance
                              .collection('practice_exams')
                              .doc('active_exam')
                              .set({
                            'title': title,
                            'duration': duration,
                            'questions': preparedQuestions,
                            'created_at': FieldValue.serverTimestamp(),
                            'end_time': Timestamp.fromDate(
                                DateTime.now().add(const Duration(hours: 24))),
                          });

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Deneme sınavı başlatıldı.")),
                          );

                          setState(() {
                            titleController.clear();
                            durationController.clear();
                            questions.clear();
                            questions.add(QuestionForm());
                          });
                        },
                        icon: const Icon(Icons.play_arrow),
                        label: const Text("Sınavı Başlat"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 32),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF3F51B5), Color(0xFF5C6BC0)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        iconTheme: const IconThemeData(
            color: Colors.white), // Drawer menüsü ikonu beyaz
        title: Row(
          children: [
            const Icon(Icons.dashboard_customize_rounded, color: Colors.white),
            const SizedBox(width: 10),
            Text(
              _selectedIndex == 0
                  ? 'Kullanıcılar'
                  : (_selectedIndex == 1 ? 'Bildirim Oluştur' : 'Sorular'),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      drawer: buildDrawer(),
      body: _selectedIndex == 0
          ? buildUsersList()
          : (_selectedIndex == 1
              ? buildNotificationForm()
              : (_selectedIndex == 2
                  ? buildQuestionManager()
                  : (_selectedIndex == 3
                      ? buildPracticeExamForm()
                      : buildMessagesScreen()))), // Mesajlar
    );
  }
}

Widget buildMessagesScreen() {
  final adminUid = FirebaseAuth.instance.currentUser?.uid;

  return Padding(
    padding: const EdgeInsets.all(16),
    child: StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('messages').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return const Center(child: CircularProgressIndicator());

        final messageDocs = snapshot.data!.docs;

        if (messageDocs.isEmpty) {
          return const Center(child: Text("Hiç mesaj yok."));
        }

        return ListView.builder(
          itemCount: messageDocs.length,
          itemBuilder: (context, index) {
            final chatId = messageDocs[index].id;
            final userId = chatId.replaceAll("_$adminUid", "");

            return FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .doc(userId)
                  .get(),
              builder: (context, userSnapshot) {
                if (!userSnapshot.hasData) {
                  return const ListTile(
                    leading: Icon(Icons.person),
                    title: Text("Yükleniyor..."),
                    subtitle: Text("Mesajlara göz at"),
                    trailing: Icon(Icons.arrow_forward_ios),
                  );
                }

                final userData =
                    userSnapshot.data!.data() as Map<String, dynamic>;
                final userName = userData['full_name'] ?? "Kullanıcı";

                return ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(userName),
                  subtitle: const Text("Mesajlara göz at"),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            AdminChatScreen(userId: userId, userName: userName),
                      ),
                    );
                  },
                );
              },
            );
          },
        );
      },
    ),
  );
}

// Soru form modeli
class QuestionForm {
  final TextEditingController topicController = TextEditingController();
  final TextEditingController questionController = TextEditingController();
  final List<TextEditingController> optionControllers =
      List.generate(4, (_) => TextEditingController());
  String correctAnswer = "";
}
