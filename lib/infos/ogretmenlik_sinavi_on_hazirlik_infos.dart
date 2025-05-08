import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OgretmenlikSinaviOnHazirlikInfos extends StatefulWidget {
  const OgretmenlikSinaviOnHazirlikInfos({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OgretmenlikSinaviOnHazirlikInfosState createState() =>
      _OgretmenlikSinaviOnHazirlikInfosState();
}

class _OgretmenlikSinaviOnHazirlikInfosState
    extends State<OgretmenlikSinaviOnHazirlikInfos> {
  final List<Map<String, dynamic>> topics = [
    {
      "title": "Hukuk ve Yönetim",
      "details": [
        "Bütçe yasa tasarısı Cumhurbaşkanı tarafından yayımlanır.",
        "Yasa değişikliği Cumhurbaşkanı tarafından yayımlanır.",
        "Dernek Kurma Hakkı sosyal bir hak değildir.",
        "Devletin mali denetim organı Sayıştay'dır.",
        "Temel Hak ve Özgürlükleri kısıtlama nedenlerinden biri Kamu güvenliği değildir.",
        "Cumhurbaşkanı, Başbakan ve Bakanlar Yüce Divan'da yargılanır.",
        "Olağanüstü hal durumunu 2 ay uzatmak için 9 milletvekili yeterli değildir.",
        "Vergi ile ilgili değişiklik yapmaya Bakanlar Kurulu yetkilidir.",
        "Kamu hizmeti niteliği taşıyan özel girişimler devletleştirme ile ilgili koşullarda kamu yararına kullanılır.",
        "Seçimler ve Halkoylaması ilkelerinden olan üç madde şunlardır: Özel oy, Açık sayım, Döküm.",
        "Siyasi partilerin tüzüklerini Başsavcı denetler.",
        "Başbakan, Bakanlar Kurulunun programından ve uygulanmasından sorumlu değildir.",
        "Eşitlik değiştirilemez ifadelerden biri değildir.",
        "Hayat ve Vücut Bütünlüğü, kimsenin hayatına son verilemez.",
        "Cumhuriyet Meclisi seçimlerinin ertelenebilmesi için üye tamsayısının üçte ikisi gerekir.",
        "Yasa gücünde kararname ekonomi durumlarında çıkarılır."
      ]
    },
    {
      "title": "Eğitim ve Öğretmenler",
      "details": [
        "120 öğrencisi olan bir ilkokulda olanaklar ölçüsünde 4 öğretmen bulunur.",
        "1 Eylül'de kademe ilerlemesi alan bir öğretmen, kısa süreli durdurma cezası alırsa bir sonraki kademe ilerlemesini 1 Mart'ta alır.",
        "Aday öğretmenlikte adaylık süresi en az 2 yıl, en çok 3 yıl olur.",
        "İlkokulda görevli öğretmenin haftalık ders saati 22 saattir.",
        "Öğretmenlerin haklarından biri Dilekçe hakkı değildir.",
        "Öğretmenlere en fazla 5 yıl izin verilebilir.",
        "Veraset yoluyla intikal eden hisseler 3 ay içerisinde elden çıkarılmalıdır.",
        "Okul etkinlikleri Bakanlıkça sendika ile iştişareden sonra genelgeye uygun belirlenir.",
        "İzinsiz olarak 10 gün kesintisiz göreve gelmeyen öğretmene kademe ilerlemesinin uzun süreli durdurma cezası verilmelidir.",
        "Başsavcılık öğretmen hakkında disiplin işlemi yapılacağına karar verirse Bakanlığa ithamname gönderir.",
        "Kısa süreli kademe ilerlemesi cezasının sicil dosyasından silinmesi için en az 2.5 yıl geçmelidir.",
        "Öğretmen sicil dosyasında Değerlendirme raporları bulunur.",
        "Özel eğitim okulu öğretmeni haftalık ders saatinin üzerinde ders verirse %3 ek tahsilat ödeneği alır.",
        "Atölye şefi ve bölüm şefinin adaylık süresi 1 yıldır.",
        "Bakanlık Kuzey Kıbrıs Türk Cumhuriyeti sınırları dışında diğer ülkelere geçici görevlendirme yapmaz.",
        "Öğretmen olabilmek için Pedagoji sertifikasına sahip olmak gerekmemektedir.",
        "Saat başı esasına göre atanan emekli öğretmenin ödeneklerini Bakanlar Kurulu saptar.",
        "Başmuavin ve sorumlu öğretmen olmak için kıdem gereklidir.",
        "Pratik sanat okullarında bir atölye şefinin haftalık ders saati en az 8 saat, en çok 10 saattir.",
        "Öğretmenlerin haftalık ders saatlerinin %25'i kadar ek ders vermekle yükümlüdür.",
        "Sendikal izinler yükselme açısından dikkate alınmalıdır.",
        "Öğretmenlerin ikinci görev yapması yasaktır.",
        "Her öğretmenin yılda 42 gün hastalık izni vardır.",
        "Öğretmenin atanması, onaylanması, ödeneksiz izin vermek, sözleşmeli öğretmen görevlendirmek, mazaret izni onaylamak, göreve son vermek ve müdürün görevden çekilme yazısı alma KHK tarafından yapılmaktadır.",
        "Disiplin soruşturması 15 gün içinde ve Bakanlık tarafından tamamlanır."
      ]
    },
    {
      "title": "Tarih ve Coğrafya",
      "details": [
        "Girne Dağları üzerindeki tarihi kalelerin batıdan doğuya doğru sıralanışı: St. Hilarion - Bufavento - Kantara",
        "TMT'nin kuruluş tarihi 1 Ağustos 1958'dir.",
        "Kıbrıs adını bakırdan almıştır.",
        "Osmanlı'nın Kıbrıs'ı fethi sırasında en son fethedilen yer Mağusa'dır."
      ]
    },
    {
      "title": "Güncel Bilgiler",
      "details": ["Sağlık Bakanı Hakan Dinçyürek'tir."]
    },
    {
      "title": "Matematik ve Mantık",
      "details": [
        "Bir uçak, güney yönüne baktıktan sonra saat yönüne doğru 90 derece ve saatin tersine doğru 180 derece dönerse yeni yönü doğu olur.",
        "Tokyo'dan Çarşamba günü Tokyo saati ile 16:00'da havalanan bir uçak 8 saatlik uçuş sonrasında İstanbul'a Çarşamba günü 15:00'te iner.",
        "Ahmet ve Elif farklı projelerde çalışacaklardır.",
        "Faruk kelimesinin şifresi 65328'dir."
      ]
    }
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
          'Öğretmenlik Sınavı Ön Hazırlık Bilgileri',
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
    home: OgretmenlikSinaviOnHazirlikInfos(),
  ));
}
