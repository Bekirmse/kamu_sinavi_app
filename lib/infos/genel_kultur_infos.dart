import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GenelKulturInfos extends StatefulWidget {
  const GenelKulturInfos({super.key, required String title});

  @override
  // ignore: library_private_types_in_public_api
  _GenelKulturInfosState createState() => _GenelKulturInfosState();
}

class _GenelKulturInfosState extends State<GenelKulturInfos> {
  final List<Map<String, dynamic>> topics = [
    {
      "title": "Meclis ve Siyasi Yapı",
      "details": [
        "Cumhuriyet Meclisinde 50 milletvekili bulunmaktadır.",
        "Kıbrıs Türk Federe Devleti 1975 yılında kurulmuştur.",
        "Kuzey Kıbrıs Türk Cumhuriyeti, 15 Kasım 1983 tarihinde ilan edilmiştir.",
        "İlk KKTC Cumhuriyet Meclisi Milletvekilliği seçimleri 23 Haziran 1985 tarihinde yapılmıştır.",
        "Yeni Belediyeler reformunda KKTC'de toplam 18 belediye bulunmaktadır.",
        "Güvenlik Kuvvetleri Komutanlığı 1 Ağustos 1976 tarihinde kurulmuştur.",
        "TMT (Türk Mukavemet Teşkilatı) 1 Ağustos 1958 tarihinde kurulmuştur.",
        "KKTC’de toplam 6 ilçe bulunmaktadır.",
        "1983 yılında Cumhuriyet Meclisinde 70 milletvekili bulunmaktaydı.",
        "Kıbrıs 'Kavanın Meclisinde' üye sayıları 3 Türk, 6 İngiliz ve 9 Rum olarak belirlenmiştir.",
        "Kıbrıs Türk Kurumları Federasyonu, Türk kurum ve kuruluşlarının bir araya gelerek oluşturduğu üst kuruldur.",
        "Türk Mukavemet Teşkilatı'nın ilk lideri Albay Ali Rıza Vuruşkan'dır.",
        "KKTC’nin ilk Türkiye Büyükelçisi Ünal Batu'dur.",
        "Osmanlı Devleti’nin anayasası 'Kanun-i Esasi' olarak adlandırılır.",
        "KKTC’yi ilan eden meclisin adı 'Kurucu Meclis'tir.",
        "İlk Türk siyasi partisi KATAK (Kıbrıs Adası Türk Azınlığı Kurumu) olarak bilinir.",
        "AB dönem başkanı 2023 itibarıyla İsveç'tir.",
        "AB Komisyonu başkanı Ursula von der Leyen'dir.",
        "Avrupa Birliği'ne katılan en son ülke Hırvatistan'dır.",
        "İlk Kadın Cumhuriyet Meclis Başkan Yardımcısı Fazilet Özdenefe'dir."
      ]
    },
    {
      "title": "Coğrafya ve Doğal Yapı",
      "details": [
        "Kıbrıs’ın en doğu ucunun adı Zafer Burnu'dur.",
        "Kıbrıs’ın en batı ucunun adı Arnavut Burnu'dur.",
        "Kıbrıs’ın en yüksek tepesinin adı Olimpus'tur.",
        "Girne Dağlarının en yüksek tepesinin adı Birkan Uzun Tepesi'dir.",
        "KKTC’nin yüzölçümü 3242 km²'dir.",
        "Kıbrıs’ın yüzölçümü 9251 km²'dir.",
        "Kıbrıs, Akdeniz'in kuzey doğusunda yer alır.",
        "Kıbrıs’ın yüzey şekilleri 5 ana kategoriye ayrılmaktadır.",
        "KKTC’de en çok üretilen kuru tarım ürünü arpadır.",
        "Kıbrıs’ın en güneyindeki yerin adı Doğan Burnu'dur.",
        "Kıbrıs’ın en uzun akarsuyu Kanlıdere'dir.",
        "Kıbrıs’ın en yüksek ikinci tepesinin adı Bufavento Zirvesi'dir.",
        "Kuzey Kıbrıs’ın en yüksek noktası Birkan Uzun Tepesi'dir.",
        "Troodos Dağlarının en yüksek tepesinin adı Karlıdağ'dır.",
        "Kıbrıs’ın yüzölçümü 9251 km²'dir.",
        "Kıbrıs'ın komşuları arasında Türkiye, Suriye, Lübnan, İsrail, Mısır ve Yunanistan bulunur.",
        "Kıbrıs’ta en yaygın bitki örtüsü Maki'dir.",
        "KKTC'de çilek en çok Yeşilırmak'ta yetiştirilir.",
        "Kıbrıs’ın kuzeyinde en fazla yağış alan yer Girne Dağları ve Karpaz Dağları kuzey yamaçlarıdır."
      ]
    },
    {
      "title": "Tarih ve Kültür",
      "details": [
        "Osmanlılar Kıbrıs’ı 1878 yılında İngilizlere devretmiştir.",
        "Kıbrıs Türk Federe Devleti 1975 yılında kurulmuştur.",
        "Kuzey Kıbrıs Türk Cumhuriyeti, 15 Kasım 1983 tarihinde ilan edilmiştir.",
        "İlk KKTC Cumhuriyet Meclisi Milletvekilliği seçimleri 23 Haziran 1985 tarihinde yapılmıştır.",
        "İlk Türk siyasi partisi KATAK (Kıbrıs Adası Türk Azınlığı Kurumu) olarak bilinir.",
        "Osmanlı Devleti’nin anayasası 'Kanun-i Esasi' olarak adlandırılır.",
        "KKTC’yi ilan eden meclisin adı 'Kurucu Meclis'tir.",
        "Kıbrıs Cumhuriyeti’nin ilk Cumhurbaşkanı Makarios'tur.",
        "Dr. Fazıl Küçük’ün çıkardığı gazetenin ismi 'Halkın Sesi'dir.",
        "Türklerin EOKA’ya karşı kurdukları ilk örgütün adı 'Volkan'dır.",
        "Kıbrıs’ın ilk gazetesi 'Kipros/Kıbrıs' olarak bilinir.",
        "Kıbrıs’ta ilk matbaa 1878 yılında İngilizler tarafından kurulmuştur.",
        "Lüzinyanlar tarafından yapılan Othello Kalesi, Kıbrıs’taki önemli tarihi yapılardan biridir.",
        "Lala Mustafa Paşa Camii, Lüzinyanlar tarafından yapılmıştır.",
        "Kıbrıs’a adını veren maden bakırdır.",
        "Kıbrıs’ın Osmanlılar tarafından alınması sırasında Osmanlı sadrazamı Sokullu Mehmet Paşa'dır.",
        "Kıbrıs’ta Dragoman, Osmanlı döneminde Vali’nin tercümanına verilen isimdir.",
        "Kıbrıs’ta İngiliz sömürge döneminde bataklıkları kurutmak amacıyla getirilen ağaç türü okaliptustur.",
        "Kıbrıs Adası’nda en yaygın görülen yağış tipi cephe yağışıdır."
      ]
    },
    {
      "title": "Ekonomi ve Tarım",
      "details": [
        "KKTC’de en çok üretilen kuru tarım ürünü arpadır.",
        "KKTC'de patates en çok Beyarmudu'nda yetiştirilir.",
        "KKTC'de çilek en çok Yeşilırmak'ta yetiştirilir.",
        "KKTC'de zeytin en çok Değirmenlik'te yetiştirilir.",
        "KKTC'de sulu ziraat en çok Güzelyurt ve Mehmetçik'te yapılır.",
        "KKTC’nin en büyük yer altı su kaynağı Güzelyurt Aküferi'dir.",
        "Kıbrıs’ta en yaygın görülen yağış tipi cephe yağışıdır.",
        "Kıbrıs Adası’nda 3 çeşit yağış tipi vardır.",
        "Kıbrıs’ta en yaygın bitki örtüsü Maki'dir.",
        "KKTC’de narenciye en çok Güzelyurt'ta üretilir.",
        "KKTC’de üzüm en çok Mehmetçik'te yetiştirilir.",
        "KKTC’de harup en çok Gazimağusa ve İskele'de yetiştirilir.",
        "Kıbrıs’ta zeytin en çok Değirmenlik'te yetiştirilir.",
        "Kıbrıs’ta çilek ve muz Yeşilırmak ve Yedidalga'da yetiştirilir.",
        "KKTC’de pamuk en zor yetişen bitkidir.",
        "KKTC’de elektrik santralleri toplam 3 adettir.",
        "KKTC petrol dolum tesisleri Kalecik'te bulunmaktadır."
      ]
    },
    {
      "title": "Eğitim ve Bilim",
      "details": [
        "KKTC’de yükseköğretimden sorumlu üst kurul YÖDAK'tır.",
        "DAÜ (Doğu Akdeniz Üniversitesi) 1979 yılında kurulmuştur.",
        "Lefkoşa’da açılan iki yeni lise Esin Leman Lisesi ve Metin ve Vedat Ertüngü Lisesi'dir.",
        "Bayrak Radyosu ilk deneme yayınına 25 Aralık 1963'te başlamıştır.",
        "Kıbrıs’taki ilk Türkçe gazetenin adı Saaded'dir.",
        "Kıbrıs Türk Belediyeler Birliği 1983 yılında kurulmuştur.",
        "Kıbrıs’ın Osmanlı döneminde ilk Türk Cemaat Meclisi Başkanı Rauf Raif Denktaş'tır.",
        "Kıbrıs Cumhuriyeti’nin ilk Cumhurbaşkanı yardımcısı Dr. Fazıl Küçük'tür.",
        "Kıbrıs’ta eğitim müdürlüğü İngilizler tarafından 1880 yılında kurulmuştur."
      ]
    },
    {
      "title": "Diğer Bilgiler",
      "details": [
        "Kıbrıs’taki Lefkoşa surlarında toplam 11 adet burç vardır.",
        "Kıbrıs’ta Maronitler Koruçam’da yaşar.",
        "Kıbrıs’ın en uzun akarsuyu Kanlıdere'dir.",
        "KKTC’nin en büyük limanı Gazimağusa Limanı'dır.",
        "Kıbrıs’a su getirmek amacı ile inşa edilen baraj Geçitköy Barajı'dır.",
        "Kıbrıs’ta İngilizler tarafından açılan ilk demiryolu hattı Lefke-Mağusa arasında yolcu ve yük taşımıştır.",
        "Kıbrıs’taki Ledra Palace sınır kapısı 23 Nisan 2003'te açılmıştır.",
        "Kıbrıs'a 1964 yılında Birleşmiş Milletler Barış Gücü gelmiştir.",
        "Kıbrıs Cumhuriyeti’nin ilk Cumhurbaşkanı Makarios'tur.",
        "Kıbrıs Cumhuriyeti’nin ilk Cumhurbaşkanı yardımcısı Dr. Fazıl Küçük'tür.",
        "Kıbrıs’taki Akdeniz bitki örtüsü Maki olarak adlandırılır.",
        "Kıbrıs Adası’ndaki en büyük geçitlerden biri Girne Boğazı'dır.",
        "Kıbrıs Adası’nda en yaygın görülen sıcak ve nemli hava kütlesi ile soğuk havanın karşılaşması sonucu oluşan yağış cephe yağışıdır.",
        "KKTC’de pamuk en zor yetişen bitkidir.",
        "Salamis Harabeleri Gazimağusa sınırları içinde yer almaktadır.",
        "Yeşil hattı BM Barış Gücü korur.",
        "Fenikeliler Kıbrıs’a Lübnan’dan gelmiştir.",
        "Kıbrıs’taki Roma döneminde başkent Baf olarak belirlenmiştir.",
        "Kıbrıs’ta ilk Türk alayı komutanı Turgut Sunalp'tır.",
        "KKTC’nin en küçük göleti Gönendere göletidir."
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
        backgroundColor:
            const Color(0xFF1B1B1B), // Dark AppBar matching the background
        elevation: 0.0, // Remove elevation to avoid shadow effect
        title: const Text(
          'Genel Kültür Bilgileri',
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
