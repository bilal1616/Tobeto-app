import 'dart:math';
import 'package:flutter/material.dart';

class PaginationWidget extends StatefulWidget {
  @override
  _PaginationWidgetState createState() => _PaginationWidgetState();
}

class _PaginationWidgetState extends State<PaginationWidget> {
  int currentPage = 1;
  static const int totalPage = 10;
  static const int visiblePages = 5;

  Widget pageButton(int number) {
    bool isSelected = number == currentPage;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2), // Butonlar arası boşluk
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            currentPage = number;
          });
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: isSelected ? Colors.white : Colors.black,
          backgroundColor: isSelected ? Colors.black : Colors.white,
          padding: EdgeInsets.symmetric(
              vertical: 2, horizontal: 8), // Buton boyutunu küçült
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // Daha yuvarlak köşeler
          ),
          side: BorderSide(
              color: isSelected ? Colors.black : Colors.grey), // Kenarlık
          minimumSize: Size(32, 32), // Min boyut
        ),
        child: Text(
          '$number',
          style: TextStyle(fontSize: 14), // Yazı tipi boyutu
        ),
      ),
    );
  }

  List<Widget> buildPageButtons(int startPage, int endPage) {
    return List.generate(
      endPage - startPage + 1,
      (index) => pageButton(startPage + index),
    );
  }

  @override
  Widget build(BuildContext context) {
    int startPage = max(1, currentPage - (visiblePages ~/ 2));
    int endPage = min(totalPage, startPage + visiblePages - 1);

    // Eğer son sayfa sayısı toplam sayfa sayısını aşıyorsa düzelt
    if (endPage == totalPage) {
      startPage = max(1, totalPage - visiblePages + 1);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.chevron_left, color: Colors.black),
          color: Colors.black, // Arka plan rengi
          onPressed: currentPage > 1
              ? () {
                  setState(() {
                    currentPage = max(1, currentPage - 1);
                  });
                }
              : null,
        ),
        ...buildPageButtons(startPage, endPage),
        IconButton(
          icon: Icon(Icons.chevron_right, color: Colors.black),
          color: Colors.black, // Arka plan rengi
          onPressed: currentPage < totalPage
              ? () {
                  setState(() {
                    currentPage = min(totalPage, currentPage + 1);
                  });
                }
              : null,
        ),
      ],
    );
  }
}
