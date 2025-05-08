// Gerekli Flutter ve Firebase paketlerini içe aktarıyoruz
// ignore_for_file: use_build_context_synchronously

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:kamu_sinavi_app/pages/chat_utils.dart'; // getChatId fonksiyonu burada tanımlı

// Kullanıcının admin ile destek amaçlı mesajlaşabileceği ekran
class MessageToAdminPage extends StatefulWidget {
  const MessageToAdminPage({super.key});

  @override
  State<MessageToAdminPage> createState() => _MessageToAdminPageState();
}

class _MessageToAdminPageState extends State<MessageToAdminPage> {
  final TextEditingController _messageController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser;
  bool _isEmojiVisible = false;
  final FocusNode _focusNode = FocusNode();

  // Admin UID’si sabit olarak tanımlanıyor (bu UID admin hesabına ait olmalı)
  final String adminUid =
      "ENmRcxdvWeYLOWvLVf6JwXd64CE2"; // <-- Güncellemeniz gerekebilir

  late final String chatId;

  @override
  void initState() {
    super.initState();

    if (user != null) {
      // Kullanıcı ve admin arasında sabit bir chatId oluşturuluyor
      chatId = getChatId(user!.uid, adminUid);
    }

    // Klavye odaklandığında emoji paneli kapanmalı
    _focusNode.addListener(() {
      if (_focusNode.hasFocus && _isEmojiVisible) {
        setState(() {
          _isEmojiVisible = false;
        });
      }
    });
  }

  // Mesaj gönderme fonksiyonu
  Future<void> sendMessage() async {
    final text = _messageController.text.trim();

    // Mesaj boşsa veya kullanıcı giriş yapmamışsa gönderme
    if (text.isEmpty || user == null) return;

    // Firestore'a mesaj verisini ekliyoruz
    await FirebaseFirestore.instance
        .collection('messages')
        .doc(chatId)
        .collection('chat')
        .add({
      'senderId': user!.uid,
      'receiverId': adminUid,
      'text': text,
      'timestamp': FieldValue.serverTimestamp(),
      'seen': false, // 🔴 görüldü bilgisi eklendi
    });

    _messageController.clear(); // Mesaj kutusunu temizle
  }

  // Mesajların canlı olarak dinlenmesini sağlayan stream
  Stream<QuerySnapshot> getChatStream() {
    return FirebaseFirestore.instance
        .collection('messages')
        .doc(chatId)
        .collection('chat')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return const Scaffold(
        body: Center(child: Text("Giriş yapmalısınız.")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Canlı Destek"),
        titleTextStyle: const TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
        elevation: 2,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          // 🧾 Mesajlar
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: getChatStream(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final messages = snapshot.data!.docs;

                return ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final doc = messages[index];
                    final message = doc.data() as Map<String, dynamic>;
                    final isMe = message['senderId'] == user!.uid;

                    if (!isMe && message['seen'] != true) {
                      FirebaseFirestore.instance
                          .collection('messages')
                          .doc(chatId)
                          .collection('chat')
                          .doc(doc.id)
                          .update({'seen': true});
                    }

                    return buildMessageBubble(doc);
                  },
                );
              },
            ),
          ),

          const Divider(height: 1),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              border: Border(
                top: BorderSide(color: Colors.grey.shade300),
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Emoji butonu
                    IconButton(
                      icon: Icon(
                        Icons.emoji_emotions_outlined,
                        color: _isEmojiVisible ? Colors.indigo : Colors.grey,
                      ),
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        setState(() => _isEmojiVisible = !_isEmojiVisible);
                      },
                    ),
                    // Mesaj yazma alanı
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextField(
                          controller: _messageController,
                          focusNode: _focusNode,
                          minLines: 1,
                          maxLines: 4,
                          decoration: const InputDecoration.collapsed(
                            hintText: "Mesajınızı yazın...",
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Gönder butonu
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.indigo,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.send, color: Colors.white),
                        onPressed: sendMessage,
                        tooltip: "Gönder",
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 🟡 Emoji paneli
          if (_isEmojiVisible)
            Container(
              height: 300,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border(top: BorderSide(color: Colors.grey.shade300)),
              ),
              child: EmojiPicker(
                onEmojiSelected: (category, emoji) {
                  _messageController.text += emoji.emoji;
                  _messageController.selection = TextSelection.fromPosition(
                    TextPosition(offset: _messageController.text.length),
                  );
                },
                config: Config(
                  emojiViewConfig: const EmojiViewConfig(
                    emojiSizeMax: 28,
                    backgroundColor: Colors.white,
                  ),
                  categoryViewConfig: const CategoryViewConfig(
                    backgroundColor: Colors.white,
                    indicatorColor: Colors.indigo,
                  ),
                  bottomActionBarConfig: BottomActionBarConfig(
                    backgroundColor: Colors.grey[100]!,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget buildMessageBubble(DocumentSnapshot doc) {
    final message = doc.data() as Map<String, dynamic>;
    final isMe = message['senderId'] == user!.uid;
    final isSeen = message['seen'] == true;

    return GestureDetector(
      onLongPress: isMe
          ? () {
              HapticFeedback.mediumImpact(); // Telefon titrer 🚨

              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text("Mesajı Sil"),
                  content:
                      const Text("Bu mesajı herkesten silmek istiyor musunuz?"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("İptal"),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () async {
                        await FirebaseFirestore.instance
                            .collection('messages')
                            .doc(chatId)
                            .collection('chat')
                            .doc(doc.id)
                            .delete();
                        Navigator.pop(context);
                      },
                      child: const Text("Sil"),
                    ),
                  ],
                ),
              );
            }
          : null,
      child: Align(
        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.75,
          ),
          decoration: BoxDecoration(
            color: isMe ? Colors.indigo : Colors.grey.shade200,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(16),
              topRight: const Radius.circular(16),
              bottomLeft:
                  isMe ? const Radius.circular(16) : const Radius.circular(0),
              bottomRight:
                  isMe ? const Radius.circular(0) : const Radius.circular(16),
            ),
          ),
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              if (!isMe)
                const Text(
                  "KamuCep Destek",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              Text(
                message['text'],
                style: TextStyle(
                  fontSize: 15,
                  color: isMe ? Colors.white : Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              if (isMe)
                Text(
                  isSeen ? "✓ Görüldü" : "✓ Gönderildi",
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.white70,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
