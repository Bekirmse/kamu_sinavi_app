// ignore_for_file: deprecated_member_use, duplicate_ignore, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Note {
  String title;
  String content;
  String category;

  Note({
    required this.title,
    required this.content,
    required this.category,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'content': content,
        'category': category,
      };

  static Note fromJson(Map<String, dynamic> json) => Note(
        title: json['title'],
        content: json['content'],
        category: json['category'],
      );
}

class NotlarimScreen extends StatefulWidget {
  const NotlarimScreen({super.key});

  @override
  _NotlarimScreenState createState() => _NotlarimScreenState();
}

class _NotlarimScreenState extends State<NotlarimScreen> {
  List<Note> notlar = [];
  String selectedCategory = 'Hepsi';

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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedNotlar = prefs.getStringList('notlar');

    if (savedNotlar != null) {
      setState(() {
        notlar = savedNotlar.map((e) => Note.fromJson(json.decode(e))).toList();
      });

      if (mounted && notlar.isNotEmpty) {
        Future.delayed(const Duration(milliseconds: 500), () {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              'Notlara tıklayarak detayları görebilir, uzun basarak silebilirsiniz.',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: isDark
                    ? Colors.white
                    : Colors.white, // içerik genelde beyaz kalır
              ),
            ),
            backgroundColor:
                isDark ? Colors.blue.shade400 : Colors.blue.shade600,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            duration: const Duration(seconds: 5),
            margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          ));
        });
      }
    }
  }

  _addNot(String title, String content, String category) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Note newNote = Note(title: title, content: content, category: category);
    setState(() => notlar.add(newNote));
    await prefs.setStringList(
        'notlar', notlar.map((note) => json.encode(note.toJson())).toList());
  }

  _deleteNot(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() => notlar.removeAt(index));
    await prefs.setStringList(
        'notlar', notlar.map((note) => json.encode(note.toJson())).toList());
  }

  void _showAddNotDialog() {
    bool isTablet = MediaQuery.of(context).size.width > 600;
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    String title = '', content = '', newNoteCategory = 'Önemli';

    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: StatefulBuilder(
          builder: (context, setState) => Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Yeni Not Ekle',
                  style: TextStyle(
                    fontSize: isTablet ? 24 : 20,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  onChanged: (v) => title = v,
                  style: TextStyle(
                      fontSize: isTablet ? 20 : 16,
                      color: isDark ? Colors.white : Colors.black),
                  decoration: InputDecoration(
                    labelText: "Başlık",
                    labelStyle:
                        TextStyle(color: isDark ? Colors.white70 : Colors.grey),
                    filled: true,
                    fillColor:
                        isDark ? const Color(0xFF2C2C2C) : Colors.grey.shade100,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  onChanged: (v) => content = v,
                  maxLines: 4,
                  style: TextStyle(
                      fontSize: isTablet ? 20 : 16,
                      color: isDark ? Colors.white : Colors.black),
                  decoration: InputDecoration(
                    labelText: "İçerik",
                    labelStyle: TextStyle(
                        color: isDark ? Colors.white70 : Colors.grey.shade600),
                    filled: true,
                    fillColor:
                        isDark ? const Color(0xFF2C2C2C) : Colors.grey.shade100,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color:
                        isDark ? const Color(0xFF2C2C2C) : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: DropdownButton<String>(
                    value: newNoteCategory,
                    underline: Container(),
                    isExpanded: true,
                    icon: Icon(Icons.arrow_drop_down,
                        color: isDark ? Colors.white : Colors.black),
                    items: ['Önemli', 'Yapılacaklar']
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (v) => setState(() => newNoteCategory = v!),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isDark
                            ? Colors.grey.shade800
                            : Colors.grey.shade300,
                      ),
                      child: Text('İptal',
                          style: TextStyle(
                              color: isDark ? Colors.white : Colors.black)),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: () {
                        if (title.isNotEmpty && content.isNotEmpty) {
                          _addNot(title, content, newNoteCategory);
                          Navigator.pop(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade600,
                      ),
                      child: const Text('Ekle',
                          style: TextStyle(color: Colors.white)),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Note> _filteredNotlar() => selectedCategory == 'Hepsi'
      ? notlar
      : notlar.where((n) => n.category == selectedCategory).toList();

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width > 600;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : Colors.white,
      appBar: AppBar(
        backgroundColor: isDark ? const Color(0xFF1C1C1C) : Colors.white,
        elevation: 2,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: isDark ? Colors.white : Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Notlarım',
          style: TextStyle(
              fontSize: isTablet ? 25 : 20,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black),
        ),
      ),
      body: Column(
        children: [
          _buildCategoryButtons(isDark),
          Expanded(
            child: _filteredNotlar().isEmpty
                ? Center(
                    child: Text(
                      "Henüz not oluşturulmadı",
                      style: TextStyle(
                          fontSize: isTablet ? 22 : 18,
                          color: isDark ? Colors.white70 : Colors.grey),
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: _filteredNotlar().length,
                    itemBuilder: (context, index) {
                      return _buildNoteCard(
                          _filteredNotlar()[index], index, isDark);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddNotDialog,
        backgroundColor: Colors.blue,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text("Not Ekle",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      ),
    );
  }

  Widget _buildCategoryButtons(bool isDark) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildCategoryButton('Hepsi', Colors.blueGrey, isDark),
              _buildCategoryButton('Önemli', Colors.orange, isDark),
              _buildCategoryButton('Yapılacaklar', Colors.blue, isDark),
            ],
          ),
        ),
      );

  Widget _buildCategoryButton(String title, Color color, bool isDark) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: ChoiceChip(
          label: Text(title),
          labelStyle: TextStyle(
            color: selectedCategory == title
                ? Colors.white
                : isDark
                    ? Colors.white70
                    : Colors.black87,
            fontWeight: FontWeight.w600,
          ),
          selectedColor: color,
          backgroundColor: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
          selected: selectedCategory == title,
          onSelected: (_) => setState(() => selectedCategory = title),
        ),
      );
  void _showNoteDetailsDialog(Note note) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          note.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.content,
              style: TextStyle(
                fontSize: 14,
                height: 1.5,
                color: isDark ? Colors.white70 : Colors.black87,
              ),
            ),
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

  Widget _buildNoteCard(Note note, int index, bool isDark) => Card(
        elevation: 4,
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
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
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: Text(
                    note.content,
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.4,
                      color: isDark ? Colors.white70 : Colors.black87,
                    ),
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
