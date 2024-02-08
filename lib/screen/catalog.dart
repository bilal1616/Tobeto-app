import 'package:flutter/material.dart';
import 'package:tobeto_app/widget/catalog_widget/catalog_data.dart';
import 'package:tobeto_app/widget/catalog_widget/catalog_pagination.dart';
import 'package:tobeto_app/widget/catalog_widget/catalog_widget.dart';
import 'package:tobeto_app/widget/catalog_widget/filter_dialog.dart';

class Catalog extends StatefulWidget {
  final bool showAppBar;
  const Catalog({Key? key, this.showAppBar = false}) : super(key: key);

  @override
  _CatalogState createState() => _CatalogState();
}

class _CatalogState extends State<Catalog> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    String imagePath =
        isDarkMode ? "assets/tobeto-logo-dark.png" : "assets/tobeto-logo.png";

    return Scaffold(
      appBar: widget.showAppBar
          ? AppBar(
              title: Image.asset(imagePath, width: 120, height: 60),
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
            )
          : null,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  height: 275,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/banner.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: "Eğitim arayın...",
                      prefixIcon: Icon(Icons.search),
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0)),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 14), // İçerik dolgusunu azalt
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.025),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                minimumSize: const Size(350, 40),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
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
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: catalogList.length,
              itemBuilder: (ctx, index) => Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CatalogWidget(catalogModel: catalogList[index]),
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.025),
            PaginationWidget(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.075),
          ],
        ),
      ),
    );
  }
}
