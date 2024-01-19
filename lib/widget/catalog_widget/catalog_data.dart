class CatalogModel {
  
  const CatalogModel({
    required this.id,
    required this.imagePath,
    required this.name,
    required this.time,
    required this.title,
  });

  final String id;
  final String name;
  final String time;
  final String title;
  final String imagePath;
}


const catalogList = [
  CatalogModel(
    id: "1",
    imagePath: "https://tobeto.s3.cloud.ngn.com.tr/ENK_36573_a8546fa0ff.jpg",
    name: "Gürkan İlişen",
    time: "4s 14dk",
    title: "Dinle, Anla, İfade Et: Etkili İletişim \nGelişim Yolculuğu",
  ),
  CatalogModel(
    id: "2",
    imagePath: "https://tobeto.s3.cloud.ngn.com.tr/ENK_365670_08eb2bab1a.jpg",
    name: "Gürkan İlişen ",
    time: "40dk",
    title: "Sürdürülebilir Bir Dünya İçin Bireysel \nFarkındalık",
  ),
  CatalogModel(
    id: "3",
    imagePath: "https://tobeto.s3.cloud.ngn.com.tr/ENK_365693_fd2d22fa3a.jpg",
    name: "Gürkan İlişen ",
    time: "53dk",
    title: "Hibrit Yaşamda Duyguyu Düzenleme ",
  ),
  CatalogModel(
    id: "4",
    imagePath: "https://tobeto.s3.cloud.ngn.com.tr/ENK_365274_0e51ec7bdb.jpg",
    name: "Gürkan İlişen",
    time: "2s 1dk",
    title: "Web Sayfası Tasarımı Nasıl \nOluşturulur?-HTML(Temel Seviye)",
  ),
  CatalogModel(
      id: "5",
      imagePath: "https://tobeto.s3.cloud.ngn.com.tr/ENK_365270_7e8908a0c2.jpg",
      name: "Gürkan İlişen ",
      time: "36dk",
      title: "Mehmet Auf ile İyi Günde, Kötü Günde"),
  CatalogModel(
      id: "6",
      imagePath: "https://tobeto.s3.cloud.ngn.com.tr/ENKG_616_3e86ae6eba.jpg",
      name: "Gürkan İlişen",
      time: "1s",
      title: "Programlamanın Tarihçesi ve Gelişimi"),
  CatalogModel(
      id: "7",
      imagePath: "https://tobeto.s3.cloud.ngn.com.tr/ENKG_389_65af6d2667.jpg",
      name: "Gürkan İlişen",
      time: "1s",
      title: "Fiziksel ve Dijital Çalışma Alanınızın \nDüzenlenmesi "),
  CatalogModel(
      id: "8",
      imagePath: "https://tobeto.s3.cloud.ngn.com.tr/ENKG_275_b356d6fb3d.jpg",
      name: "Gürkan İlişen",
      time: "1s",
      title: "Yazılım Geliştirme ve Programlama \nTemel Kavramları"),
  CatalogModel(
      id: "9",
      imagePath: "https://tobeto.s3.cloud.ngn.com.tr/ENIB_116_5a33bf9410.jpg",
      name: "Gürkan İlişen ",
      time: "2s",
      title: "Biz Bir Ekibiz"),
  CatalogModel(
      id: "10",
      imagePath: "https://tobeto.s3.cloud.ngn.com.tr/ENIB_238_ea465ab18a.jpg",
      name: "Gürkan İlişen",
      time: "20dk",
      title: "Yaratıcı Düşünme ve İnovasyon \nTeknikleri "),
  CatalogModel(
      id: "11",
      imagePath: "https://tobeto.s3.cloud.ngn.com.tr/ENIB_210_e8f964f5a9.jpg",
      name: "Gürkan İlişen",
      time: "20dk",
      title: "Problem Çözme Teknikleri"),
  CatalogModel(
      id: "12",
      imagePath: "https://tobeto.s3.cloud.ngn.com.tr/ENIB_195_b77497161b.jpg",
      name: "Gürkan İlişen ",
      time: "17dk",
      title: "Müşteri Ne İster?")
];
