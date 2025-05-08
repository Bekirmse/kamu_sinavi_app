import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SivilhavacilikdairesiYasasiInfos extends StatefulWidget {
  const SivilhavacilikdairesiYasasiInfos({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SivilhavacilikdairesiYasasiInfosState createState() =>
      _SivilhavacilikdairesiYasasiInfosState();
}

class _SivilhavacilikdairesiYasasiInfosState
    extends State<SivilhavacilikdairesiYasasiInfos> {
  final List<Map<String, dynamic>> topics = [
    {
      "title": "Sivil Havacılık Dairesi Yasası - Bölüm 1",
      "details": [
        "Kuzey Kıbrıs Türk Cumhuriyeti Cumhuriyet Meclisinin 13 Haziran 1989 tarihli birleşiminde kabul edilen yasa hangisidir? Cevap: Sivil Havacılık Dairesi (Kuruluş, Görev ve Çalışma Esasları) Yasası.",
        "“Sivil Havacılık Dairesi (Kuruluş, Görev ve Çalışma Esasları) Yasası” ile hangi alan düzenlenmiştir? Cevap: Sivil Havacılık.",
        "“Sivil Havacılık Dairesi (Kuruluş, Görev ve Çalışma Esasları) Yasası” hangi tarihte Cumhuriyet Meclisi tarafından kabul edilmiştir? Cevap: 13 Haziran 1989.",
        "Yasa, Kuzey Kıbrıs Türk Cumhuriyeti Cumhuriyet Meclisi tarafından nasıl isimlendirilmiştir? Cevap: Sivil Havacılık Dairesi (Kuruluş, Görev ve Çalışma Esasları) Yasası.",
        "“Sivil Havacılık Dairesi (Kuruluş, Görev ve Çalışma Esasları) Yasası” hangi kurumu düzenlemek amacıyla yapılmıştır? Cevap: Sivil Havacılık Dairesi.",
        "Bu Yasa, hangi kurumun kuruluş, görev ve çalışma esaslarını düzenlemektedir? Cevap: Sivil Havacılık Dairesi.",
        "Sivil Havacılık Dairesi'nin kuruluş amacı nedir? Cevap: Sivil havacılık ve havaalanları hizmetlerini, kamu güvenliği bakımından düzenlemek, geliştirmek ve denetlemek.",
        "Sivil Havacılık Dairesi, Kuzey Kıbrıs Türk Cumhuriyeti hava sahasında seyreden uçakların güvenliğini hangi kuruluşların mevzuatına göre sağlar? Cevap: Uluslararası Sivil Havacılık Teşkilatı (ICAO) ve Avrupa Sivil Havacılık Konferansı (ECAC).",
        "Sivil Havacılık Dairesi’nin, havalimanlarında görev yapan personelin eğitimini ve sınavlarını hangi standartlara göre yapması gerekmektedir? Cevap: Uluslararası Sivil Havacılık Örgütü (ICAO) ve Avrupa Sivil Havacılık Konferansı (ECAC) standartlarına.",
        "Sivil Havacılık Dairesi’nin görevleri arasında aşağıdakilerden hangisi yer almaz? Cevap: Hava yolu şirketlerine ait bilet fiyatlarını belirlemek.",
        "Sivil Havacılık Dairesi'nin görev ve yetkileri arasında aşağıdakilerden hangisi yer almaz? Cevap: Deniz ulaşımını düzenlemek.",
        "Sivil Havacılık Dairesi’nin, sivil havacılık güvenliğini sağlamak amacıyla aldığı tedbirler hangi alanları kapsar? Cevap: Halkın, yolcuların, mürettebatın, yer personelinin, havalimanı bina ve tesislerinin korunmasını.",
        "Sivil Havacılık Dairesi hangi uluslararası örgütlerin mevzuatına uyarak görev yapar? Cevap: Uluslararası Sivil Havacılık Teşkilatı (ICAO) ve Avrupa Sivil Havacılık Konferansı (ECAC).",
        "Sivil Havacılık Dairesi’nin, sivil havacılık güvenliğini sağlamak amacıyla aldığı tedbirler hangi alanları kapsar? Cevap: Halkın, yolcuların, mürettebatın, yer personelinin, havalimanı bina ve tesislerinin korunmasını.",
        "Sivil Havacılık Dairesi, sivil havacılıkla ilgili eğitim müesseselerini hangi Bakanlıkla istişare ederek denetler? Cevap: Eğitim İşlerinden Sorumlu Bakanlık.",
        "Sivil Havacılık Dairesi, Kuzey Kıbrıs Türk Cumhuriyeti hava sahasında seyreden uçakların güvenliğini hangi kuruluşların mevzuatına göre sağlar? Cevap: Uluslararası Sivil Havacılık Teşkilatı (ICAO) ve Avrupa Sivil Havacılık Konferansı (ECAC).",
        "Sivil Havacılık Dairesi hangi yönetim kadrosuyla yapılandırılmıştır? Cevap: 1 Müdür, 1 Müdür Muavini, Yöneticilik, Mesleki ve Teknik ve Genel Hizmet Sınıfı personeli.",
        "Sivil Havacılık Dairesi yöneticileri, görevlerini yerine getirirken hangi belgeler ve kurallar çerçevesinde hareket etmek zorundadır? Cevap: Anayasa, Yasa, Tüzük ve Yönetmelik kuralları.",
        "Sivil Havacılık Dairesi'nin görev ve yetkileri arasında aşağıdakilerden hangisi yer almaz? Cevap: Deniz ulaşımını düzenlemek.",
        "Sivil Havacılık Dairesi yöneticileri, yürütmekle yükümlü oldukları görevlerde hangi kurumsal emirleri dikkate almak zorundadır? Cevap: Bakanlık genelgeleri ve yönergeleri."
      ]
    },
    {
      "title": "Sivil Havacılık Dairesi Yasası - Bölüm 2",
      "details": [
        "“Sivil Havacılık Dairesi (Kuruluş, Görev ve Çalışma Esasları) Yasası” hangi tarihte Cumhuriyet Meclisi tarafından kabul edilmiştir? Cevap: 13 Haziran 1989.",
        "Bu yasa hangi yasama organı tarafından yapılmıştır? Cevap: Kuzey Kıbrıs Türk Cumhuriyeti Cumhuriyet Meclisi.",
        "Yasa metninde bu yasa nasıl isimlendirilmiştir? Cevap: Sivil Havacılık Dairesi (Kuruluş, Görev ve Çalışma Esasları) Yasası.",
        "Bu yasa, hangi tür yasal düzenlemelerle ilgilidir? Cevap: Kamu Yönetimi ve Kurumsal Düzenlemeler.",
        "Kuzey Kıbrıs Türk Cumhuriyeti Cumhuriyet Meclisi tarafından yapılan yasa hangisidir? Cevap: Sivil Havacılık Dairesi (Kuruluş, Görev ve Çalışma Esasları) Yasası.",
        "Sivil Havacılık Dairesi'nin kuruluş amacı nedir? Cevap: Sivil havacılık ve havaalanları hizmetlerini, kamu güvenliği bakımından düzenlemek, geliştirmek ve denetlemek.",
        "Sivil Havacılık Dairesi'nin görev ve yetkileri arasında aşağıdakilerden hangisi yer almaz? Cevap: Deniz ulaşımını düzenlemek.",
        "Sivil Havacılık Dairesi, Kuzey Kıbrıs Türk Cumhuriyeti hava sahasında seyreden uçakların güvenliğini hangi kuruluşların mevzuatına göre sağlar? Cevap: Uluslararası Sivil Havacılık Teşkilatı (ICAO) ve Avrupa Sivil Havacılık Konferansı (ECAC).",
        "Sivil Havacılık Dairesi hangi uluslararası örgütlerin mevzuatına uyarak görev yapar? Cevap: Uluslararası Sivil Havacılık Teşkilatı (ICAO) ve Avrupa Sivil Havacılık Konferansı (ECAC).",
        "Sivil Havacılık Dairesi, sivil havacılıkla ilgili eğitim müesseselerini hangi Bakanlıkla istişare ederek denetler? Cevap: Eğitim İşlerinden Sorumlu Bakanlık.",
        "Sivil Havacılık Dairesi'nin görev ve yetkileri arasında aşağıdakilerden hangisi yer almaz? Cevap: Deniz ulaşımını düzenlemek.",
        "Sivil Havacılık Dairesi’nin sivil havacılık güvenliğini sağlamak amacıyla aldığı tedbirler hangi alanları kapsar? Cevap: Halkın, yolcuların, mürettebatın, yer personelinin, havalimanı bina ve tesislerinin korunmasını.",
        "Sivil Havacılık Dairesi hangi yönetim kadrosuyla yapılandırılmıştır? Cevap: 1 Müdür, 1 Müdür Muavini, Yöneticilik, Mesleki ve Teknik ve Genel Hizmet Sınıfı personeli.",
        "Sivil Havacılık Dairesi yöneticileri, görevlerini yerine getirirken hangi belgeler ve kurallar çerçevesinde hareket etmek zorundadır? Cevap: Anayasa, Yasa, Tüzük ve Yönetmelik kuralları.",
        "Sivil Havacılık Dairesi, Kuzey Kıbrıs Türk Cumhuriyeti hava sahasında seyreden uçakların güvenliğini hangi kuruluşların mevzuatına göre sağlar? Cevap: Uluslararası Sivil Havacılık Teşkilatı (ICAO) ve Avrupa Sivil Havacılık Konferansı (ECAC).",
        "Sivil Havacılık Dairesi’nin sivil havacılık güvenliğini sağlamak amacıyla aldığı tedbirler hangi alanları kapsar? Cevap: Halkın, yolcuların, mürettebatın, yer personelinin, havalimanı bina ve tesislerinin korunmasını.",
        "Sivil Havacılık Dairesi’nin görevleri arasında aşağıdakilerden hangisi yer almaz? Cevap: Hava yolu şirketlerine ait bilet fiyatlarını belirlemek.",
        "Sivil Havacılık Dairesi'nin görev ve yetkileri arasında aşağıdakilerden hangisi yer almaz? Cevap: Deniz ulaşımını düzenlemek.",
        "Sivil Havacılık Dairesi, sivil havacılıkla ilgili eğitim müesseselerini hangi Bakanlıkla istişare ederek denetler? Cevap: Eğitim İşlerinden Sorumlu Bakanlık.",
        "Sivil Havacılık Dairesi, Kuzey Kıbrıs Türk Cumhuriyeti hava sahasında seyreden uçakların güvenliğini hangi kuruluşların mevzuatına göre sağlar? Cevap: Uluslararası Sivil Havacılık Teşkilatı (ICAO) ve Avrupa Sivil Havacılık Konferansı (ECAC)."
      ]
    },
    {
      "title": "Sivil Havacılık Dairesi Yasası - Bölüm 3",
      "details": [
        "Yasa, Kuzey Kıbrıs Türk Cumhuriyeti Cumhuriyet Meclisi tarafından nasıl isimlendirilmiştir? Cevap: Sivil Havacılık Dairesi (Kuruluş, Görev ve Çalışma Esasları) Yasası.",
        "Sivil Havacılık Dairesi'nin kuruluş amacı nedir? Cevap: Sivil havacılık ve havaalanları hizmetlerini, kamu güvenliği bakımından düzenlemek, geliştirmek ve denetlemek.",
        "Sivil Havacılık Dairesi, Kuzey Kıbrıs Türk Cumhuriyeti hava sahasında seyreden uçakların güvenliğini hangi kuruluşların mevzuatına göre sağlar? Cevap: Uluslararası Sivil Havacılık Teşkilatı (ICAO) ve Avrupa Sivil Havacılık Konferansı (ECAC).",
        "Sivil Havacılık Dairesi hangi uluslararası örgütlerin mevzuatına uyarak görev yapar? Cevap: Uluslararası Sivil Havacılık Teşkilatı (ICAO) ve Avrupa Sivil Havacılık Konferansı (ECAC).",
        "Sivil Havacılık Dairesi’nin sivil havacılık güvenliğini sağlamak amacıyla aldığı tedbirler hangi alanları kapsar? Cevap: Halkın, yolcuların, mürettebatın, yer personelinin, havalimanı bina ve tesislerinin korunmasını.",
        "Sivil Havacılık Dairesi, sivil havacılıkla ilgili eğitim müesseselerini hangi Bakanlıkla istişare ederek denetler? Cevap: Eğitim İşlerinden Sorumlu Bakanlık.",
        "Sivil Havacılık Dairesi’nin görevleri arasında aşağıdakilerden hangisi yer almaz? Cevap: Hava yolu şirketlerine ait bilet fiyatlarını belirlemek.",
        "Sivil Havacılık Dairesi'nin görev ve yetkileri arasında aşağıdakilerden hangisi yer almaz? Cevap: Deniz ulaşımını düzenlemek.",
        "Sivil Havacılık Dairesi, Kuzey Kıbrıs Türk Cumhuriyeti hava sahasında seyreden uçakların güvenliğini hangi kuruluşların mevzuatına göre sağlar? Cevap: Uluslararası Sivil Havacılık Teşkilatı (ICAO) ve Avrupa Sivil Havacılık Konferansı (ECAC).",
        "Sivil Havacılık Dairesi, sivil havacılıkla ilgili eğitim müesseselerini hangi Bakanlıkla istişare ederek denetler? Cevap: Eğitim İşlerinden Sorumlu Bakanlık.",
        "Sivil Havacılık Dairesi’nin sivil havacılık güvenliğini sağlamak amacıyla aldığı tedbirler hangi alanları kapsar? Cevap: Halkın, yolcuların, mürettebatın, yer personelinin, havalimanı bina ve tesislerinin korunmasını.",
        "Sivil Havacılık Dairesi yöneticileri, görevlerini yerine getirirken hangi belgeler ve kurallar çerçevesinde hareket etmek zorundadır? Cevap: Anayasa, Yasa, Tüzük ve Yönetmelik kuralları.",
        "Sivil Havacılık Dairesi hangi uluslararası örgütlerin mevzuatına uyarak görev yapar? Cevap: Uluslararası Sivil Havacılık Teşkilatı (ICAO) ve Avrupa Sivil Havacılık Konferansı (ECAC).",
        "Sivil Havacılık Dairesi’nin görevleri arasında aşağıdakilerden hangisi yer almaz? Cevap: Hava yolu şirketlerine ait bilet fiyatlarını belirlemek.",
        "Sivil Havacılık Dairesi'nin görev ve yetkileri arasında aşağıdakilerden hangisi yer almaz? Cevap: Deniz ulaşımını düzenlemek.",
        "Sivil Havacılık Dairesi, Kuzey Kıbrıs Türk Cumhuriyeti hava sahasında seyreden uçakların güvenliğini hangi kuruluşların mevzuatına göre sağlar? Cevap: Uluslararası Sivil Havacılık Teşkilatı (ICAO) ve Avrupa Sivil Havacılık Konferansı (ECAC).",
        "Sivil Havacılık Dairesi, sivil havacılıkla ilgili eğitim müesseselerini hangi Bakanlıkla istişare ederek denetler? Cevap: Eğitim İşlerinden Sorumlu Bakanlık.",
        "Sivil Havacılık Dairesi’nin sivil havacılık güvenliğini sağlamak amacıyla aldığı tedbirler hangi alanları kapsar? Cevap: Halkın, yolcuların, mürettebatın, yer personelinin, havalimanı bina ve tesislerinin korunmasını.",
        "Sivil Havacılık Dairesi yöneticileri, görevlerini yerine getirirken hangi belgeler ve kurallar çerçevesinde hareket etmek zorundadır? Cevap: Anayasa, Yasa, Tüzük ve Yönetmelik kuralları.",
        "Sivil Havacılık Dairesi hangi uluslararası örgütlerin mevzuatına uyarak görev yapar? Cevap: Uluslararası Sivil Havacılık Teşkilatı (ICAO) ve Avrupa Sivil Havacılık Konferansı (ECAC)."
      ]
    },
    {
      "title": "Cumhurbaşkanının Yasaları İlan Yetkisi - Bölüm 1",
      "details": [
        "Kuzey Kıbrıs Türk Cumhuriyeti Anayasası'nın hangi maddesine göre Cumhurbaşkanı, yasaları Resmi Gazete'de yayımlamak suretiyle ilan eder? Cevap: 94(1).",
        "Yasanın Cumhurbaşkanı tarafından ilan edilmesi hangi yolla gerçekleştirilir? Cevap: Resmi Gazete'de yayımlanma.",
        "Cumhurbaşkanı, yasaları ilan ederken hangi belgeye uygun hareket etmek zorundadır? Cevap: Anayasa.",
        "Cumhurbaşkanının yasaları ilan etme yetkisi hangi hukuki çerçeve içinde yer alır? Cevap: Kuzey Kıbrıs Türk Cumhuriyeti Anayasası.",
        "Cumhurbaşkanının yasaları ilan etme yetkisi, hangi aşamada uygulanır? Cevap: Yasaların Resmi Gazete'de yayımlanması aşamasında.",
        "Cumhurbaşkanının yasaları ilan etme yetkisi, hangi süreçte hukuki geçerlilik kazanır? Cevap: Resmi Gazete'de yayımlandığında.",
        "Cumhurbaşkanının yasaları ilan etme yetkisi hangi yasal dayanakla belirlenmiştir? Cevap: Kuzey Kıbrıs Türk Cumhuriyeti Anayasası.",
        "Cumhurbaşkanının yasaları ilan etme yetkisi, hangi yasa maddesine göre belirlenmiştir? Cevap: 94(1).",
        "Cumhurbaşkanının yasaları ilan etme yetkisi hangi durumda devreye girer? Cevap: Yasalar Resmi Gazete'de yayımlandığında.",
        "Cumhurbaşkanının yasaları ilan etme yetkisi hangi belgelerle ilişkilidir? Cevap: Anayasa ve Resmi Gazete.",
        "Cumhurbaşkanının yasaları ilan etme yetkisi, hangi süreçle ilgilidir? Cevap: Yasaların hukuki geçerlilik kazanması süreci.",
        "Cumhurbaşkanının yasaları ilan etme yetkisi, hangi kurallar çerçevesinde belirlenmiştir? Cevap: Anayasa ve ilgili yasalar.",
        "Cumhurbaşkanının yasaları ilan etme yetkisi, hangi belgeye uygun olarak gerçekleştirilir? Cevap: Resmi Gazete.",
        "Cumhurbaşkanının yasaları ilan etme yetkisi, hangi süreçte geçerlidir? Cevap: Yasaların Resmi Gazete'de yayımlanması sürecinde.",
        "Cumhurbaşkanının yasaları ilan etme yetkisi hangi hukuki dayanağa dayanır? Cevap: Kuzey Kıbrıs Türk Cumhuriyeti Anayasası.",
        "Cumhurbaşkanının yasaları ilan etme yetkisi hangi şartlarda geçerlidir? Cevap: Yasalar Resmi Gazete'de yayımlandığında.",
        "Cumhurbaşkanının yasaları ilan etme yetkisi hangi süreçte tamamlanır? Cevap: Yasaların Resmi Gazete'de yayımlanmasıyla.",
        "Cumhurbaşkanının yasaları ilan etme yetkisi hangi aşamada devreye girer? Cevap: Yasaların hukuki geçerlilik kazanması aşamasında.",
        "Cumhurbaşkanının yasaları ilan etme yetkisi, hangi yasal dayanağa sahiptir? Cevap: Kuzey Kıbrıs Türk Cumhuriyeti Anayasası.",
        "Cumhurbaşkanının yasaları ilan etme yetkisi hangi durumlarda kullanılır? Cevap: Yasaların Resmi Gazete'de yayımlanması durumunda."
      ]
    },
    {
      "title": "Sivil Havacılık Dairesi Görevleri - Bölüm 1",
      "details": [
        "Sivil Havacılık Dairesi'nin görev ve yetkileri arasında aşağıdakilerden hangisi yer almaz? Cevap: Deniz ulaşımını düzenlemek.",
        "Sivil Havacılık Dairesi hangi uluslararası örgütlerin mevzuatına uyarak görev yapar? Cevap: Uluslararası Sivil Havacılık Teşkilatı (ICAO) ve Avrupa Sivil Havacılık Konferansı (ECAC).",
        "Sivil Havacılık Dairesi, sivil havacılıkla ilgili eğitim müesseselerini hangi Bakanlıkla istişare ederek denetler? Cevap: Eğitim İşlerinden Sorumlu Bakanlık.",
        "Sivil Havacılık Dairesi’nin görevleri arasında aşağıdakilerden hangisi yer almaz? Cevap: Hava yolu şirketlerine ait bilet fiyatlarını belirlemek.",
        "Sivil Havacılık Dairesi'nin görev ve yetkileri arasında aşağıdakilerden hangisi yer almaz? Cevap: Deniz ulaşımını düzenlemek.",
        "Sivil Havacılık Dairesi, Kuzey Kıbrıs Türk Cumhuriyeti hava sahasında seyreden uçakların güvenliğini hangi kuruluşların mevzuatına göre sağlar? Cevap: Uluslararası Sivil Havacılık Teşkilatı (ICAO) ve Avrupa Sivil Havacılık Konferansı (ECAC).",
        "Sivil Havacılık Dairesi hangi yönetim kadrosuyla yapılandırılmıştır? Cevap: 1 Müdür, 1 Müdür Muavini, Yöneticilik, Mesleki ve Teknik ve Genel Hizmet Sınıfı personeli.",
        "Sivil Havacılık Dairesi yöneticileri, görevlerini yerine getirirken hangi belgeler ve kurallar çerçevesinde hareket etmek zorundadır? Cevap: Anayasa, Yasa, Tüzük ve Yönetmelik kuralları.",
        "Sivil Havacılık Dairesi’nin sivil havacılık güvenliğini sağlamak amacıyla aldığı tedbirler hangi alanları kapsar? Cevap: Halkın, yolcuların, mürettebatın, yer personelinin, havalimanı bina ve tesislerinin korunmasını.",
        "Sivil Havacılık Dairesi’nin görevleri arasında aşağıdakilerden hangisi yer almaz? Cevap: Hava yolu şirketlerine ait bilet fiyatlarını belirlemek.",
        "Sivil Havacılık Dairesi’nin, havalimanlarında görev yapan personelin eğitimini ve sınavlarını hangi standartlara göre yapması gerekmektedir? Cevap: Uluslararası Sivil Havacılık Örgütü (ICAO) ve Avrupa Sivil Havacılık Konferansı (ECAC) standartlarına.",
        "Sivil Havacılık Dairesi’nin, sivil havacılık güvenliğini sağlamak amacıyla aldığı tedbirler hangi alanları kapsar? Cevap: Halkın, yolcuların, mürettebatın, yer personelinin, havalimanı bina ve tesislerinin korunmasını.",
        "Sivil Havacılık Dairesi hangi uluslararası örgütlerin mevzuatına uyarak görev yapar? Cevap: Uluslararası Sivil Havacılık Teşkilatı (ICAO) ve Avrupa Sivil Havacılık Konferansı (ECAC).",
        "Sivil Havacılık Dairesi'nin görev ve yetkileri arasında aşağıdakilerden hangisi yer almaz? Cevap: Deniz ulaşımını düzenlemek.",
        "Sivil Havacılık Dairesi, sivil havacılıkla ilgili eğitim müesseselerini hangi Bakanlıkla istişare ederek denetler? Cevap: Eğitim İşlerinden Sorumlu Bakanlık.",
        "Sivil Havacılık Dairesi’nin görevleri arasında aşağıdakilerden hangisi yer almaz? Cevap: Hava yolu şirketlerine ait bilet fiyatlarını belirlemek.",
        "Sivil Havacılık Dairesi'nin görev ve yetkileri arasında aşağıdakilerden hangisi yer almaz? Cevap: Deniz ulaşımını düzenlemek.",
        "Sivil Havacılık Dairesi, Kuzey Kıbrıs Türk Cumhuriyeti hava sahasında seyreden uçakların güvenliğini hangi kuruluşların mevzuatına göre sağlar? Cevap: Uluslararası Sivil Havacılık Teşkilatı (ICAO) ve Avrupa Sivil Havacılık Konferansı (ECAC).",
        "Sivil Havacılık Dairesi hangi yönetim kadrosuyla yapılandırılmıştır? Cevap: 1 Müdür, 1 Müdür Muavini, Yöneticilik, Mesleki ve Teknik ve Genel Hizmet Sınıfı personeli.",
        "Sivil Havacılık Dairesi yöneticileri, görevlerini yerine getirirken hangi belgeler ve kurallar çerçevesinde hareket etmek zorundadır? Cevap: Anayasa, Yasa, Tüzük ve Yönetmelik kuralları."
      ]
    },
    {
      "title": "Sivil Havacılık Dairesi Görevleri - Bölüm 2",
      "details": [
        "Sivil Havacılık Dairesi, Kuzey Kıbrıs Türk Cumhuriyeti hava sahasında seyreden uçakların güvenliğini hangi kuruluşların mevzuatına göre sağlar? Cevap: Uluslararası Sivil Havacılık Teşkilatı (ICAO) ve Avrupa Sivil Havacılık Konferansı (ECAC).",
        "Sivil Havacılık Dairesi, sivil havacılıkla ilgili eğitim müesseselerini hangi Bakanlıkla istişare ederek denetler? Cevap: Eğitim İşlerinden Sorumlu Bakanlık.",
        "Sivil Havacılık Dairesi hangi uluslararası örgütlerin mevzuatına uyarak görev yapar? Cevap: Uluslararası Sivil Havacılık Teşkilatı (ICAO) ve Avrupa Sivil Havacılık Konferansı (ECAC).",
        "Sivil Havacılık Dairesi yöneticileri, görevlerini yerine getirirken hangi belgeler ve kurallar çerçevesinde hareket etmek zorundadır? Cevap: Anayasa, Yasa, Tüzük ve Yönetmelik kuralları.",
        "Sivil Havacılık Dairesi’nin sivil havacılık güvenliğini sağlamak amacıyla aldığı tedbirler hangi alanları kapsar? Cevap: Halkın, yolcuların, mürettebatın, yer personelinin, havalimanı bina ve tesislerinin korunmasını.",
        "Sivil Havacılık Dairesi, sivil havacılıkla ilgili eğitim müesseselerini hangi Bakanlıkla istişare ederek denetler? Cevap: Eğitim İşlerinden Sorumlu Bakanlık.",
        "Sivil Havacılık Dairesi’nin görevleri arasında aşağıdakilerden hangisi yer almaz? Cevap: Hava yolu şirketlerine ait bilet fiyatlarını belirlemek.",
        "Sivil Havacılık Dairesi'nin görev ve yetkileri arasında aşağıdakilerden hangisi yer almaz? Cevap: Deniz ulaşımını düzenlemek.",
        "Sivil Havacılık Dairesi, Kuzey Kıbrıs Türk Cumhuriyeti hava sahasında seyreden uçakların güvenliğini hangi kuruluşların mevzuatına göre sağlar? Cevap: Uluslararası Sivil Havacılık Teşkilatı (ICAO) ve Avrupa Sivil Havacılık Konferansı (ECAC).",
        "Sivil Havacılık Dairesi, sivil havacılıkla ilgili eğitim müesseselerini hangi Bakanlıkla istişare ederek denetler? Cevap: Eğitim İşlerinden Sorumlu Bakanlık.",
        "Sivil Havacılık Dairesi’nin sivil havacılık güvenliğini sağlamak amacıyla aldığı tedbirler hangi alanları kapsar? Cevap: Halkın, yolcuların, mürettebatın, yer personelinin, havalimanı bina ve tesislerinin korunmasını.",
        "Sivil Havacılık Dairesi yöneticileri, görevlerini yerine getirirken hangi belgeler ve kurallar çerçevesinde hareket etmek zorundadır? Cevap: Anayasa, Yasa, Tüzük ve Yönetmelik kuralları.",
        "Sivil Havacılık Dairesi hangi uluslararası örgütlerin mevzuatına uyarak görev yapar? Cevap: Uluslararası Sivil Havacılık Teşkilatı (ICAO) ve Avrupa Sivil Havacılık Konferansı (ECAC).",
        "Sivil Havacılık Dairesi’nin görevleri arasında aşağıdakilerden hangisi yer almaz? Cevap: Hava yolu şirketlerine ait bilet fiyatlarını belirlemek.",
        "Sivil Havacılık Dairesi'nin görev ve yetkileri arasında aşağıdakilerden hangisi yer almaz? Cevap: Deniz ulaşımını düzenlemek.",
        "Sivil Havacılık Dairesi, Kuzey Kıbrıs Türk Cumhuriyeti hava sahasında seyreden uçakların güvenliğini hangi kuruluşların mevzuatına göre sağlar? Cevap: Uluslararası Sivil Havacılık Teşkilatı (ICAO) ve Avrupa Sivil Havacılık Konferansı (ECAC).",
        "Sivil Havacılık Dairesi, sivil havacılıkla ilgili eğitim müesseselerini hangi Bakanlıkla istişare ederek denetler? Cevap: Eğitim İşlerinden Sorumlu Bakanlık.",
        "Sivil Havacılık Dairesi’nin sivil havacılık güvenliğini sağlamak amacıyla aldığı tedbirler hangi alanları kapsar? Cevap: Halkın, yolcuların, mürettebatın, yer personelinin, havalimanı bina ve tesislerinin korunmasını.",
        "Sivil Havacılık Dairesi yöneticileri, görevlerini yerine getirirken hangi belgeler ve kurallar çerçevesinde hareket etmek zorundadır? Cevap: Anayasa, Yasa, Tüzük ve Yönetmelik kuralları.",
        "Sivil Havacılık Dairesi hangi uluslararası örgütlerin mevzuatına uyarak görev yapar? Cevap: Uluslararası Sivil Havacılık Teşkilatı (ICAO) ve Avrupa Sivil Havacılık Konferansı (ECAC)."
      ]
    },
    {
      "title": "Sivil Havacılık Dairesi Yapısı ve Yönetimi",
      "details": [
        "Sivil Havacılık Dairesi hangi yönetim kadrosuyla yapılandırılmıştır? Cevap: 1 Müdür, 1 Müdür Muavini, Yöneticilik, Mesleki ve Teknik ve Genel Hizmet Sınıfı personeli.",
        "Sivil Havacılık Dairesi’nin görevleri arasında aşağıdakilerden hangisi yer almaz? Cevap: Deniz ulaşımını düzenlemek.",
        "Sivil Havacılık Dairesi yöneticileri, görevlerini yerine getirirken hangi belgeler ve kurallar çerçevesinde hareket etmek zorundadır? Cevap: Anayasa, Yasa, Tüzük ve Yönetmelik kuralları.",
        "Sivil Havacılık Dairesi yöneticileri, yürütmekle yükümlü oldukları görevlerde hangi kurumsal emirleri dikkate almak zorundadır? Cevap: Bakanlık genelgeleri ve yönergeleri.",
        "Sivil Havacılık Dairesi yöneticileri, görevlerini yerine getirirken hangi belgeler ve kurallar çerçevesinde hareket etmek zorundadır? Cevap: Anayasa, Yasa, Tüzük ve Yönetmelik kuralları.",
        "Sivil Havacılık Dairesi, Kuzey Kıbrıs Türk Cumhuriyeti hava sahasında seyreden uçakların güvenliğini hangi kuruluşların mevzuatına göre sağlar? Cevap: Uluslararası Sivil Havacılık Teşkilatı (ICAO) ve Avrupa Sivil Havacılık Konferansı (ECAC).",
        "Sivil Havacılık Dairesi yöneticileri, görevlerini yerine getirirken hangi belgeler ve kurallar çerçevesinde hareket etmek zorundadır? Cevap: Anayasa, Yasa, Tüzük ve Yönetmelik kuralları.",
        "Sivil Havacılık Dairesi'nin görev ve yetkileri arasında aşağıdakilerden hangisi yer almaz? Cevap: Deniz ulaşımını düzenlemek.",
        "Sivil Havacılık Dairesi yöneticileri, yürütmekle yükümlü oldukları görevlerde hangi kurumsal emirleri dikkate almak zorundadır? Cevap: Bakanlık genelgeleri ve yönergeleri.",
        "Sivil Havacılık Dairesi hangi yönetim kadrosuyla yapılandırılmıştır? Cevap: 1 Müdür, 1 Müdür Muavini, Yöneticilik, Mesleki ve Teknik ve Genel Hizmet Sınıfı personeli.",
        "Sivil Havacılık Dairesi yöneticileri, görevlerini yerine getirirken hangi belgeler ve kurallar çerçevesinde hareket etmek zorundadır? Cevap: Anayasa, Yasa, Tüzük ve Yönetmelik kuralları.",
        "Sivil Havacılık Dairesi’nin görevleri arasında aşağıdakilerden hangisi yer almaz? Cevap: Deniz ulaşımını düzenlemek.",
        "Sivil Havacılık Dairesi yöneticileri, görevlerini yerine getirirken hangi belgeler ve kurallar çerçevesinde hareket etmek zorundadır? Cevap: Anayasa, Yasa, Tüzük ve Yönetmelik kuralları.",
        "Sivil Havacılık Dairesi yöneticileri, yürütmekle yükümlü oldukları görevlerde hangi kurumsal emirleri dikkate almak zorundadır? Cevap: Bakanlık genelgeleri ve yönergeleri.",
        "Sivil Havacılık Dairesi'nin görev ve yetkileri arasında aşağıdakilerden hangisi yer almaz? Cevap: Deniz ulaşımını düzenlemek.",
        "Sivil Havacılık Dairesi yöneticileri, yürütmekle yükümlü oldukları görevlerde hangi kurumsal emirleri dikkate almak zorundadır? Cevap: Bakanlık genelgeleri ve yönergeleri.",
        "Sivil Havacılık Dairesi hangi yönetim kadrosuyla yapılandırılmıştır? Cevap: 1 Müdür, 1 Müdür Muavini, Yöneticilik, Mesleki ve Teknik ve Genel Hizmet Sınıfı personeli.",
        "Sivil Havacılık Dairesi yöneticileri, görevlerini yerine getirirken hangi belgeler ve kurallar çerçevesinde hareket etmek zorundadır? Cevap: Anayasa, Yasa, Tüzük ve Yönetmelik kuralları.",
        "Sivil Havacılık Dairesi’nin görevleri arasında aşağıdakilerden hangisi yer almaz? Cevap: Deniz ulaşımını düzenlemek.",
        "Sivil Havacılık Dairesi yöneticileri, yürütmekle yükümlü oldukları görevlerde hangi kurumsal emirleri dikkate almak zorundadır? Cevap: Bakanlık genelgeleri ve yönergeleri."
      ]
    },
    {
      "title": "Sivil Havacılık Dairesi Personel Eğitimi ve Standartları",
      "details": [
        "Sivil Havacılık Dairesi’nin, havalimanlarında görev yapan personelin eğitimini ve sınavlarını hangi standartlara göre yapması gerekmektedir? Cevap: Uluslararası Sivil Havacılık Örgütü (ICAO) ve Avrupa Sivil Havacılık Konferansı (ECAC) standartlarına.",
        "Sivil Havacılık Dairesi, sivil havacılıkla ilgili eğitim müesseselerini hangi Bakanlıkla istişare ederek denetler? Cevap: Eğitim İşlerinden Sorumlu Bakanlık.",
        "Sivil Havacılık Dairesi, Kuzey Kıbrıs Türk Cumhuriyeti hava sahasında seyreden uçakların güvenliğini hangi kuruluşların mevzuatına göre sağlar? Cevap: Uluslararası Sivil Havacılık Teşkilatı (ICAO) ve Avrupa Sivil Havacılık Konferansı (ECAC).",
        "Sivil Havacılık Dairesi’nin sivil havacılık güvenliğini sağlamak amacıyla aldığı tedbirler hangi alanları kapsar? Cevap: Halkın, yolcuların, mürettebatın, yer personelinin, havalimanı bina ve tesislerinin korunmasını.",
        "Sivil Havacılık Dairesi hangi uluslararası örgütlerin mevzuatına uyarak görev yapar? Cevap: Uluslararası Sivil Havacılık Teşkilatı (ICAO) ve Avrupa Sivil Havacılık Konferansı (ECAC).",
        "Sivil Havacılık Dairesi yöneticileri, görevlerini yerine getirirken hangi belgeler ve kurallar çerçevesinde hareket etmek zorundadır? Cevap: Anayasa, Yasa, Tüzük ve Yönetmelik kuralları.",
        "Sivil Havacılık Dairesi, sivil havacılıkla ilgili eğitim müesseselerini hangi Bakanlıkla istişare ederek denetler? Cevap: Eğitim İşlerinden Sorumlu Bakanlık.",
        "Sivil Havacılık Dairesi’nin görevleri arasında aşağıdakilerden hangisi yer almaz? Cevap: Hava yolu şirketlerine ait bilet fiyatlarını belirlemek.",
        "Sivil Havacılık Dairesi'nin görev ve yetkileri arasında aşağıdakilerden hangisi yer almaz? Cevap: Deniz ulaşımını düzenlemek.",
        "Sivil Havacılık Dairesi, sivil havacılıkla ilgili eğitim müesseselerini hangi Bakanlıkla istişare ederek denetler? Cevap: Eğitim İşlerinden Sorumlu Bakanlık.",
        "Sivil Havacılık Dairesi’nin sivil havacılık güvenliğini sağlamak amacıyla aldığı tedbirler hangi alanları kapsar? Cevap: Halkın, yolcuların, mürettebatın, yer personelinin, havalimanı bina ve tesislerinin korunmasını.",
        "Sivil Havacılık Dairesi, sivil havacılıkla ilgili eğitim müesseselerini hangi Bakanlıkla istişare ederek denetler? Cevap: Eğitim İşlerinden Sorumlu Bakanlık.",
        "Sivil Havacılık Dairesi yöneticileri, görevlerini yerine getirirken hangi belgeler ve kurallar çerçevesinde hareket etmek zorundadır? Cevap: Anayasa, Yasa, Tüzük ve Yönetmelik kuralları.",
        "Sivil Havacılık Dairesi’nin sivil havacılık güvenliğini sağlamak amacıyla aldığı tedbirler hangi alanları kapsar? Cevap: Halkın, yolcuların, mürettebatın, yer personelinin, havalimanı bina ve tesislerinin korunmasını.",
        "Sivil Havacılık Dairesi, sivil havacılıkla ilgili eğitim müesseselerini hangi Bakanlıkla istişare ederek denetler? Cevap: Eğitim İşlerinden Sorumlu Bakanlık.",
        "Sivil Havacılık Dairesi yöneticileri, görevlerini yerine getirirken hangi belgeler ve kurallar çerçevesinde hareket etmek zorundadır? Cevap: Anayasa, Yasa, Tüzük ve Yönetmelik kuralları.",
        "Sivil Havacılık Dairesi, Kuzey Kıbrıs Türk Cumhuriyeti hava sahasında seyreden uçakların güvenliğini hangi kuruluşların mevzuatına göre sağlar? Cevap: Uluslararası Sivil Havacılık Teşkilatı (ICAO) ve Avrupa Sivil Havacılık Konferansı (ECAC).",
        "Sivil Havacılık Dairesi’nin görevleri arasında aşağıdakilerden hangisi yer almaz? Cevap: Hava yolu şirketlerine ait bilet fiyatlarını belirlemek.",
        "Sivil Havacılık Dairesi, sivil havacılıkla ilgili eğitim müesseselerini hangi Bakanlıkla istişare ederek denetler? Cevap: Eğitim İşlerinden Sorumlu Bakanlık.",
        "Sivil Havacılık Dairesi’nin sivil havacılık güvenliğini sağlamak amacıyla aldığı tedbirler hangi alanları kapsar? Cevap: Halkın, yolcuların, mürettebatın, yer personelinin, havalimanı bina ve tesislerinin korunmasını."
      ]
    },
    {
      "title": "Sivil Havacılık Dairesi Hukuki Düzenlemeler ve Uygulamalar",
      "details": [
        "Sivil Havacılık Dairesi’nin görevleri arasında aşağıdakilerden hangisi yer almaz? Cevap: Hava yolu şirketlerine ait bilet fiyatlarını belirlemek.",
        "Sivil Havacılık Dairesi yöneticileri, görevlerini yerine getirirken hangi belgeler ve kurallar çerçevesinde hareket etmek zorundadır? Cevap: Anayasa, Yasa, Tüzük ve Yönetmelik kuralları.",
        "Sivil Havacılık Dairesi, sivil havacılıkla ilgili eğitim müesseselerini hangi Bakanlıkla istişare ederek denetler? Cevap: Eğitim İşlerinden Sorumlu Bakanlık.",
        "Sivil Havacılık Dairesi’nin görevleri arasında aşağıdakilerden hangisi yer almaz? Cevap: Deniz ulaşımını düzenlemek.",
        "Sivil Havacılık Dairesi yöneticileri, görevlerini yerine getirirken hangi belgeler ve kurallar çerçevesinde hareket etmek zorundadır? Cevap: Anayasa, Yasa, Tüzük ve Yönetmelik kuralları.",
        "Sivil Havacılık Dairesi'nin görev ve yetkileri arasında aşağıdakilerden hangisi yer almaz? Cevap: Deniz ulaşımını düzenlemek.",
        "Sivil Havacılık Dairesi’nin görevleri arasında aşağıdakilerden hangisi yer almaz? Cevap: Hava yolu şirketlerine ait bilet fiyatlarını belirlemek.",
        "Sivil Havacılık Dairesi yöneticileri, görevlerini yerine getirirken hangi belgeler ve kurallar çerçevesinde hareket etmek zorundadır? Cevap: Anayasa, Yasa, Tüzük ve Yönetmelik kuralları.",
        "Sivil Havacılık Dairesi, sivil havacılıkla ilgili eğitim müesseselerini hangi Bakanlıkla istişare ederek denetler? Cevap: Eğitim İşlerinden Sorumlu Bakanlık.",
        "Sivil Havacılık Dairesi yöneticileri, görevlerini yerine getirirken hangi belgeler ve kurallar çerçevesinde hareket etmek zorundadır? Cevap: Anayasa, Yasa, Tüzük ve Yönetmelik kuralları.",
        "Sivil Havacılık Dairesi’nin görevleri arasında aşağıdakilerden hangisi yer almaz? Cevap: Deniz ulaşımını düzenlemek.",
        "Sivil Havacılık Dairesi yöneticileri, yürütmekle yükümlü oldukları görevlerde hangi kurumsal emirleri dikkate almak zorundadır? Cevap: Bakanlık genelgeleri ve yönergeleri.",
        "Sivil Havacılık Dairesi'nin görev ve yetkileri arasında aşağıdakilerden hangisi yer almaz? Cevap: Deniz ulaşımını düzenlemek.",
        "Sivil Havacılık Dairesi yöneticileri, yürütmekle yükümlü oldukları görevlerde hangi kurumsal emirleri dikkate almak zorundadır? Cevap: Bakanlık genelgeleri ve yönergeleri.",
        "Sivil Havacılık Dairesi yöneticileri, görevlerini yerine getirirken hangi belgeler ve kurallar çerçevesinde hareket etmek zorundadır? Cevap: Anayasa, Yasa, Tüzük ve Yönetmelik kuralları.",
        "Sivil Havacılık Dairesi’nin görevleri arasında aşağıdakilerden hangisi yer almaz? Cevap: Hava yolu şirketlerine ait bilet fiyatlarını belirlemek.",
        "Sivil Havacılık Dairesi yöneticileri, yürütmekle yükümlü oldukları görevlerde hangi kurumsal emirleri dikkate almak zorundadır? Cevap: Bakanlık genelgeleri ve yönergeleri.",
        "Sivil Havacılık Dairesi'nin görev ve yetkileri arasında aşağıdakilerden hangisi yer almaz? Cevap: Deniz ulaşımını düzenlemek.",
        "Sivil Havacılık Dairesi yöneticileri, yürütmekle yükümlü oldukları görevlerde hangi kurumsal emirleri dikkate almak zorundadır? Cevap: Bakanlık genelgeleri ve yönergeleri.",
        "Sivil Havacılık Dairesi'nin görev ve yetkileri arasında aşağıdakilerden hangisi yer almaz? Cevap: Deniz ulaşımını düzenlemek."
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
          'Sivil Havacılık Dairesi Bilgileri',
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
    home: SivilhavacilikdairesiYasasiInfos(),
  ));
}
