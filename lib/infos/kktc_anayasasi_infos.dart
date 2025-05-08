import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KktcAnayasasiInfos extends StatefulWidget {
  const KktcAnayasasiInfos({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _KktcAnayasasiInfosState createState() => _KktcAnayasasiInfosState();
}

class _KktcAnayasasiInfosState extends State<KktcAnayasasiInfos> {
  final List<Map<String, dynamic>> topics = [
    {
      'title': 'Anayasa Maddeleri ve Değiştirilebilirlik',
      'details': [
        "Aşağıdaki maddelerden hangisi değiştirilebilir veya değiştirilmesi önerilebilir? Cevap: Cumhuriyet'in Başkenti Lefkoşa'dır.",
        "Aşağıdaki maddelerden hangisi değiştirilebilir veya değiştirilmesi önerilebilir? Cevap: Yargı yetkisi, KKTC halkı adına bağımsız mahkemelerce kullanılır.",
        "Aşağıdaki maddelerden hangisi değiştirilemez veya değiştirilmesi önerilemez? Cevap: Halk egemenliğini, Anayasa'nın koyduğu ilkeler çerçevesinde, yetkili organları eliyle kullanır.",
        "Yukarıda verilen maddelerden hangileri değiştirilemez veya değiştirilmesi önerilemez? Cevap: II-III",
        "Anayasada öngörülen aşağıdaki hükümlerin hangisi değiştirilebilir? Cevap: Cumhuriyet'in Başkenti Lefkoşa'dır."
      ]
    },
    {
      "title": "Yasama, Yürütme ve Yargı Yetkileri",
      "details": [
        "Yasama yetkisi kime aittir? Cevap: Cumhuriyet Meclisi",
        "Yargı yetkisi kime aittir? Cevap: Bağımsız Mahkemeler",
        "Yürütme yetkisi kime aittir? Cevap: Cumhurbaşkanı ve Bakanlar Kurulu",
        "KKTC'de yürütme yetkisi ve görevi aşağıdakilerden hangisi tarafından kullanılır? Cevap: Cumhurbaşkanı ve Bakanlar Kurulu"
      ]
    },
    {
      "title": "Temel Hak ve Özgürlükler",
      "details": [
        "Herkes; barış, güven ve huzur içinde yaşama, maddi ve manevi varlığını koruma ve geliştirme hakkına sahiptir. Bu madde anayasada hangi kapsamda yer alır? Cevap: Kişi dokunulmazlığı",
        "Kimseye eziyet ve işkence yapılamaz. Bu madde anayasada hangi kapsamda yer alır? Cevap: Kişi dokunulmazlığı",
        "Kimse insanlık onuruyla bağdaşmayan bir cezaya çarptırılamaz veya muameleye tabi tutulamaz. Bu madde anayasada hangi kapsamda yer alır? Cevap: Kişi dokunulmazlığı",
        "Kişinin şeref ve haysiyeti dokunulmazdır. Herkes buna saygı göstermek ve korumakla yükümlüdür. Bu madde anayasada hangi kapsamda yer alır? Cevap: Kişi dokunulmazlığı",
        "Yasanın ölüm cezası ile cezalandırdığı bir suçtan dolayı hakkında yetkili bir mahkemece verilen bir hüküm yerine getirilmesi dışında kimsenin hayatına son verilemez. Bu madde anayasada hangi kapsamda yer alır? Cevap: Hayat ve vücut bütünlüğü hakkı",
        "Herkes, hayat ve vücut bütünlüğü hakkına sahiptir. Bu madde anayasada hangi kapsamda yer alır? Cevap: Hayat ve vücut bütünlüğü hakkı",
        "Mahkeme kararı olmadıkça hiç kimsenin konutuna girilemez ve arama yapılamaz. Bu madde anayasada hangi özgürlük kapsamına girer? Cevap: Konut Dokunulmazlığı",
        "Anayasaya göre, 'Herkesin, barış, güven ve huzur içinde yaşama, maddi ve manevi varlığını koruma ve geliştirme hakkına sahip olması' aşağıdakilerden hangisini ifade eder? Cevap: Kişi dokunulmazlığını",
        "Aşağıdakilerden hangisi Anayasa'da kişiler için belirlenen özgürlüklerden değildir? Cevap: Gazete, Dergi, Broşür Çıkarma özgürlüğü",
        "Kimse, işlendiği zaman yasaca suç teşkil etmeyen bir eylem veya ihmâlden dolayı suçlanamaz. Herhangi bir suç için, işlendiği zaman yasaca o suç için konulmuş olan cezadan daha ağır bir ceza verilemez. Bu madde anayasada hangi kapsamda yer alır? Cevap: Cezaların yasal ve kişisel olması ve sanık hakları",
        "Hiçbir yasa, suçun ağırlığı ile orantılı olmayan bir ceza koyamaz. Bu madde anayasada hangi kapsamda yer alır? Cevap: Cezaların yasal ve kişisel olması ve sanık hakları",
        "Bir suçtan sanık herkes, suçluluğu yasal olarak kanıtlanana kadar suçsuz sayılır. Bu madde anayasada hangi kapsamda yer alır? Cevap: Cezaların yasal ve kişisel olması ve sanık hakları",
        "Bir suçtan dolayı beraat eden veya hüküm giyen bir kişi, aynı suçtan dolayı tekrar yargılanamaz. Kimse aynı eylem veya ihmâlden dolayı, bu eylem veya ihmâli oluşturan yeni bir yasayla suçlu sayılarak, daha önce işlenmiş bir eylemden dolayı cezalandırılamaz. Bu madde anayasada hangi kapsamda yer alır? Cevap: Cezaların yasal ve kişisel olması ve sanık hakları",
        "Yasanın açıkça gösterdiği durumlarda, usulüne göre verilmiş mahkeme veya yargı kararı olmadıkça, ulusal güvenlik ve kamu düzeni bakımından çekincede sakınca bulunan eşya ve belgeye yetkili kılınan mercii emri bulunmadıkça, kimse arama yapılamaz, özel eşyası aranamaz ve bunlara el konulamaz. Bu madde anayasada hangi kapsamda yer alır? Cevap: Özel hayatın gizliliği",
        "Her yurttaş, yurda girme ve çıkma özgürlüğüne sahiptir. Hiçbir yurttaş, isteği dışında Devlet sınırları dışında çıkarılamaz ve yurda girme hakkından yoksun bırakılamaz. Bu madde anayasada hangi kapsamda yer alır? Cevap: Gezi ve yerleşme özgürlüğü",
        "Kimse ibadete, dinsel ayin ve törenlere katılmaya, dini inanç ve kanaatlerini açıklamaya zorlanamaz ve dini inanç ve kanaatlerinden dolayı kınanamaz. Din eğitimi ve öğretimini Devletin gözetimi ve denetimi altında yapar. Bu madde anayasada hangi kapsamda yer alır? Cevap: Vicdan ve din özgürlüğü",
        "Herkes, düşünce ve kanaatlerini, söz, yazı, resim veya başka yollarla tek başına veya toplu olarak açıklama ve yayma hakkına sahiptir. Bu madde anayasada hangi kapsamda yer alır? Cevap: Düşünce, söz ve anlatım özgürlüğü",
        "Herkes, bilim ve sanatı serbestçe öğrenme ve öğretme, açıklama, yayma ve bu alanlarda her türlü araştırma yapma hakkına sahiptir. Bu madde anayasada hangi kapsamda yer alır? Cevap: Bilim ve sanat özgürlüğü",
        "Yurttaşlar için basın ve yayın özgürlüğü, sansür edilemez. Devlet, basın, yayın ve haber alma özgürlüğünü sağlayacak önlemleri alır. Bu madde anayasada hangi kapsamda yer alır? Cevap: Basın özgürlüğü",
        "Gazete, dergi ve broşür çıkarılması, her yurttaş için önceden izin alma ve mali güvence yatırma koşuluna bağlı tutulamaz. Bu madde anayasada hangi kapsamda yer alır? Cevap: Gazete, dergi ve broşür çıkarma hakkı",
        "Yetkili merci tarafından alınan gazete, dergi ve broşür toplatma ve yasaklama kararı mahkeme tarafından en geç kaç gün içinde onaylanmazsa geçersiz sayılır? Cevap: 2",
        "Kitap yayımı, yurttaşlar için izne bağlı tutulamaz, sansür edilemez. Bu madde anayasada hangi kapsamda yer alır? Cevap: Kitap çıkarma hakkı",
        "Yurttaşlara ait basımevi ve eklentileri ve basın araçları, suç aracı oldukları gerekçesiyle de olsa, zorla alınamaz veya el konulamaz ve işletilemez. Bu madde anayasada hangi kapsamda yer alır? Cevap: Basın araçlarının korunması",
        "Yurttaşlar ve siyasal partiler, kamu tüzel kişilerini elindeki basın dışı haberleşme ve yayın araçlarından yararlanma hakkına sahiptir. Bu madde anayasada hangi kapsamda yer alır? Cevap: Basın dışı haberleşme araçlarından yararlanma hakkı",
        "Düzeltme ve cevap hakkı başvurusunda bulunulduktan sonra yargıcın kaç gün içinde karar vermesi gerekmektedir? Cevap: 7",
        "Düzeltme ve cevap hakkı başvurusu reddedilirse, bu ret kararının en geç kaç gün içinde yargıç tarafından verilmesi gerekmektedir? Cevap: 7",
        "Yurttaşlar, önceden izin almaksızın, silahsız ve saldırısız toplanma veya gösteri yürüyüşü yapma hakkına sahiptir. Bu madde anayasada hangi kapsamda yer alır? Cevap: Toplantı ve gösteri yürüyüşü hakkı",
        "Yurttaşlar önceden izin almaksızın, dernek kurma hakkına sahiptir. Hiç kimse, herhangi bir derneğe üye olmaya veya herhangi bir dernekten üye olmaktan zorlanamaz. Bu madde anayasada hangi kapsamda yer alır? Cevap: Dernek kurma hakkı",
        "Kamu görevi ve hizmetinde bulunanlar, görevleriyle ilgili olarak yaptıkları ve görevlerini kötüye kullanmaları nedeniyle kamu zararına yol açan eylem ve işlemlerinden dolayı yargılanabilir. Bu madde anayasada hangi kapsamda yer alır? Cevap: İspat hakkı"
      ]
    },
    {
      "title": "Aile, Mülkiyet ve Çevre Hakları",
      "details": [
        "Evlenme çağındaki bir kadın ile bir erkeğin, evlenip aile yuvası kurma hak ve yükümlülükleri yasal ile düzenlenir. Bu madde anayasada hangi kapsamda yer alır? Cevap: Ailenin korunması",
        "Her yurttaş, mülkiyet ve miras haklarına sahiptir. Bu haklar, kamu yararı amacıyla ve yasa ile sınırlandırılabilir. Bu madde anayasada hangi kapsamda yer alır? Cevap: Mülkiyet hakkı",
        "Devlet, toprağın verimli olarak işlenmesini gerçekleştirir ve topraksız olan veya yeter toprak bulamayan çiftçiye toprak sağlamak amaçlarıyla gereken önlemleri alır. Bu madde anayasada hangi kapsamda yer alır? Cevap: Toprağın korunması",
        "Kıyılar, Devletin hüküm ve tasarrufu altında olup, herkesin eşit yararlanmasına açıktır ve kıyılarla ilgili kararlar yasa ile belirlenir. Bu madde anayasada hangi kapsamda yer alır? Cevap: Kıyıların korunması",
        "Ulusal güvenlik, kamu düzeni, kamu yararı, genel sağlık ve çevre korunması gibi nedenlerle yasa ile sınırlamalar konulabilir. Yurt dışında yaşayan yurttaşların, kıyı şeridinden belirli bir genişlikte olan kısmına girmesi engellenemez ve giriş ücreti alınamaz. Bu genişlik kaç metredir? Cevap: 100",
        "Yıkılan veya herhangi bir şekilde yok olan veya tahribata uğrayan tarihi yapıların yerine başka bir yapı inşa edilemez. İnşa edilme zorunluluğu doğarsa, yenisi aynen yapılır. Devlet, bu yapıların korunması için gerekli tedbirleri alır. Bu madde anayasada hangi kapsamda yer alır? Cevap: Tarih, kültür ve doğa varlıklarının korunması",
        "Gerçek veya tüzel kişiler, hiçbir zaman insan sağlığını tehlikeye düşürecek nitelikteki zehirli, gaz ve katı maddeleri derelere, barajlara, göllere veya denizlere aktaramaz ve dökemez. Bu madde anayasada hangi kapsamda yer alır? Cevap: Çevrenin korunması",
        "Kamulaştırılmış herhangi bir taşınmaz mal veya bu mal üzerindeki herhangi bir hak veya yarar, sadece kamulaştırma amacı için kullanılabilir. Bu amaç, kamulaştırma tarihinden itibaren kaç yıl geçmeden gerçekleştirilemez? Cevap: 3",
        "Kamu hizmeti niteliği taşıyan özel girişimler ve yabancılara ait taşınır ve taşınmaz mallar, kamu yararının gerektirdiği durumlarda, devletleştirilebilir. Bu madde anayasada hangi kapsamda yer alır? Cevap: Devletleştirme",
        "Devletleştirilen mülkün değeri taksitle ödenebilir. Ancak bu süre kaç yılı aşamaz ve taksitler eşit olarak ödenir? Cevap: 10",
        "Devlet, sağlıklı ve insanca yaşama koşullarına uygun konutu bulunmayan ailelere konut temin eder. Bu madde anayasada hangi kapsamda yer alır? Cevap: Konut hakkı",
        "Devlet, herkesin beden ve ruh sağlığı içinde yaşamını sürdürebilmesini ve tıbbi bakım görmesini sağlayacak tedbirler alır. Bu madde anayasada hangi kapsamda yer alır? Cevap: Sağlık hakkı"
      ]
    },
    {
      "title": "Çalışma, Sosyal Güvenlik ve Ekonomik Haklar",
      "details": [
        "Herkes, sözleşme hukukunun genel ilkelerine konan koşullara, kısıntılara, sınırlamalara ve yükümlülüklere uyarak, serbestçe sözleşme yapma hakkına sahiptir. Bu madde anayasada hangi kapsamda yer alır? Cevap: Sözleşme hakkı",
        "Ekonomik ve sosyal hayat, adalet, tam çalışma ilkesine ve her yurttaş için insan onuruna yaraşır bir yaşam düzeyi sağlamasına uygun olarak düzenlenir. Bu madde anayasada hangi kapsamda yer alır? Cevap: Ekonomik ve sosyal hayatın düzeni",
        "Özel girişimlere kurmak serbesttir. Devlet, özel girişimlerin, ulusal ekonominin gereklerine ve sosyal amaçlara uygun yürümesini, güvenlik ve kararlılık içinde çalışmasını sağlayacak önlemleri alır. Bu madde anayasada hangi kapsamda yer alır? Cevap: Çalışma özgürlüğü",
        "Kimse zorla çalıştırılamaz. Angarya yasaktır. Ancak, hükümlülerin, hükümlülükleri süresince rehabilitasyon amacıyla çalıştırılmaları zorla çalıştırma sayılmaz. Bu madde anayasada hangi kapsamda yer alır? Cevap: Çalışma hakkı ve ödevi",
        "Kimse yaşına, gücüne ve cinsiyetine uygun olmayan işte çalıştırılamaz. Bu madde anayasada hangi kapsamda yer alır? Cevap: Çalışma koşulları",
        "Her çalışan dinlenme hakkına sahiptir. Ücretli hafta ve bayram tatili ve ücretli yıllık izin hakkı yasa ile düzenlenir. Bu madde anayasada hangi kapsamda yer alır? Cevap: Dinlenme hakkı",
        "Devlet, çalışanların, yaptıkları işe uygun ve insanca yaşam düzeyi sağlamalarına yetecek asgari bir ücret elde etmeleri için gerekli tedbirleri alır. Bu madde anayasada hangi kapsamda yer alır? Cevap: Ücrette adalet sağlanması",
        "Çalışanlar ve işverenler, önceden izin almaksızın sendikalar ve sendika birlikleri kurma, bunlara serbestçe üye olma ve üyelikten ayrılma hakkına sahiptirler. Bu madde anayasada hangi kapsamda yer alır? Cevap: Sendika kurma hakkı",
        "Çalışanlar, işverenle olan ilişkilerinde, ekonomik ve sosyal durumlarını korumak ve düzeltmek amacıyla toplu sözleşme ve grev hakkına sahiptir. Bu madde anayasada hangi kapsamda yer alır? Cevap: Toplu sözleşme ve grev hakkı",
        "Aşağıdaki meslek gruplarından hangisinin grev hakkı vardır? Cevap: Doktorlar",
        "Hangi meslek grubunun grev hakkı bulunmaktadır? Cevap: Öğretmenler",
        "Herkes sosyal güvenlik hakkına sahiptir. Bu hakkı sağlamak için sosyal sigortalar ve benzeri sosyal güvenlik kurumları ile sosyal yardım örgütleri kurmak ve kurdurmak devletin ödevlerindendir. Bu madde anayasada hangi kapsamda yer alır? Cevap: Sosyal güvenlik hakkı",
        "Devlet, herkesi açlığa karşı korur ve bu amaçla uluslararası işbirliğinden de yararlanarak besin maddelerinin üretimini artırmak, israfını önlemek, dengeli biçimde dağılımını sağlamak ve etkin beslenme olanaklarını yaratmak amacıyla gerekli önlemleri alır. Bu madde anayasada hangi kapsamda yer alır? Cevap: Açlıktan korunma hakkı",
        "Devlet, savaş ve görev şehitlerinin dul ve yetimleri ile malul gazileri korur ve toplumda kendilerine yaraşır bir yaşam düzeyi sağlar. Bu madde anayasada hangi kapsamda yer alır? Cevap: Özel olarak korunma hakkı",
        "Devlet, sosyal ve ekonomik bakımdan güçsüz olanların esenlendirilmesi, kendilerine, ailelerine ve çocuklarına gerekli sosyal güvenlik, koruma ve diğer önlemleri alır. Bu madde anayasada hangi kapsamda yer alır? Cevap: Güçsüzlerin esenlendirilmesi"
      ]
    },
    {
      "title": "Eğitim, Gençlik ve Spor",
      "details": [
        "Her türlü öğretim ve eğitim etkinliği devletin gözetim ve denetimi altında serbesttir. Bu madde anayasadan hangi kapsamda yer alır? Cevap: Öğrenim ve eğitim hakkı",
        "Her çocuk, cinsiyet ayrımı yapılmaksızın kaç yaşına kadar zorunlu öğrenim hakkına sahiptir? Cevap: 15",
        "Her çocuk, cinsiyet ayrımı yapılmaksızın kaç yaşına kadar ücretsiz öğrenim hakkına sahiptir? Cevap: 18",
        "Devlet, gençlerin bilgili, sağlıklı, sağlam karakterli ve topluma yararlı birer yurttaş olarak yetişme ve geliştirmelerini sağlar. Bu madde anayasada hangi kapsamda yer alır? Cevap: Gençliğin korunması",
        "Devlet, her yaştaki yurttaşın beden ve ruh sağlığını geliştirecek, spor kitlelere yayılmasını sağlayacak önlemleri alır, gerekli spor tesislerini kurar. Bu madde anayasada hangi kapsamda yer alır? Cevap: Sporun geliştirilmesi"
      ]
    },
    {
      "title": "Kooperatifçilik, Tarım ve Tüketici Hakları",
      "details": [
        "Devlet, kooperatifçiliğin gelişmesini sağlayacak önlemleri alır ve kooperatiflerin demokratik ilkelere uygun olarak çalışmalarını yasa ile düzenler. Bu madde anayasa bakımından hangi kapsamda yer alır? Cevap: Kooperatifçiliğin geliştirilmesi",
        "Devlet, çiftçinin işletme araçlarına sahip olmasını kolaylaştırır. Bu madde anayasa bakımından hangi kapsamda yer alır? Cevap: Tarım ve çiftçinin korunması",
        "Devlet, tüketicileri koruyucu ve aydınlatıcı önlemler alır. Tüketicilerin kendilerini koruyucu girişimlerini destekler. Bu madde anayasa bakımından hangi kapsamda yer alır? Cevap: Tüketicilerin korunması"
      ]
    },
    {
      "title": "Siyasal Hak ve Ödevler",
      "details": [
        "Seçme ve halkoylamasına katılma, kaç yaşını bitirmiş olan her yurttaşın hakkı ve ödevidir? Cevap: 18",
        "Kaç yaşını bitirmiş olan her yurttaş seçilme hakkına sahiptir? Cevap: 25",
        "Seçilebilmek için en az kaç yıldan beri daimi ikametgahı Kuzey Kıbrıs'ta olmak koşuludur? Cevap: 3",
        "Seçimler ve halk oylaması hangi ilkelere göre yapılır? Cevap: Açık sayım, serbest, gizli sayım ve döküm",
        "Aşağıdakilerden hangisi mesleğinden çekilmeden bile seçimlerde aday olabilir? Cevap: Doktorlar",
        "Aşağıdakilerden hangisi seçimlerin genel yönetimi ve denetimini sağlar? Cevap: Yüksek Seçim Kurulu",
        "Siyasal partiler, bir seçimden kaç gün öncesine kadar kurulup tüzel kişilik kazanmadıkça o seçime katılamaz? Cevap: 90",
        "Aşağıdakilerden hangisi siyasal bir parti kurabilir? Cevap: Otobüs şoförü",
        "Siyasal partilerle ilgili aşağıdaki bilgilerden hangisi yanlıştır? Cevap: Siyasal partiler önceden izin alınarak kurulur.",
        "Aşağıdakilerden hangisi siyasal partilerin mali denetimini yapar? Cevap: Yüksek Mahkeme",
        "Aşağıdakilerden hangisi kurulacak siyasal partilerin tüzük ve programlarını, hukuksal durumlarını takip eder ve denetler? Cevap: Cumhuriyet Başsavcısı",
        "Siyasal partiler hangi kurum tarafından temelli kapatılabilir? Cevap: Yüksek Mahkeme",
        "Her yurttaş, kamu görevine girme hakkına sahiptir. Bu madde hangi siyasal hak ve ödev kapsamaktadır? Cevap: Kamu görevine girme hakkı",
        "Kamu görevine girenlerin girişte ve görev sırasında mal bildiriminde bulunmaları yasa ile düzenlenir. Bu madde hangi siyasal hak ve ödev kapsamaktadır? Cevap: Mal bildirimi",
        "Silahlı kuvvetlerde yurt ödevi, her yurttaşın hakkı ve kutsal ödevidir. Bu madde hangi siyasal hak ve ödev kapsamaktadır? Cevap: Yurt ödevi",
        "Herkes, kamu giderlerini karşılamak üzere, mali gücüne göre, vergi ödevi ile yükümlüdür. Bu madde hangi siyasal hak ve ödev kapsamaktadır? Cevap: Vergi ödevi"
      ]
    },
    {
      "title": "Dilekçe Hakkı",
      "details": [
        "Yurttaşlar, tek başına veya toplu olarak herhangi bir devlet organına istek veya şikayette bulunabilir.",
        "Bu başvuruya ilgili makam 30 gün içinde yazılı olarak geri dönmek zorundadır."
      ]
    },
    {
      "title": "Siyasal Haklar ve Ödevler",
      "details": [
        "Sendika kurma hakkı siyasal hak ve ödevler arasında yer almaz."
      ]
    },
    {
      "title": "Seçme ve Seçilme Hakkı",
      "details": ["Seçme yaşı 18, seçilme yaşı 25'tir."]
    },
    {
      "title": "Parti Kurma Hakkı",
      "details": [
        "Yargıçlar, Silahlı Kuvvetler mensupları ve 18 yaşından küçükler siyasal parti kuramaz."
      ]
    },
    {
      "title": "Yasa/kararların Cumhurbaşkanı tarafından Yayınlanma Süreleri",
      "details": [
        "Cumhurbaşkanı, yasaları en geç 5 gün içinde Resmi Gazete'de yayımlar.",
        "Yayımlanmasını uygun bulmadığı yasaları, 5 gün içinde gerekçesiyle birlikte Cumhuriyet Meclisine geri gönderir."
      ]
    },
    {
      "title": "Cumhurbaşkanının Görev ve Yetkileri",
      "details": [
        "Cumhurbaşkanı, tarafsız olarak görev yapar ve Cumhuriyet Anayasasına, yasalarına ve Cumhuriyet Meclisine karşı sorumludur.",
        "Cumhurbaşkanı, Devletin başıdır ve Devletin ve toplumun birliğini temsil eder."
      ]
    },
    {
      "title": "Meclis Başkanlığı Seçimi",
      "details": [
        "Meclis başkanlığı seçimi bir yasama döneminde iki kez yapılır.",
        "İlk devrede seçilenlerin görev süresi 3 yıl, ikinci devrede seçilenlerin görev süresi 2 yıldır."
      ]
    },
    {
      "title": "Milletvekilliğinin Sona Ermesi",
      "details": [
        "Milletvekilliğinin sona erdirilmesine Cumhuriyet Meclisi kesin ve mutlak karar verebilir.",
        "Milletvekilleri kamu kurumu ve kuruluşlarında kamu personeli olarak görev alamazlar."
      ]
    },
    {
      "title": "Cumhuriyet Güvenlik Kurulu",
      "details": [
        "Cumhuriyet Güvenlik Kurulunun oluşumunda Meclis Başkanı yer almaz.",
        "Kurulda yer alanlar: Cumhurbaşkanı, Başbakan, Silahlı Kuvvetler Komutanı."
      ]
    },
    {
      "title": "Olağanüstü Hal ve Sıkıyönetim",
      "details": [
        "Olağanüstü hal ve sıkıyönetim kararını Cumhurbaşkanı başkanlığında toplanan Bakanlar Kurulu verir.",
        "Bu kararın süresi 3 aydır."
      ]
    },
    {
      "title": "Yargı Yetkisinin Kullanımı",
      "details": [
        "Hiçbir merci yargı yetkisinin kullanımında telkinde bulunamaz.",
        "Cumhurbaşkanı yargı yetkisinin kullanımına ilişkin tavsiyede bulunamaz."
      ]
    },
    {
      "title": "Anayasa Mahkemesi Görevleri",
      "details": [
        "Anayasa Mahkemesi, Anayasanın herhangi maddesi veya kuralını yorumlar.",
        "Devlet organları arasında kuvvet ve yetki uyuşmazlıklarına karar verir."
      ]
    },
    {
      "title": "Yüce Divan",
      "details": [
        "Cumhurbaşkanı, Başbakan ve bakanlar Cumhuriyet Meclisinin 2/3 oyuyla suçlanırsa Yüce Divanda yargılanır.",
        "Yüce Divan sıfatıyla yargılayan mahkeme Anayasa Mahkemesidir."
      ]
    },
    {
      "title": "Anayasa Mahkemesi'nde İptal Davası",
      "details": [
        "Anayasa Mahkemesi'nde iptal davası açabilmek için başvuru süresi 90 gündür.",
        "Başbakan, Anayasa Mahkemesi'nde doğrudan doğruya iptal davası açamaz."
      ]
    },
    {
      "title": "Yüksek Mahkeme Yetkileri",
      "details": [
        "Yüksek Mahkeme, anayasa, yasa ve Mahkeme Tüzüğü kurallarında gösterilen tüm konularda kesin olarak karar verir.",
        "Yüksek Mahkeme, en yüksek istinaf mahkemesidir."
      ]
    },
    {
      "title": "Anayasa Mahkemesi Yetkileri",
      "details": [
        "Anayasa Mahkemesi, devlet organları arasında kuvvet veya yetki uyuşmazlığı hakkında karar verir.",
        "Bu başvuru, uyuşmazlığın başladığı 30 gün içinde yapılmalıdır."
      ]
    },
    {
      "title": "Ombudsman",
      "details": [
        "Ombudsman, Cumhurbaşkanı tarafından atanır ve Cumhuriyet Meclisi tarafından onaylanır.",
        "Ombudsman, ülke savunması, yargı organları ve dış politika konularında yetki sahibi değildir."
      ]
    },
    {
      "title": "Bütçe Tasarısı",
      "details": [
        "Bütçe tasarısı, Bakanlar Kurulunca mali yılbaşından en az 2 ay önce Cumhuriyet Meclisine sunulmalıdır.",
        "Bütçe komitesi bu konudaki çalışmalarını en geç 1 ay içinde tamamlar."
      ]
    },
    {
      "title": "Yargıtay",
      "details": [
        "Yargıtay, herhangi bir mahkemenin yetkiye dayanılarak yanlış uygulamasını önlemek için emirname çıkarabilir.",
        "Yargıtay, yetkisiz tutuklamanın kaldırılması için emirname çıkarma yetkisine sahiptir."
      ]
    },
    {
      "title": "Silahlı Kuvvetlerin Ülke Savunması",
      "details": [
        "Silahlı Kuvvetlerin ülke savunmasına hazırlanmasından Bakanlar Kurulu sorumludur."
      ]
    },
    {
      "title": "Anayasa Mahkemesi'nde Doğrudan Dava Açma",
      "details": [
        "Cumhurbaşkanı, Anayasa Mahkemesi'nde doğrudan dava açma yetkisine sahiptir."
      ]
    },
    {
      "title": "Siyasi Partilerin Kapatılması",
      "details": [
        "Siyasi partilerin kapatılmasına Cumhurbaşkanı karar verir.",
        "Kapatma kararının hukuki denetimini Anayasa Mahkemesi yapar."
      ]
    },
    {
      "title": "Başsavcı",
      "details": [
        "Başsavcı, Hukuk Dairesinin başkanıdır ve devlet organlarının hukuk danışmanıdır.",
        "Başsavcı, Yüksek Adliye Kurulu'nun da üyesidir."
      ]
    },
    {
      "title": "KKTC Anayasası",
      "details": [
        "KKTC Anayasası, 15 Kasım 1983'te Cumhuriyet Meclisinde kabul ve ilan edilmiştir.",
        "Anayasa, 7 Mayıs 1985'te yürürlüğe girmiştir."
      ]
    },
    {
      "title": "Milletvekillerinin Görev ve Yetkileri",
      "details": [
        "Milletvekillerinin maaşı diğer memur maaşlarının iki katıdır.",
        "Milletvekilleri, kamu kurumu ve kuruluşlarında kamu personeli olarak görev alamazlar."
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
          'KKTC Anayasası Bilgileri',
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
    home: KktcAnayasasiInfos(),
  ));
}
