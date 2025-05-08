import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kamu_sinavi_app/infos/genel_kultur_infos.dart';
import 'package:kamu_sinavi_app/infos/iyi_idare_yasasi_infos.dart';
import 'package:kamu_sinavi_app/infos/kamu_yasasi_infos.dart';
import 'package:kamu_sinavi_app/infos/kktc_anayasasi_infos.dart';
import 'package:kamu_sinavi_app/infos/ogretmen_yasasi_infos.dart';
import 'package:kamu_sinavi_app/infos/ogretmenlik_sinavi_on_hazirlik_infos.dart';
import 'package:kamu_sinavi_app/infos/sivilhavacilikdairesi_yasasi_infos.dart';
import 'package:wiredash/wiredash.dart';

class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MainMenuScreenState createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF1B1B1B),
                  Color(0xFF1B1B1B)
                ], // Tek renk AppBar
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          title: const Text(
            'Bilgiler',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [
                Shadow(
                  blurRadius: 5.0,
                  color: Colors.black26,
                  offset: Offset(2.0, 2.0),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
      backgroundColor: const Color(0xFF1B1B1B),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 2, // Two cards per row
          crossAxisSpacing: 8.0, // Equal horizontal spacing
          mainAxisSpacing: 8.0, // Equal vertical spacing
          shrinkWrap: true,
          clipBehavior: Clip.none,
          children: <Widget>[
            _buildGridTile(
              context,
              'Kamu Görevlileri Yasası Çalışma Bilgileri',
              Icons.gavel,
              const KamuYasasiInfos(), // Pass the widget for the screen here
              48.0, // Icon size
              Colors.blueAccent, // Icon color
            ),
            _buildGridTile(
              context,
              'KKTC Anayasası Çalışma Bilgileri',
              Icons.book,
              const KktcAnayasasiInfos(), // Correct widget passed
              48.0, // Icon size
              Colors.redAccent, // Icon color
            ),
            _buildGridTile(
              context,
              'Öğretmen Yasası Çalışma Bilgileri',
              Icons.school,
              const OgretmenYasasiInfos(), // Correct widget passed
              48.0, // Icon size
              Colors.greenAccent, // Icon color
            ),
            _buildGridTile(
              context,
              'Öğretmenlik Sınavı Ön Hazırlık Bilgileri',
              Icons.history_edu,
              const OgretmenlikSinaviOnHazirlikInfos(), // Correct widget passed
              48.0, // Icon size
              Colors.orangeAccent, // Icon color
            ),
            _buildGridTile(
              context,
              'İyi İdare Yasası Çalışma Bilgileri',
              Icons.edit_document,
              const IyiIdareYasasiInfos(), // Correct widget passed
              48.0, // Icon size
              Colors.purpleAccent, // Icon color
            ),
            _buildGridTile(
              context,
              'Sivil Havacılık Dairesi Yasası Çalışma Bilgileri',
              Icons.flight,
              const SivilhavacilikdairesiYasasiInfos(), // Correct widget passed
              48.0, // Icon size
              Colors.cyanAccent, // Icon color
            ),
            _buildGridTile(
              context,
              'Genel Kültür Çalışma Bilgileri',
              Icons.public,
              const GenelKulturInfos(
                title: '',
              ), // Correct widget passed
              48.0, // Icon size
              Colors.amberAccent, // Icon color
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          try {
            Wiredash.of(context).show();
          } catch (e) {
            if (kDebugMode) {
              print('Error opening feedback: $e');
            }
          }
        },
        backgroundColor:
            const Color.fromARGB(255, 227, 150, 8), // Parlak turuncu renk
        child: const Icon(Icons.feedback, color: Colors.white),
      ),
    );
  }

  Widget _buildGridTile(BuildContext context, String title, IconData icon,
      Widget screen, double iconSize, Color iconColor) {
    return Container(
      margin: const EdgeInsets.all(4.0), // Equal margin on all sides
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            _createRoute(screen),
          );
        },
        child: Card(
          color: const Color(0xFF2E2E2E), // Dark background color
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon,
                  size: iconSize,
                  color: iconColor), // Use iconSize and iconColor
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15.0,
                  color: Colors.white, // Text color white
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Route _createRoute(Widget screen) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
