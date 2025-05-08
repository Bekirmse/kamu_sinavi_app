// ignore_for_file: use_build_context_synchronously
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'registerPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;
  bool _isLoading = false;
  bool _rememberMe = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadRememberMe();
  }

  Future<void> _loadRememberMe() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() => _rememberMe = prefs.getBool('rememberMe') ?? false);
  }

  Future<void> _signIn() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      final userDoc =
          await _firestore.collection('users').doc(credential.user!.uid).get();
      final role = userDoc.data()?['role'] ?? 'user';

      if (role != 'admin' && !credential.user!.emailVerified) {
        await _auth.signOut();
        setState(
            () => _errorMessage = "E-posta adresinizi doğrulamanız gerekiyor.");
        return;
      }

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('rememberMe', _rememberMe);

      final dbRef =
          FirebaseDatabase.instance.ref('presence/${credential.user!.uid}');
      await dbRef.set({'online': true});

      Navigator.pushReplacementNamed(
          context, role == 'admin' ? '/admin' : '/main');
    } on FirebaseAuthException catch (e) {
      setState(() => _errorMessage = getErrorMessage(e.code));
    } catch (_) {
      setState(() => _errorMessage =
          "Bir hata oluştu. Lütfen daha sonra tekrar deneyiniz.");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _resetPassword() async {
    if (_emailController.text.isEmpty) {
      setState(() => _errorMessage = "Lütfen e-posta adresinizi giriniz.");
      return;
    }

    await _auth.sendPasswordResetEmail(email: _emailController.text.trim());
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Şifre sıfırlama e-postası gönderildi.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : Colors.grey.shade50,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(Icons.lock_outline,
                  size: 80, color: Colors.blueAccent),
              const SizedBox(height: 16),
              Text(
                "Kullanıcı Girişi",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 32),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(color: isDark ? Colors.white : Colors.black),
                decoration: _inputDecoration("E-posta adresi", isDark),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: _obscureText,
                style: TextStyle(color: isDark ? Colors.white : Colors.black),
                decoration: _inputDecoration("Şifre", isDark).copyWith(
                  suffixIcon: IconButton(
                    icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility),
                    onPressed: () =>
                        setState(() => _obscureText = !_obscureText),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: _rememberMe,
                        onChanged: (val) =>
                            setState(() => _rememberMe = val ?? false),
                      ),
                      Text("Beni Hatırla",
                          style: TextStyle(
                              color: isDark ? Colors.white70 : Colors.black)),
                    ],
                  ),
                  TextButton(
                    onPressed: _resetPassword,
                    child: const Text("Şifremi unuttum?"),
                  ),
                ],
              ),
              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    _errorMessage!,
                    style: const TextStyle(color: Colors.redAccent),
                    textAlign: TextAlign.center,
                  ),
                ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isLoading ? null : _signIn,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  backgroundColor: Colors.blueAccent,
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Giriş Yap",
                        style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const RegisterPage())),
                child: const Text("Henüz hesabınız yok mu? Kayıt Ol",
                    style: TextStyle(color: Colors.blueAccent)),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, "/");
                },
                child: const Text(
                  "Giriş yapmadan devam et",
                  style: TextStyle(
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label, bool isDark) =>
      InputDecoration(
        labelText: label,
        labelStyle:
            TextStyle(color: isDark ? Colors.white70 : Colors.grey.shade700),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        fillColor: isDark ? const Color(0xFF2A2A2A) : Colors.white,
        filled: true,
      );

  String getErrorMessage(String code) =>
      {
        'invalid-email': 'Geçersiz e-posta adresi.',
        'user-not-found': 'Kullanıcı bulunamadı.',
        'wrong-password': 'Şifre yanlış.',
        'user-disabled': 'Hesap devre dışı bırakılmış.',
      }[code] ??
      'Beklenmeyen hata oluştu.';
}
