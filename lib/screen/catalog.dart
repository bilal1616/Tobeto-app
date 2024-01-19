import 'package:flutter/material.dart';
import 'package:tobeto_app/widget/catalog_widget/catalog_data.dart';
import 'package:tobeto_app/widget/catalog_widget/catalog_pagination.dart';
import 'package:tobeto_app/widget/catalog_widget/catalog_widget.dart';
import 'package:tobeto_app/widget/catalog_widget/filter_dialog.dart';

class Catalog extends StatefulWidget {
  const Catalog({Key? key}) : super(key: key);

  @override
  _CatalogState createState() => _CatalogState();
}

class _CatalogState extends State<Catalog> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Banner
            Container(
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage('assets/banner.png'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.start, // Bu satır güncellendi
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Yatay hizalama için eklendi
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      "Öğrenmeye \nbaşla !",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 38.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        hintText: "Eğitim arayın...",
                        hintStyle: const TextStyle(fontSize: 15),
                        prefixIcon: const Icon(Icons.search),
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.025),
            // Filtrele Butonu
            // Catalog sınıfına eklemek için
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                minimumSize: const Size(350, 35),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    // Filtreleme dialog'unu çağır
                    return FilterDialog();
                  },
                );
              },
              child: const Text(
                "Filtrele",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w900),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.025),
            // CatalogModel Kartları
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: catalogList.length,
              itemBuilder: (ctx, index) => Center(
                child: Container(
                  width: MediaQuery.of(context).size.width *
                      0.9, // Genişliği ayarlandı
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CatalogWidget(catalogModel: catalogList[index]),
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.025),
            PaginationWidget(), // Sayfa geçiş butonlarını ekleyin
            SizedBox(height: MediaQuery.of(context).size.height * 0.075),
          ],
        ),
      ),
    );
  }
}
