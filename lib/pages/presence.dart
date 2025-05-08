// lib/services/presence.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

void initPresenceTracking() {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return;

  final dbRef = FirebaseDatabase.instance.ref("presence/${user.uid}");

  // Kullanıcı çevrim içi
  dbRef.set({"online": true});

  // Kullanıcı bağlantıyı koparırsa offline olarak işaretle
  dbRef.onDisconnect().set({"online": false});
}
