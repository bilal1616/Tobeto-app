import 'package:flutter/material.dart';

class Catalog extends StatefulWidget {
  const Catalog({Key? key}) : super(key: key);

  @override
  _CatalogState createState() => _CatalogState();
}

class _CatalogState extends State<Catalog> {
  int currentPage = 1;

  List<String> filters = [
    'Bana Özel',
    'Kategori',
    'Eğitimler',
    'Seviye',
    'Konu',
    'Yazılım Dili',
    'Eğitmen',
    'Durum',
  ];

  // Seçilen filtreleri saklamak için bir harita
  Map<String, String> selectedFilters = {};

  // Kategori filtresi için altındaki içerikler
  String categoryFilter = 'Tüm Eğitimler';
  bool showCategoryFilterContent = false;

  List<String> categoryOptions = [
    'Tüm Eğitimler',
    'Ücretli Eğitimler',
    'Ücretsiz Eğitimler',
  ];

  String searchText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Image.asset(
                  'assets/banner.png',
                  width: double.infinity,
                  height: 250.0,
                  fit: BoxFit.cover,
                ),
                Container(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Öğrenmeye",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        "Başla !",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 36.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 15.0),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            children: [
                              Icon(Icons.search, color: Colors.grey),
                              SizedBox(width: 8.0),
                              Expanded(
                                child: TextField(
                                  style: TextStyle(color: Colors.black),
                                  onChanged: (value) {
                                    setState(() {
                                      searchText = value;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Eğitim arayın...',
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 40.0),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Tıklandığında filtreleme penceresi açılır
                  _showFilterDialog(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 135, 39, 176),
                ),
                child: Text(
                  "Filtrele",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10), // Boşluk eklendi
            _buildCard(
              imageUrl: 'assets/resim1.jpg',
              duration: '4s 14dk',
              title: 'Dinle, Anla, İfade Et: Etkili İletişim Gelişim Yolculuğu',
            ),
            SizedBox(height: 10), // Boşluk eklendi
            _buildCard(
              imageUrl: 'assets/resim2.jpg',
              duration: '40dk',
              title: 'Sürdürülebilir Bir Dünya için Bireysel Farkındalık',
            ),
            SizedBox(height: 10), // Boşluk eklendi
            _buildCard(
              imageUrl: 'assets/resim3.jpg',
              duration: '53dk',
              title: 'Hibrit Yaşamda Duyguyu Düzenleme',
            ),
            // Diğer kart içerikleri buraya eklenir

            SizedBox(height: 20),
            buildPageButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(
      {required String imageUrl,
      required String duration,
      required String title}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.0),
      child: Card(
        elevation: 5.0,
        margin: EdgeInsets.all(0),
        color: Colors.grey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.topRight,
                children: [
                  Image.asset(
                    imageUrl,
                    width: double.infinity,
                    height: 250.0,
                    fit: BoxFit.cover,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.play_circle_fill_outlined,
                      color: Colors.purple,
                      size: 40,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Icon(Icons.person, color: Colors.white, size: 16),
                  SizedBox(width: 5),
                  Text(
                    'Gürkan İlişen',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold, // Font'u kalınlaştırıldı
                    ),
                  ),
                  SizedBox(width: 10),
                  Icon(Icons.access_time, color: Colors.white, size: 16),
                  SizedBox(width: 5),
                  Text(
                    duration,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold, // Font'u kalınlaştırıldı
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold, // Font'u kalınlaştırıldı
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPageButtons() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildPageButton("<"),
          buildPageButton(1),
          buildPageButton(2),
          buildPageButton(3),
          buildPageButton(4),
          buildPageButton(5),
          buildPageButton(">"),
        ],
      ),
    );
  }

  Widget buildPageButton(dynamic page) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ElevatedButton(
        onPressed: () {
          // Sayfa numarasına gitmek için kullanılacak kod buraya gelecek
        },
        style: ElevatedButton.styleFrom(
          minimumSize: Size(40, 40),
          padding: EdgeInsets.all(0),
          backgroundColor:
              page == currentPage ? Colors.purple : Colors.grey,
        ),
        child: Text('$page', style: TextStyle(fontSize: 14)),
      ),
    );
  }

  // Filtreleme penceresini gösteren metod
  Future<void> _showFilterDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return AlertDialog(
                title: Text('Filtreleme'),
                content: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (String filter in filters)
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              selectedFilters[filter] = 'Seçildi';
                            });
          
                            // Kategori butonuna tıklandığında altında içerikler gösterilsin
                            if (filter == 'Kategori') {
                              showCategoryFilterContent = true;
                            } else {
                              // Diğer filtreler için seçimleri temizle
                              selectedFilters.remove('Tüm Eğitimler');
                              selectedFilters.remove('Ücretli Eğitimler');
                              selectedFilters.remove('Ücretsiz Eğitimler');
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(double.infinity, 40),
                            foregroundColor:
                                filter == 'Kategori' ? Colors.black : null,
                            backgroundColor:
                                filter == 'Kategori' ? Colors.purple : Colors.grey,
                          ),
                          child: Text(
                            filter,
                            style: TextStyle(
                              color: filter == 'Kategori' ? Colors.black : null,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      if (showCategoryFilterContent)
                        Column(
                          children: [
                            SizedBox(height: 10),
                            _buildCategoryFilterContent(),
                          ],
                        ),
                      SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Filtrele'),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  // Kategori filtresi içeriklerini gösteren metod
  Widget _buildCategoryFilterContent() {
    return Column(
      children: [
        SizedBox(height: 10),
        TextField(
          decoration: InputDecoration(
            hintText: 'Eğitim arayın...',
          ),
        ),
        SizedBox(height: 10),
        for (String option in categoryOptions)
          _buildCategoryFilterItem(option),
      ],
    );
  }

  // Kategori filtresi içerik öğesi
  Widget _buildCategoryFilterItem(String label) {
    return Row(
      children: [
        Checkbox(
          value: selectedFilters.containsKey(label),
          onChanged: (bool? value) {
            setState(() {
              if (value != null && value) {
                selectedFilters[label] = 'Seçildi';
              } else {
                selectedFilters.remove(label);
              }
            });
          },
        ),
        Text(label),
      ],
    );
  }
}


