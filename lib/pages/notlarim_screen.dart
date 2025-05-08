// ignore_for_file: deprecated_member_use, duplicate_ignore, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

// Not Modeli
class Note {
  String title;
  String content;
  String category;

  Note({
    required this.title,
    required this.content,
    required this.category,
  });

  // Notu JSON'a dönüştürme fonksiyonu
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'category': category,
    };
  }

  // JSON'dan Not nesnesi oluşturma fonksiyonu
  static Note fromJson(Map<String, dynamic> json) {
    return Note(
      title: json['title'],
      content: json['content'],
      category: json['category'],
    );
  }
}

class NotlarimScreen extends StatefulWidget {
  const NotlarimScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NotlarimScreenState createState() => _NotlarimScreenState();
}

class _NotlarimScreenState extends State<NotlarimScreen> {
  List<Note> notlar = [];
  String selectedCategory = 'Hepsi'; // Varsayılan kategori

  // Kartların arka plan renklerini tanımlıyoruz
  final List<Color> cardColors = [
    Colors.blueGrey.shade400,
    Colors.teal.shade400,
    Colors.amber.shade400,
    Colors.deepOrange.shade400,
    Colors.indigo.shade400,
    Colors.brown.shade400,
    Colors.purple.shade400,
    Colors.cyan.shade400,
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, _loadNotlar);
  }

  _loadNotlar() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedNotlar = prefs.getStringList('notlar');

    if (savedNotlar != null) {
      debugPrint("📦 savedNotlar verisi yüklendi. Adet: ${savedNotlar.length}");

      try {
        setState(() {
          notlar = savedNotlar.map((notString) {
            final decoded = json.decode(notString);
            final note = Note.fromJson(decoded);
            debugPrint("✅ Not yüklendi: ${note.title}");
            return note;
          }).toList();
        });

        debugPrint(
            "🎉 Tüm notlar başarıyla setState ile yüklendi. Toplam: ${notlar.length}");

        // Bilgilendirme kutucuğu (SnackBar) ekleniyor
        if (mounted && notlar.isNotEmpty) {
          Future.delayed(const Duration(milliseconds: 500), () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text(
                  'Notlara tıklayarak detayları görebilir, uzun basarak silebilirsiniz.',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                backgroundColor: Colors.blue.shade600,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                duration: const Duration(seconds: 5),
                margin:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              ),
            );
          });
        }
      } catch (e) {
        debugPrint("❌ Notları yüklerken hata oluştu: $e");
      }
    } else {
      debugPrint("⚠️ savedNotlar verisi null geldi.");
    }
  }

  _addNot(String title, String content, String category) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Note newNote = Note(title: title, content: content, category: category);

    setState(() {
      notlar.add(newNote);
    });

    List<String> notlarString =
        notlar.map((note) => json.encode(note.toJson())).toList();

    // ✅ Set işlemi setState dışına alınmalı ve await eklenmeli
    await prefs.setStringList('notlar', notlarString);
  }

  _deleteNot(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      notlar.removeAt(index);
    });

    List<String> notlarString =
        notlar.map((note) => json.encode(note.toJson())).toList();

    await prefs.setStringList('notlar', notlarString); // ✅ await eklendi
  }

  void _showAddNotDialog() {
    bool isTablet = MediaQuery.of(context).size.width > 600;
    String title = '';
    String content = '';
    String newNoteCategory = 'Önemli'; // Varsayılan kategori

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      // ignore: deprecated_member_use
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Yeni Not Ekle',
                        style: TextStyle(
                          fontSize: isTablet ? 24 : 20,
                          fontWeight: FontWeight.bold,
                          // ignore: deprecated_member_use
                          color: Colors.black.withOpacity(0.8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextField(
                      onChanged: (value) {
                        title = value;
                      },
                      style: TextStyle(fontSize: isTablet ? 20 : 16),
                      decoration: InputDecoration(
                        labelText: "Başlık",
                        labelStyle: TextStyle(color: Colors.grey.shade600),
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextField(
                      onChanged: (value) {
                        content = value;
                      },
                      maxLines: 4,
                      style: TextStyle(fontSize: isTablet ? 20 : 16),
                      decoration: InputDecoration(
                        labelText: "İçerik",
                        labelStyle: TextStyle(color: Colors.grey.shade600),
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: DropdownButton<String>(
                        value: newNoteCategory,
                        underline: Container(),
                        isExpanded: true,
                        // ignore: deprecated_member_use
                        style: TextStyle(color: Colors.black.withOpacity(0.7)),
                        items: [
                          'Önemli',
                          'Yapılacaklar',
                        ].map((String category) {
                          return DropdownMenuItem<String>(
                            value: category,
                            child: Text(category),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            newNoteCategory = value!;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey.shade300,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          child: const Text(
                            'İptal',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton(
                          onPressed: () {
                            if (title.isNotEmpty && content.isNotEmpty) {
                              _addNot(title, content, newNoteCategory);
                              Navigator.of(context).pop();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade600,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          child: const Text(
                            'Ekle',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  // Kategorilere göre filtreleme
  List<Note> _filteredNotlar() {
    if (selectedCategory == 'Hepsi') {
      return notlar;
    }
    return notlar.where((note) => note.category == selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    bool isTablet = MediaQuery.of(context).size.width > 600;
    return Scaffold(
      backgroundColor: Colors.white, // Beyaz arka plan
      appBar: AppBar(
        backgroundColor: Colors.white, // AppBar Arka Planı Beyaz
        elevation: 2,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Colors.black), // Geri tuşu mavi-gri
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Notlarım',
          style: TextStyle(
            fontSize: isTablet ? 25 : 20,
            fontWeight: FontWeight.bold,
            color: Colors.black, // Başlık rengi mavi-gri
          ),
        ),
      ),
      body: Column(
        children: [
          _buildCategoryButtons(),
          Expanded(
            child: _filteredNotlar().isEmpty
                ? Center(
                    child: Text(
                      "Henüz not oluşturulmadı",
                      style: TextStyle(
                        fontSize: isTablet ? 22 : 18,
                        color: Colors.grey,
                      ),
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(16.0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: _filteredNotlar().length,
                    itemBuilder: (context, index) {
                      return _buildNoteCard(_filteredNotlar()[index], index);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showAddNotDialog();
        },
        backgroundColor: Colors.blue, // Mavi buton
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          "Not Ekle",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildCategoryButton(
                'Hepsi', Colors.blueGrey, selectedCategory == 'Hepsi'),
            _buildCategoryButton(
                'Önemli', Colors.orange, selectedCategory == 'Önemli'),
            _buildCategoryButton('Yapılacaklar', Colors.blue,
                selectedCategory == 'Yapılacaklar'),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryButton(String title, Color color, bool selected) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: ChoiceChip(
        label: Text(title),
        labelStyle: TextStyle(
          color: selected ? Colors.white : Colors.black87,
          fontWeight: FontWeight.w600,
        ),
        selectedColor: color,
        backgroundColor: Colors.grey.shade200,
        selected: selected,
        onSelected: (_) => setState(() => selectedCategory = title),
      ),
    );
  }

  void _showNoteDetailsDialog(Note note) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          note.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(note.content,
                style: const TextStyle(fontSize: 14, height: 1.5)),
            const SizedBox(height: 12),
            Chip(
              label: Text(note.category),
              backgroundColor:
                  _getCategoryColor(note.category).withOpacity(0.2),
              labelStyle: TextStyle(
                color: _getCategoryColor(note.category).shade800,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Kapat"),
          ),
        ],
      ),
    );
  }

  Widget _buildNoteCard(Note note, int index) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => _showNoteDetailsDialog(note),
        onLongPress: () => _deleteNot(index),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                note.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Text(
                  note.content,
                  style: const TextStyle(fontSize: 14, height: 1.4),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.bottomRight,
                child: Chip(
                  label: Text(note.category),
                  backgroundColor:
                      _getCategoryColor(note.category).withOpacity(0.1),
                  labelStyle: TextStyle(
                    color: _getCategoryColor(note.category).shade800,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  MaterialColor _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'önemli':
        return Colors.red;
      case 'yapılacaklar':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}
