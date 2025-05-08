// İki kullanıcının UID'lerini alıp sabit bir sohbet ID'si oluşturan yardımcı fonksiyon
String getChatId(String uid1, String uid2) {
  // UID'leri alfabetik olarak karşılaştırıyoruz.
  // Hangi kullanıcı önce yazarsa yazsın, aynı sohbet ID'si üretilir.
  // Örn: getChatId("abc", "xyz") => "abc_xyz"
  //      getChatId("xyz", "abc") => yine "abc_xyz"
  // Bu sayede kullanıcılar arasındaki sohbet ID'si her zaman aynı olur.
  return uid1.compareTo(uid2) < 0 ? '${uid1}_$uid2' : '${uid2}_$uid1';
}
