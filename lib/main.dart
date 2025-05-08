// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:kamu_sinavi_app/pages/settingsPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:wiredash/wiredash.dart';
import 'firebase_options.dart';

// Sayfalar
import 'package:kamu_sinavi_app/pages/Kamu_sinavlari.dart';
import 'package:kamu_sinavi_app/pages/loginPage.dart';
import 'package:kamu_sinavi_app/pages/registerPage.dart';
import 'package:kamu_sinavi_app/pages/adminDashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  debugPrint("✅ Firebase başarıyla başlatıldı");

  final prefs = await SharedPreferences.getInstance();
  final isDarkMode = prefs.getBool('darkMode') ?? false;

  runApp(MyApp(isDarkMode: isDarkMode));
}

class MyApp extends StatefulWidget {
  final bool isDarkMode;
  const MyApp({super.key, required this.isDarkMode});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late bool _isDarkMode;

  @override
  void initState() {
    super.initState();
    _isDarkMode = widget.isDarkMode;
  }

  void _toggleDarkMode(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkMode', value);
    setState(() {
      _isDarkMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Wiredash(
      projectId: 'kamucep-soru-bankas-xsnbg1d',
      secret: 'rs9H2OgH7QAqAP8TqnjqNT9fF8PjQR_Q',
      options: const WiredashOptionsData(locale: Locale('tr')),
      child: ShowCaseWidget(
        builder: (context) => MaterialApp(
          title: 'KKTC Kamu Testi',
          debugShowCheckedModeBanner: false,
          themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
          theme: ThemeData(primarySwatch: Colors.indigo),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primarySwatch: Colors.indigo,
            scaffoldBackgroundColor: const Color(0xFF121212), // BU VAR
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFF1F1F1F),
              foregroundColor: Colors.white,
            ),
            cardColor: const Color(0xFF1E1E1E),
            textTheme: const TextTheme(
              bodyLarge: TextStyle(color: Colors.white70),
              bodyMedium: TextStyle(color: Colors.white60),
              titleLarge: TextStyle(color: Colors.white),
            ),
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            WiredashLocalizations.delegate,
          ],
          supportedLocales: const [Locale('tr')],
          initialRoute: '/',
          routes: {
            '/': (context) => AuthGate(
                  isDarkMode: _isDarkMode,
                  onToggleDarkMode: _toggleDarkMode,
                ),
            '/login': (context) => const LoginPage(),
            '/register': (context) => const RegisterPage(),
            '/main': (context) => KamuSinavlariScreen(
                  isDarkMode: _isDarkMode,
                  onToggleDarkMode: _toggleDarkMode,
                ),
            '/admin': (context) => const AdminDashboard(),
            '/settings': (context) => SettingsPage(
                  isDarkMode: _isDarkMode,
                  onToggleDarkMode: _toggleDarkMode,
                ),
          },
        ),
      ),
    );
  }
}

class AuthGate extends StatelessWidget {
  final bool isDarkMode;
  final Function(bool) onToggleDarkMode;

  const AuthGate({
    super.key,
    required this.isDarkMode,
    required this.onToggleDarkMode,
  });

  Future<bool> isRemembered() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('rememberMe') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: isRemembered(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            backgroundColor: Color(0xFF074299),
            body: Center(child: CircularProgressIndicator(color: Colors.white)),
          );
        }

        return StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, authSnapshot) {
            if (authSnapshot.connectionState == ConnectionState.active) {
              final user = authSnapshot.data;

              if (user != null && snapshot.data == true) {
                final db = FirebaseDatabase.instanceFor(
                  app: Firebase.app(),
                  databaseURL:
                      'https://kamucep-f819e-default-rtdb.firebaseio.com/',
                );
                final userRef = db.ref('presence/${user.uid}');

// Uygulama çalışırken online olarak işaretle
                userRef.set({
                  'online': true,
                  'lastSeen': ServerValue.timestamp,
                });

// Uygulama kapanınca otomatik offline yap
                userRef.onDisconnect().set({
                  'online': false,
                  'lastSeen': ServerValue.timestamp,
                });

                return FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('users')
                      .doc(user.uid)
                      .get(),
                  builder: (context, roleSnapshot) {
                    if (roleSnapshot.connectionState == ConnectionState.done &&
                        roleSnapshot.hasData) {
                      final roleData = roleSnapshot.data!;
                      final roleRaw = roleData.data() as Map<String, dynamic>?;
                      final role = roleRaw?['role']?.toString() ?? 'user';

                      final isWeb = Theme.of(context).platform ==
                              TargetPlatform.fuchsia ||
                          Theme.of(context).platform == TargetPlatform.macOS ||
                          Theme.of(context).platform == TargetPlatform.windows;

                      if (role == 'admin' && isWeb) {
                        return const AdminDashboard();
                      }

                      return KamuSinavlariScreen(
                        isDarkMode: isDarkMode,
                        onToggleDarkMode: onToggleDarkMode,
                      );
                    }

                    return const Scaffold(
                      backgroundColor: Color(0xFF074299),
                      body: Center(
                          child:
                              CircularProgressIndicator(color: Colors.white)),
                    );
                  },
                );
              } else {
                return KamuSinavlariScreen(
                  isDarkMode: isDarkMode,
                  onToggleDarkMode: onToggleDarkMode,
                );
              }
            }

            return const Scaffold(
              backgroundColor: Color(0xFF074299),
              body:
                  Center(child: CircularProgressIndicator(color: Colors.white)),
            );
          },
        );
      },
    );
  }
}
