import 'package:flutter/material.dart';

class FilterDialog extends StatefulWidget {
  const FilterDialog({Key? key}) : super(key: key);

  @override
  _FilterDialogState createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  String selectedCategory = "";
  List<String> selectedFilters = [];

  @override
  Widget build(BuildContext context) {
    bool isBanaOzelSelected = selectedFilters.contains("Bana Özel");

    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Filtreleme"),
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            // Bana Özel butonu
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (isBanaOzelSelected) {
                    selectedFilters.remove("Bana Özel");
                  } else {
                    selectedFilters.add("Bana Özel");
                  }
                });
              },
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Bana Özel",
                  style: TextStyle(color: Colors.black), // Siyah metin rengi
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.white), // Beyaz arka plan
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.all(8.0)),
                minimumSize: MaterialStateProperty.all<Size>(
                    Size(double.infinity, 36)), // Minimum boyut
              ),
            ),
            // Diğer filtre butonları
            buildFilterButton("Kategori",
                ["Tüm Eğitimler", "Ücretli Eğitimler", "Ücretsiz Eğitimler"]),
            buildFilterButton("Eğitimler",
                ["Tüm Eğitimler", "Dijital Gelişim", "Profesyonel Gelişim"]),
            buildFilterButton(
                "Seviye", ["Tüm Seviyeler", "Başlangıç", "Orta", "İleri"]),
            buildFilterButton("Konu", [
              "Tüm Konular",
              "C#",
              "Çeşitlilik ve Kapsayacılık",
              "Başarı ve Sonuç Odaklılık",
              "Takım Bilinci",
              "Etkili İletişim ve İlişki",
              "Karar Verme",
              "Profesyonellik",
              "Kişisel Motivasyon",
              "Problem Çözme",
              "Yenilikçilik ve Yaratıcılık",
              "Verimlilik ve Zaman Yönetimi",
              "Müzakere Becerileri",
              "Duygusal Zeka",
              "Çevik Düşünme",
              "Esneklik",
              "Sürekli Gelişim",
              "Ticari Odaklılık",
              "Çatışma Çözme",
              "Azim ve Direnç",
              "Proaktif Olma",
              "Kariyer Yönetimi",
              "Stres Yönetimi",
              "Kritik Düşünme",
              "Kişisel Güç ve Güvenirlik",
              "Özdisiplin",
              "Programlama",
              "Yazılım Geliştirme"
            ]),
            buildFilterButton("Yazılım Dili", [
              "Tüm Diller",
              "ASPNET",
              "Bootstrap",
              "SASS",
              "JavaScript",
              "JQuery",
              "AJAX",
              "SQL",
              "C#",
              "HTML",
              "CSS",
              "Javascript",
              "React"
            ]),
            buildFilterButton("Eğitmen", [
              "Tüm Eğitmenler",
              "Eğitmen Dojo",
              "Roiva Eğitmen",
              "Veli Bahçeci",
              "İrem Balcı",
              "Gürkan İlişen",
              "Cem Bayraktaroğlu",
              "Ahmet Çetinkaya",
              "Denizhan Dursun",
              "Halit Enes Kalaycı",
              "Kadir Murat Başaren",
              "Semih Karduz",
              "Barbaros Ciga",
              "Aykut Baştuğ",
              "Mehmet Emin Kortak",
              "Serkan Tekin",
              "Engin Demiroğ",
              "Ali Seyhan",
              "Kader Yavuz"
            ]),
            buildFilterButton("Durum", [
              "Tüm Eğitimler",
              "Alınan Tüm Eğitimler",
              "Henüz Başlanmamış Eğitimler",
              "Tamamlanan Eğitimler",
              "Devam Eden Eğitimler"
            ]),
          ],
        ),
      ),
      actions: [
        Center(
          child: ElevatedButton(
            onPressed: () {
              // Filtreleme seçeneklerini uygula ve dialog'u kapat
            },
            child: Text("Filtrele"),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.purple),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildFilterButton(String filter, List<String> subOptions) {
    bool isSelected = selectedFilters.contains(filter);

    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            setState(() {
              if (isSelected) {
                selectedFilters.remove(filter);
              } else {
                selectedFilters.add(filter);
              }
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                filter,
                style: TextStyle(color: Colors.white),
              ),
              Icon(
                isSelected
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                color: Colors.white,
              ),
            ],
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                isSelected ? Colors.purple : Colors.grey),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                EdgeInsets.all(8.0)),
            minimumSize: MaterialStateProperty.all<Size>(
                Size(double.infinity, 36)), // Minimum boyut
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.015),
        if (isSelected) ...[
          TextField(
            decoration: InputDecoration(
              hintText: "Arama",
              contentPadding:
                  EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
              border: OutlineInputBorder(),
            ),
          ),
          ...subOptions.map((option) {
            bool isOptionSelected = selectedFilters.contains(option);
            return ListTile(
              onTap: () {
                setState(() {
                  if (isOptionSelected) {
                    selectedFilters.remove(option);
                  } else {
                    selectedFilters.add(option);
                  }
                });
              },
              title: Row(
                children: [
                  Icon(
                    isOptionSelected
                        ? Icons.radio_button_checked
                        : Icons.radio_button_unchecked,
                    color: isOptionSelected ? Colors.purple : Colors.grey,
                  ),
                  SizedBox(width: 8),
                  Expanded(child: Text(option)),
                ],
              ),
            );
          }).toList(),
        ],
      ],
    );
  }
}
