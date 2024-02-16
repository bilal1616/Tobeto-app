import 'package:flutter/material.dart';

class CustomCityDropdown extends StatelessWidget {
  final String labelText;
  final CustomCity? selectedCity;
  final List<CustomCity> options;
  final Function(CustomCity?) onChanged;

  CustomCityDropdown({
    required this.labelText,
    required this.selectedCity,
    required this.options,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          SizedBox(
            height: 57.0,
            child: DropdownButtonFormField<CustomCity>(
              value: selectedCity,
              onChanged: onChanged,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              items: options.map((CustomCity city) {
                return DropdownMenuItem<CustomCity>(
                  value: city,
                  child: Text(city.cityName),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomCity {
  String cityName;
  List<String> districts;

  CustomCity({
    required this.cityName,
    required this.districts,
  });
}

List<CustomCity> allCities = [
  CustomCity(cityName: "İstanbul", districts: ["Beşiktaş", "Kadıköy", "Şişli", "Üsküdar"]),
  CustomCity(cityName: "Ankara", districts: ["Çankaya", "Kızılay", "Mamak", "Yenimahalle"]),
  CustomCity(cityName: "Izmir", districts: ["Bornova", "Konak", "Alsancak", "Karşıyaka"]),
  CustomCity(cityName: "Bursa", districts: ["Osmangazi", "Nilüfer", "Yıldırım", "Gürsu"]),
];
