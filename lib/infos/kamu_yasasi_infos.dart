import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KamuYasasiInfos extends StatefulWidget {
  const KamuYasasiInfos({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _KamuYasasiInfosState createState() => _KamuYasasiInfosState();
}

class _KamuYasasiInfosState extends State<KamuYasasiInfos> {
  final List<Map<String, dynamic>> topics = [
    {
      "title": "Kamu Personeli Türleri",
      "details": [
        "Kamu hizmetinde 3 çeşit personel istihdam edilir: Sürekli personel, sözleşmeli personel, işçiler.",
        "Sürekli personel, kamu hizmetinde sürekli görevlere atanan personeldir.",
        "Sözleşmeli personel, özel bir mesleği veya uzmanlığı olan ve geçici süre sözleşmeli çalıştırılan kişilerdir.",
        "İşçiler, devlet hizmetinde işçi kadrosunda çalıştırılan kişilerdir.",
        "Sürekli personel, memur statüsündedir.",
        "Sözleşmeli personel, belirli bir iş için belirli bir süre çalıştırılır.",
        "İşçilerin hakları, 4857 sayılı İş Kanunu ile düzenlenmiştir.",
        "Sürekli personel, kamu görevlisi olarak atanır.",
        "Sözleşmeli personelin iş ilişkisi, belirli süreli iş sözleşmesine dayanır.",
        "İşçiler, genellikle fiziksel emek gerektiren işlerde çalışır."
      ]
    },
    {
      "title": "Kamu Görevlilerinin Görevleri ve Sorumlulukları",
      "details": [
        "Kamu görevlilerinin uymakla yükümlü oldukları ödevler: Tarafsızlık, sadakat, dürüstlük.",
        "Kamu görevlileri, görevlerini kanunlara ve mevzuata uygun olarak yerine getirmelidir.",
        "Kamu görevlileri, görevleri sırasında edindikleri bilgileri gizli tutmakla yükümlüdür.",
        "Görevi kötüye kullanma, kamu görevlisinin görevini mevzuata aykırı olarak yerine getirmesi durumudur.",
        "Kamu görevlileri, görevlerini tarafsız ve adil bir şekilde yerine getirmelidir.",
        "Kamu görevlileri, meslek etik kurallarına uygun hareket etmelidir.",
        "Kamu görevlilerinin dürüst olması, kamu hizmetinin temel gerekliliklerindendir.",
        "Kamu görevlileri, kişisel çıkarları için görevlerini kötüye kullanamazlar.",
        "Kamu görevlileri, mevzuata aykırı emirleri yerine getirmemelidir.",
        "Kamu görevlileri, vatandaşa karşı sorumluluk taşır."
      ]
    },
    {
      "title": "Kamu Görevlilerinin Hakları ve İmkanları",
      "details": [
        "Kamu görevlileri, anayasal olarak güvence altına alınmış haklara sahiptir.",
        "Kamu görevlileri, sosyal güvenlik hakkına sahiptir.",
        "Kamu görevlileri, sendikal haklara sahiptir.",
        "Kamu görevlilerinin iş güvencesi, anayasal koruma altındadır.",
        "Kamu görevlileri, belirli şartlarda emekli olabilirler.",
        "Kamu görevlileri, izin hakkına sahiptir.",
        "Kamu görevlilerinin maaşları, kanunla düzenlenir.",
        "Kamu görevlileri, çalışma koşullarının iyileştirilmesini talep edebilir.",
        "Kamu görevlileri, iş yerinde ayrımcılığa maruz kalamazlar.",
        "Kamu görevlileri, mesai saatlerine uygun olarak çalışırlar."
      ]
    },
    {
      "title": "Kamu Görevlilerinin Eğitim ve Yetiştirilmesi",
      "details": [
        "Kamu görevlilerinin mesleki eğitimi, sürekli eğitim programlarıyla desteklenir.",
        "Kamu görevlileri, hizmet içi eğitime tabi tutulur.",
        "Kamu görevlilerinin kariyer planlaması, eğitimle desteklenir.",
        "Kamu görevlileri, görevlerinde yükselmek için gerekli eğitimleri alırlar.",
        "Kamu görevlilerinin yurt içi ve yurt dışı eğitim imkanları mevcuttur.",
        "Kamu görevlileri, eğitim ihtiyaçlarına göre kurs ve seminerlere katılabilir.",
        "Kamu görevlilerinin eğitimleri, performans değerlendirmeleriyle ilişkilidir.",
        "Kamu görevlileri, meslek içi uzmanlık eğitimlerine tabi tutulabilir.",
        "Kamu görevlilerinin eğitimi, liyakat esasına dayanır.",
        "Kamu görevlileri, bilgi ve becerilerini artırmak için sürekli eğitim alırlar."
      ]
    },
    {
      "title": "Kamu Yönetiminde Etik Kurallar",
      "details": [
        "Kamu yönetiminde etik kurallar, kamu görevlilerinin uyması gereken ahlaki normları belirler.",
        "Etik kurallar, kamu görevlilerinin tarafsız ve adil olmasını gerektirir.",
        "Kamu görevlileri, etik kurallara uygun davranmak zorundadır.",
        "Etik kurallar, kamu görevlilerinin dürüstlük ilkesine uygun hareket etmesini sağlar.",
        "Kamu yönetiminde etik, kamu hizmetinin kalitesini artırır.",
        "Etik kurallar, kamu görevlilerinin çıkar çatışmalarını önlemeyi amaçlar.",
        "Kamu görevlileri, etik dışı davranışlardan kaçınmalıdır.",
        "Etik kurallara aykırı davranışlar, disiplin cezalarını gerektirebilir.",
        "Kamu görevlileri, etik kurallara uygun hareket ederek vatandaşlara örnek olmalıdır.",
        "Etik kurallar, kamu hizmetinde şeffaflığı artırır."
      ]
    },
    {
      "title": "Kamu Yönetiminde Liyakat Sistemi",
      "details": [
        "Liyakat sistemi, kamu görevlilerinin yeteneklerine ve performanslarına göre terfi etmelerini sağlar.",
        "Liyakat, kamu yönetiminde adaletin sağlanması açısından önemlidir.",
        "Liyakat sistemine göre atamalar, objektif kriterlere dayanır.",
        "Kamu görevlilerinin terfisi, liyakat esasına göre yapılır.",
        "Liyakat sistemi, kamu hizmetlerinin kalitesini artırır.",
        "Liyakat, kamu görevlilerinin motivasyonunu yükseltir.",
        "Liyakat sistemi, kamu yönetiminde etkinliği artırır.",
        "Kamu görevlilerinin yetenekleri ve becerileri, liyakat sistemine göre değerlendirilir.",
        "Liyakat sistemi, kamu görevlilerinin kariyer planlamasında etkili bir rol oynar.",
        "Liyakat, kamu yönetiminde verimliliği artırır."
      ]
    },
    {
      "title": "Kamu Yönetiminde Denetim ve Sorumluluk",
      "details": [
        "Kamu yönetiminde denetim, kamu hizmetlerinin kalitesini artırmayı amaçlar.",
        "Denetim, kamu görevlilerinin görevlerini mevzuata uygun olarak yerine getirmelerini sağlar.",
        "Denetim, kamu hizmetlerinin şeffaflığını artırır.",
        "Kamu görevlileri, denetim mekanizmalarına tabidir.",
        "Denetim raporları, kamu hizmetlerinin iyileştirilmesi için kullanılır.",
        "Kamu görevlileri, görevlerini ihmal ettiklerinde sorumluluk taşırlar.",
        "Denetim, kamu yönetiminde hesap verebilirliği sağlar.",
        "Kamu yönetiminde denetim, hizmet kalitesini artırır.",
        "Denetim, kamu görevlilerinin etik dışı davranışlarını önlemeyi amaçlar.",
        "Kamu görevlileri, denetim sonuçlarına göre sorumluluk taşırlar."
      ]
    },
    {
      "title": "Kamu Yönetiminde Şeffaflık ve Hesap Verebilirlik",
      "details": [
        "Şeffaflık, kamu yönetiminde bilgiye erişimin kolaylaştırılmasını ifade eder.",
        "Hesap verebilirlik, kamu görevlilerinin yaptıkları işlerden sorumlu tutulmasını sağlar.",
        "Şeffaflık, kamu yönetiminde vatandaşların güvenini artırır.",
        "Kamu görevlileri, yaptıkları işlerden dolayı hesap vermekle yükümlüdür.",
        "Şeffaflık, kamu yönetiminde yolsuzluğun önlenmesine yardımcı olur.",
        "Hesap verebilirlik, kamu görevlilerinin sorumluluk duygusunu artırır.",
        "Şeffaflık, kamu hizmetlerinde vatandaşların bilgiye erişimini kolaylaştırır.",
        "Hesap verebilirlik, kamu görevlilerinin etik davranmasını teşvik eder.",
        "Şeffaflık, kamu yönetiminde etkinliği artırır.",
        "Hesap verebilirlik, kamu yönetiminde denetimin etkinliğini artırır."
      ]
    },
  ];

  late List<List<bool>> _selectedDetails;

  @override
  void initState() {
    super.initState();
    _initializeSelectedDetails();
    _loadSelectedDetails();
  }

  Future<void> _initializeSelectedDetails() async {
    _selectedDetails = List.generate(topics.length, (index) {
      return List.generate(topics[index]['details'].length, (i) => false);
    });
  }

  Future<void> _loadSelectedDetails() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? savedDetails = prefs.getStringList('selected_details');
    if (savedDetails != null) {
      setState(() {
        for (var item in savedDetails) {
          final indices = item.split('_');
          final topicIndex = int.parse(indices[0]);
          final detailIndex = int.parse(indices[1]);
          _selectedDetails[topicIndex][detailIndex] = true;
        }
      });
    }
  }

  Future<void> _saveSelectedDetails() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> savedDetails = [];
    for (int i = 0; i < _selectedDetails.length; i++) {
      for (int j = 0; j < _selectedDetails[i].length; j++) {
        if (_selectedDetails[i][j]) {
          savedDetails.add('${i}_$j');
        }
      }
    }
    await prefs.setStringList('selected_details', savedDetails);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B1B1B), // Dark background
      appBar: AppBar(
        backgroundColor: const Color(0xFF1B1B1B), // Dark AppBar
        elevation: 0.0, // Remove shadow effect
        title: const Text(
          'Kamu Görevlileri Yasası Bilgileri',
          style: TextStyle(color: Colors.white), // White text for contrast
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white), // White icons
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: topics.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: const Color(
                        0xFF2E2E2E), // Slightly lighter dark grey card
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 5,
                    child: ExpansionTile(
                      backgroundColor:
                          const Color(0xFF2E2E2E), // Match card background
                      title: Text(
                        topics[index]['title']!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.white, // White text for title
                        ),
                      ),
                      children:
                          List.generate(topics[index]['details'].length, (i) {
                        return ListTile(
                          title: Text(
                            topics[index]['details'][i],
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey[300], // Lighter text color
                              decoration: _selectedDetails.isNotEmpty &&
                                      _selectedDetails[index][i]
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              _selectedDetails[index][i] =
                                  !_selectedDetails[index][i];
                              _saveSelectedDetails();
                            });
                          },
                        );
                      }),
                    ),
                  );
                },
              ),
            ),
            const Padding(
              padding:
                  EdgeInsets.only(bottom: 25.0, left: 10, right: 10, top: 15),
            ),
          ],
        ),
      ),
    );
  }
}

class TopicDetailScreen extends StatelessWidget {
  final String title;
  final String detail;

  const TopicDetailScreen(
      {required this.title, required this.detail, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: const Color(0xFF1B1B1B), // Dark AppBar
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          detail,
          style:
              const TextStyle(color: Colors.white), // White text for contrast
        ),
      ),
      backgroundColor:
          const Color(0xFF1B1B1B), // Dark background for detail screen
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: KamuYasasiInfos(),
  ));
}
