// ignore_for_file: use_build_context_synchronously

// Gerekli Flutter ve Firestore paketlerini içe aktar
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Bildirim panelini alttan kayan şekilde gösteren fonksiyon
void showNotificationsPanel(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true, // Panel ekranın büyük kısmını kaplayabilsin
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
    ),
    builder: (BuildContext context) {
      return FractionallySizedBox(
        heightFactor: 0.8, // Ekranın %80’ini kaplayacak
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(16.0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Panel başlığı
              const Text(
                "Bildirimler",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              const Divider(), // İnce çizgi

              // 🔔 Bildirimlerin listelendiği alan
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection(
                          'notifications') // Firestore'daki bildirim koleksiyonu
                      .orderBy('timestamp',
                          descending: true) // En son gelenler en üstte
                      .snapshots(),
                  builder: (context, snapshot) {
                    // Veri bekleniyorsa yükleme animasyonu göster
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    // Veri yoksa uyarı göster
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(child: Text("Henüz bildirim yok."));
                    }

                    final docs = snapshot.data!.docs;

                    // Bildirimleri listele
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
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(data['subtitle'] ?? ''),
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
