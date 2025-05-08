// ignore_for_file: use_build_context_synchronously
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'loginPage.dart';
import 'package:url_launcher/url_launcher.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _obscurePassword = true;
  bool _isLoading = false;
  bool _agreedToTerms = false;
  String? _errorMessage;
  bool _hasUppercase = false;
  bool _hasDigit = false;

  void _validatePassword(String password) {
    setState(() {
      _hasUppercase = RegExp(r'[A-Z]').hasMatch(password);
      _hasDigit = RegExp(r'[0-9]').hasMatch(password);
    });
  }

  Future<void> _register() async {
    setState(() => _errorMessage = null);

    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();
    final fullName = _fullNameController.text.trim();
    final email = _emailController.text.trim();

    if (fullName.isEmpty) {
      setState(() => _errorMessage = "Ad Soyad boş bırakılamaz.");
      return;
    }
    if (email.isEmpty) {
      setState(() => _errorMessage = "E-posta adresi boş bırakılamaz.");
      return;
    }

    if (password.length < 8 || !_hasUppercase || !_hasDigit) {
      setState(() => _errorMessage =
          "Şifre en az 8 karakter, bir büyük harf ve bir rakam içermelidir.");
      return;
    }

    if (password != confirmPassword) {
      setState(() => _errorMessage = "Şifreler uyuşmuyor.");
      return;
    }
    if (!_agreedToTerms) {
      setState(() => _errorMessage = "Sözleşmeyi kabul etmelisiniz.");
      return;
    }

    setState(() => _isLoading = true);

    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'full_name': fullName,
        'email': email,
        'role': 'user',
        'created_at': FieldValue.serverTimestamp(),
      });

      await userCredential.user!.sendEmailVerification();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Doğrulama e-postası gönderildi.')),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'invalid-email':
          errorMessage = 'Geçersiz e-posta adresi girdiniz.';
          break;
        case 'email-already-in-use':
          errorMessage = 'Bu e-posta adresi zaten kullanımda.';
          break;
        case 'weak-password':
          errorMessage = 'Şifreniz çok zayıf.';
          break;
        default:
          errorMessage = 'Bir hata oluştu: ${e.message}';
      }
      setState(() => _errorMessage = errorMessage);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    Color getCheckColor(bool condition) =>
        condition ? Colors.green : Colors.grey;

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(Icons.person_add, size: 80, color: Colors.blueAccent),
              const SizedBox(height: 16),
              const Text(
                "Yeni Hesap Oluştur",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32),
              TextField(
                controller: _fullNameController,
                decoration: _inputDecoration("Ad Soyad"),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _emailController,
                decoration: _inputDecoration("E-posta adresi"),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                onChanged: _validatePassword,
                obscureText: _obscurePassword,
                decoration: _inputDecoration("Şifre").copyWith(
                  suffixIcon: IconButton(
                    icon: Icon(_obscurePassword
                        ? Icons.visibility_off
                        : Icons.visibility),
                    onPressed: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.check_circle,
                            size: 16, color: getCheckColor(_hasUppercase)),
                        const SizedBox(width: 6),
                        Text(
                          "En az 1 büyük harf",
                          style: TextStyle(
                              fontSize: 13,
                              color: getCheckColor(_hasUppercase)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.check_circle,
                            size: 16, color: getCheckColor(_hasDigit)),
                        const SizedBox(width: 6),
                        Text(
                          "En az 1 rakam",
                          style: TextStyle(
                              fontSize: 13, color: getCheckColor(_hasDigit)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _confirmPasswordController,
                obscureText: _obscurePassword,
                decoration: _inputDecoration("Şifre Tekrar"),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Checkbox(
                    value: _agreedToTerms,
                    onChanged: (val) =>
                        setState(() => _agreedToTerms = val ?? false),
                  ),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          color: Colors.blueAccent,
                          decoration: TextDecoration.underline,
                        ),
                        children: [
                          TextSpan(
                            text: "Kullanıcı Sözleşmesi",
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => launchUrl(Uri.parse(
                                  'https://sites.google.com/view/kullanicisozlesmesi/ana-sayfa')),
                          ),
                          const TextSpan(
                            text: " ve ",
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              color: Colors.black87,
                            ),
                          ),
                          TextSpan(
                            text: "Gizlilik Politikası",
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => launchUrl(Uri.parse(
                                  'https://sites.google.com/view/kamucepsorubankasi/ana-sayfa')),
                          ),
                          const TextSpan(
                            text: "'nı kabul ediyorum.",
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
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
                onPressed: _isLoading ? null : _register,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  backgroundColor: Colors.blueAccent,
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Kayıt Ol",
                        style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () => Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => const LoginPage())),
                child: const Text("Zaten hesabınız var mı? Giriş Yap",
                    style: TextStyle(color: Colors.blueAccent)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label) => InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      );
}
