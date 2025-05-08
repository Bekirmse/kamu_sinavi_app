import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IyiIdareYasasiInfos extends StatefulWidget {
  const IyiIdareYasasiInfos({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _IyiIdareYasasiInfosState createState() => _IyiIdareYasasiInfosState();
}

class _IyiIdareYasasiInfosState extends State<IyiIdareYasasiInfos> {
  final List<Map<String, dynamic>> topics = [
    {
      "title": "İyi İdarenin İlkeleri",
      "details": [
        "Hukuka Uygun Davranma Yükümlülüğü",
        "Eşitlik İlkesi ve Ayrımcılık Yasağı",
        "Tarafsızlık İlkesi",
        "Orantılılık İlkesi",
        "Hukuki Kesinlik ve Kazanılmış Haklara Saygı İlkesi",
        "Makul Süre İçinde Faaliyette Bulunma İlkesi",
        "Katılım İlkesi",
        "Özel Hayatın Gizliliğine Saygı İlkesi",
        "Açıklık İlkesi"
      ]
    },
    {
      "title": "İyi İdare Yasası",
      "details": [
        "İyi İdare Yasası'nın amacı, özel kişileri kamu gücü ayrıcalıklarını kullanma yetkisine sahip idareye karşı korumak ve bu kişilerin idari işlem, eylem ve ihmallere karşı başvurabilecekleri hukuki yolları düzenlemektir."
      ]
    },
    {
      "title": "Hukuka Uygun Davranma Yükümlülüğü",
      "details": [
        "İdare, Anayasaya ve yasalara uygun faaliyette bulunur. İdare ayrıca tüzüklere, yönetmeliklere ve diğer düzenleyici işlemlere de uygun davranma yükümlülüğü altındadır.",
        "İdare, yetkilerini kamu yararı amacına uygun biçimde kullanabilir. İdareye mevzuatta tanınan takdir yetkisi, keyfi karar alma olanağı vermez."
      ]
    },
    {
      "title": "Eşitlik İlkesi ve Ayrımcılık Yasağı",
      "details": [
        "İdare, eşitlik ilkesine ve ayrımcılık yasağına uygun davranmakla yükümlüdür.",
        "İdare, din, dil, ırk, renk, cinsiyet, cinsel yönelim, cinsiyet kimliği, siyasi ve felsefi düşünce, mezhep, etnik köken, doğum yeri veya başka herhangi bir sebeple ayrımcılık yapamaz."
      ]
    },
    {
      "title": "Tarafsızlık İlkesi",
      "details": [
        "İdare, eylem ve işlemlerinde tarafsız ve nesnel davranma yükümlülüğü altındadır.",
        "İdare, görevlilerinin faaliyetlerini kişisel inanç ve çıkarlarından bağımsız olarak tarafsız biçimde yerine getirmelerini sağlar."
      ]
    },
    {
      "title": "Orantılılık İlkesi",
      "details": [
        "İdare, orantılılık ilkesine uygun faaliyette bulunur.",
        "İdare, özel kişilerin hak ve çıkarlarını etkileyen önlemlere ancak gerekli olduğunda ve amacın gerektirdiği ölçüde başvurur.",
        "İdare, takdir yetkisi kullandığında kararının özel kişilerin hak ve çıkarları üzerinde yaratacağı her türlü olumsuz etki ile takip edilen amaç arasında uygun bir denge bulunmasını gözetir."
      ]
    },
    {
      "title": "Hukuki Kesinlik ve Kazanılmış Haklara Saygı İlkesi",
      "details": [
        "İdare, idari işlemlerini kazanılmış hakları ihlal edecek biçimde geri yürütemez.",
        "Özel kişilere yeni yükümlülükler getiren düzenlemeler söz konusu olduğunda kamu yararı ve kamu hizmetinin gerekleri aksini zorunlu kılmıyorsa düzenlemenin yürürlüğü ertelenir veya geçiş kuralları getirilir."
      ]
    },
    {
      "title": "Makul Süre İçinde Faaliyette Bulunma İlkesi",
      "details": ["İdare, yükümlülüklerini makul süre içinde yerine getirir."]
    },
    {
      "title": "Katılım İlkesi",
      "details": [
        "İdare, özel kişilere hak ve çıkarlarını etkileyen idari işlemlerin hazırlığına ve uygulanmasının denetlenmesine uygun araçlarla katılma olanağı tanır.",
        "Çevre ve imarla ilgili konularda ilgili bölgede ikamet eden özel kişilerin tamamına açık danışma toplantıları düzenlenmeden idari işlem yapılamaz."
      ]
    },
    {
      "title": "Özel Hayatın Gizliliğine Saygı İlkesi",
      "details": [
        "İdare, kişisel verilerin işlenmesinde özel hayatın gizliliği ilkesine uyar.",
        "İdare, kişisel veri ve dosyaların özellikle elektronik ortamda işlenmesi yetkisi bulunduğunda özel hayatın gizliliğini güvence altına alan tüm gerekli önlemleri alır.",
        "Kişisel verilerin korunmasına ilişkin kurallar, idare tarafından işlenen verilere de uygulanır."
      ]
    },
    {
      "title": "Açıklık İlkesi",
      "details": [
        "İdare, açıklık ilkesine uygun faaliyette bulunur.",
        "İdare, özel kişileri idari işlemlerinden Resmi belgelerin yayınlanması da dahil olabilecek şekilde uygun araçlarla haberdar eder.",
        "İdare, işlemden doğrudan doğruya etkilenecek özel kişilere işlemi tebliğ etmekle yükümlüdür."
      ]
    },
    {
      "title": "Özel Kişilerin İstemleri",
      "details": [
        "Özel kişiler, kendileri veya kamu ile dilek ve şikayetleri hakkında tek başına veya topluca yetkili makamlara yazı ile başvurma ve idareden yetkisi içindeki bir konuda birel işlem yapmasını isteme hakkına sahiptir.",
        "İdare, kendisine yazı ile başvuran kişi ya da kişilere üzerinde tarih bulunan bir alındı belgesi verir.",
        "İstem yetkili olmayan bir idareye yöneltilirse, istem beş iş günü içerisinde yetkili makama iletilir ve istem sahibine durum yazılı olarak bildirilir.",
        "İdare, istemle ilgili kararını en geç otuz gün içinde gerekçeli olarak başvuran kişiye yazılı olarak bildirir."
      ]
    },
    {
      "title": "Birel İşlemlerde Özel Kişilerin Dinlenilme Hakkı",
      "details": [
        "İdare, birel işlem yapmadan önce yaptığı işlemden hakları etkilenecek olan özel kişilere dinlenilme hakkı tanır.",
        "Özel kişiler bu haklarını kullanırken yanlarında avukat bulundurma hakkına sahiptirler."
      ]
    },
    {
      "title": "İdari İşlemlerin Şekli",
      "details": [
        "İdari işlemler basit, açık ve anlaşılır bir dille ve gerekçeli olarak yazılır.",
        "Yasalarda açıkça belirlenen durumlar dışında idare sözlü idari işlem yapamaz.",
        "İdare, işlemden doğrudan doğruya etkilenecek özel kişilere tebligatlarında kararına karşı hangi süreler içinde hangi hukuki yollara başvurulabileceğini belirtir."
      ]
    },
    {
      "title": "Birel İdari İşlemlerin Geri Alınması",
      "details": [
        "İdare, hukuka aykırı birel idari işlemlerini başvuru üzerine ya da kendiliğinden geri alır.",
        "Yok hükmündeki, hile ile yapılan ve yükümlendirici birel işlemler hariç hukuka aykırı kazandırıcı bir birel işlem tebliğ edildiği tarihten itibaren yetmiş beş gün geçtikten sonra geri alınamaz."
      ]
    },
    {
      "title": "İdari İşlemlere Karşı İptal Davası Açılması",
      "details": [
        "İdarenin birel işlemlerine ve düzenleyici işlemlerine karşı meşru menfaatleri olumsuz yönde ve doğrudan doğruya etkilenen kişiler tarafından bu işlemlerin öğrenilmesinden itibaren yetmiş beş gün içerisinde iptal davası açılabilir.",
        "Resmi Gazete’de yayımlanan düzenleyici işlemlerde öğrenme tarihi Resmi Gazete’de yayım tarihidir.",
        "Düzenleyici işlemin uygulanması üzerine meşru menfaati olumsuz yönde etkilenen kişi, uygulama işlemini öğrenme tarihinden itibaren yetmiş beş gün içerisinde hem uygulama işlemin hem de düzenleyici işlemin iptali için dava açabilir."
      ]
    },
    {
      "title": "İdari İhmallere Karşı İhmalin Sonlandırılması Davası Açılması",
      "details": [
        "İdarenin idari ihmallerine karşı meşru menfaatleri olumsuz yönde ve doğrudan doğruya etkilenen kişiler tarafından ihmalin öğrenilmesinden itibaren yetmiş beş gün içerisinde ihmalin sonlandırılması davası açılabilir."
      ]
    },
    {
      "title": "İdari İşlemlere Karşı Dava Açmadan Önce İdareye Başvurulması",
      "details": [
        "Özel kişiler, idari dava açmadan önce idari işlemin kaldırılması, geri alınması veya yeni bir işlem yapılması, gerekçesiz işlemin gerekçesinin bildirilmesi ya da idari ihmalin sonlandırılması talebiyle üst makama başvurabilirler.",
        "Üst makam varken, kararı vermiş olan makama yapılan başvurular, kararı vermiş olan makam tarafından üst makama iletilir.",
        "Başvuru, dava açma süresini durdurur. Başvurulan makam talebi reddeder ya da otuz gün içinde bir yanıt vermezse, dava açma süresi kaldığı yerden işlemeye devam eder."
      ]
    },
    {
      "title": "Mali Sorumluluk",
      "details": [
        "İdare, kendi işlem, ihmal ve eylemlerinden doğan zararı gidermekle yükümlüdür.",
        "İdare, zarar görenin zararını giderdikten sonra kusurlu işlem ya da eylemiyle zararın doğmasına sebebiyet veren kamu personeline mahkeme tarafından tespit edilen kusur oranında rücu eder."
      ]
    },
    {
      "title": "Yargı Kararlarına Uyma Zorunluluğu",
      "details": [
        "İdare, yargı kararlarının gereklerini en geç otuz gün içerisinde yerine getirir.",
        "Yargı kararlarının gereklerini yerine getirmeyen idare, bundan doğacak zararı gidermekle yükümlüdür.",
        "İdare, zarar görenin zararını giderdikten sonra kusurlu işlem ya da eylemiyle zararın doğmasına sebebiyet veren kamu personeline mahkeme tarafından tespit edilen kusur oranında rücu eder.",
        "Yargı kararlarını kasten yerine getirmeyen kamu personeline karşı, bundan doğan zararın giderilmesi istemiyle tazminat davası açılabilir."
      ]
    },
    {
      "title": "Yürütme",
      "details": ["İYİ İDARE YASASI'nı Bakanlar Kurulu yürütür."]
    },
    {
      "title": "Yürürlüğe Giriş",
      "details": [
        "İYİ İDARE Yasası, Resmi Gazete’de yayımlandığı tarihten iki ay sonra yürürlüğe girer."
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
          'İyi İdare Yasası Bilgileri',
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
        backgroundColor:
            const Color(0xFF1B1B1B), // Dark AppBar matching background
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
    home: IyiIdareYasasiInfos(),
  ));
}
