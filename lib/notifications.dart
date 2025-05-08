// ignore_for_file: use_build_context_synchronously

// Gerekli Flutter ve Firestore paketlerini içe aktar
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Bildirim panelini alttan kayan şekilde gösteren fonksiyon
void showNotificationsPanel(BuildContext context) {
  final isDark = Theme.of(context).brightness == Brightness.dark;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
    ),
    builder: (BuildContext context) {
      return FractionallySizedBox(
        heightFactor: 0.8,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(16.0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Bildirimler",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Divider(
                  color: isDark ? Colors.grey.shade700 : Colors.grey.shade300),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('notifications')
                      .orderBy('timestamp', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Center(
                        child: Text(
                          "Henüz bildirim yok.",
                          style: TextStyle(
                            color: isDark ? Colors.white70 : Colors.black54,
                          ),
                        ),
                      );
                    }

                    final docs = snapshot.data!.docs;

                    return ListView.builder(
                      itemCount: docs.length,
                      itemBuilder: (context, index) {
                        final data = docs[index].data() as Map<String, dynamic>;

                        return ListTile(
                          leading: Icon(
                            _getIconFromName(data['icon'] ?? 'notifications'),
                            color: _parseColor(data['color'] ?? 'blue'),
                          ),
                          title: Text(
                            data['title'] ?? '',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.white : Colors.black,
                            ),
                          ),
                          subtitle: Text(
                            data['subtitle'] ?? '',
                            style: TextStyle(
                              color: isDark ? Colors.white70 : Colors.black87,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

// 🔵 Firestore'dan gelen string renk adını gerçek bir Color nesnesine çevirir
Color _parseColor(String colorName) {
  switch (colorName.toLowerCase()) {
    case 'red':
      return Colors.red;
    case 'green':
      return Colors.green;
    case 'blue':
      return Colors.blue;
    case 'orange':
      return Colors.orange;
    case 'purple':
      return Colors.purple;
    default:
      return Colors.grey; // Tanımsızsa gri kullanılır
  }
}

// 🔔 Firestore'dan gelen icon adını IconData'ya çevirir
IconData _getIconFromName(String iconName) {
  switch (iconName.toLowerCase()) {
    case 'warning':
      return Icons.warning;
    case 'info':
      return Icons.info;
    case 'error':
      return Icons.error;
    case 'update':
      return Icons.system_update;
    default:
      return Icons.notifications; // Varsayılan simge
  }
}
