// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SettingsPage extends StatefulWidget {
  final bool isDarkMode;
  final Function(bool) onToggleDarkMode;

  const SettingsPage({
    super.key,
    required this.isDarkMode,
    required this.onToggleDarkMode,
  });

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late bool _localDarkMode;
  final user = FirebaseAuth.instance.currentUser;
  String fullName = "";

  @override
  void initState() {
    super.initState();
    _localDarkMode = widget.isDarkMode;
    fetchUserName();
  }

  Future<void> fetchUserName() async {
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .get();
    if (doc.exists) {
      setState(() {
        fullName = doc['full_name'] ?? "";
      });
    }
  }

  Future<void> updateUserName(String newName) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .update({'full_name': newName});
    setState(() {
      fullName = newName;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Adınız başarıyla güncellendi")),
    );
  }

  void _showChangeNameDialog() {
    final nameController = TextEditingController(text: fullName);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Adınızı Güncelleyin"),
        content: TextField(
          controller: nameController,
          decoration: InputDecoration(labelText: "Yeni Adınız"),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context), child: Text("İptal")),
          ElevatedButton(
            onPressed: () {
              final newName = nameController.text.trim();
              if (newName.isNotEmpty) {
                updateUserName(newName);
              }
              Navigator.pop(context);
            },
            child: Text("Kaydet"),
          ),
        ],
      ),
    );
  }

  void _resetPassword() async {
    if (user != null && user!.email != null) {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: user!.email!);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text("Şifre sıfırlama bağlantısı e-posta adresinize gönderildi"),
        ),
      );
    }
  }

  void _confirmAccountDeletion() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Hesabı Sil"),
        content: Text(
            "Bu işlem geri alınamaz. Hesabınızı silmek istediğinizden emin misiniz?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Vazgeç"),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              await _deleteAccount();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text("Evet, Sil", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteAccount() async {
    try {
      final uid = user!.uid;
      await FirebaseFirestore.instance.collection('users').doc(uid).delete();
      await FirebaseDatabase.instance.ref('presence/$uid').remove();
      await user!.delete();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Hesabınız silindi.")),
      );
      Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Hesap silinirken bir hata oluştu.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true, // 🔙 Geri ikonunu ekler
        title: Text(
          "Ayarlar",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        backgroundColor: isDark ? Colors.grey[900] : Colors.white,
        iconTheme: IconThemeData(color: isDark ? Colors.white : Colors.black),
        elevation: 2,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (user != null)
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.indigo,
                      child: Icon(Icons.person, size: 30, color: Colors.white),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            fullName.isNotEmpty ? fullName : "Kullanıcı",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(user!.email ?? "",
                              style: TextStyle(color: Colors.grey[600])),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.indigo),
                      onPressed: _showChangeNameDialog,
                    )
                  ],
                ),
              ),
            ),
          const SizedBox(height: 24),
          _buildSettingsCard(
            title: "Genel Ayarlar",
            children: [
              SwitchListTile(
                title: Text("Koyu Mod"),
                value: _localDarkMode,
                onChanged: (val) {
                  setState(() => _localDarkMode = val);
                  widget.onToggleDarkMode(val);
                },
                secondary: Icon(Icons.dark_mode),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildSettingsCard(
            title: "Hesap",
            children: [
              ListTile(
                leading: Icon(Icons.lock_reset),
                title: Text("Şifremi Sıfırla"),
                onTap: user != null ? _resetPassword : null,
                enabled: user != null,
              ),
              ListTile(
                leading: Icon(user == null ? Icons.login : Icons.logout),
                title: Text(user == null ? "Giriş Yap" : "Çıkış Yap"),
                onTap: () async {
                  if (user == null) {
                    Navigator.pushNamed(context, '/login');
                  } else {
                    final uid = user!.uid;
                    await FirebaseDatabase.instance
                        .ref('presence/$uid')
                        .set({'online': false});
                    await FirebaseAuth.instance.signOut();
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/', (route) => false);
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.delete_forever,
                    color: user != null
                        ? Colors.red
                        : Color.fromARGB(255, 239, 132, 124)),
                title: Text(
                  "Hesabı Kalıcı Olarak Sil",
                  style: TextStyle(
                    color: user != null
                        ? Colors.red
                        : const Color.fromARGB(255, 239, 132, 124),
                  ),
                ),
                onTap: user != null ? _confirmAccountDeletion : null,
                enabled: user != null,
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildSettingsCard(
            title: "Hakkında",
            children: [
              ListTile(
                leading: Icon(Icons.info_outline),
                title: Text("Sürüm"),
                subtitle: Text("1.0.1"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsCard({
    required String title,
    required List<Widget> children,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12, left: 8, bottom: 8),
              child: Text(title,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo)),
            ),
            const Divider(),
            ...children,
          ],
        ),
      ),
    );
  }
}
