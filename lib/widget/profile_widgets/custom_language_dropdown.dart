import 'package:flutter/material.dart';

class CustomLanguageDropdown extends StatelessWidget {
  final String labelText;
  final Language? selectedLanguage;
  final List<Language> options;
  final Function(Language?) onChanged;

  CustomLanguageDropdown({
    required this.labelText,
    required this.selectedLanguage,
    required this.options,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
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
            child: DropdownButtonFormField<Language>(
              value: selectedLanguage,
              onChanged: onChanged,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              items: options.map((Language language) {
                return DropdownMenuItem<Language>(
                  value: language,
                  child: Text(language.name),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class Language {
  final String name;

  Language({required this.name});
}
  Language? selectedLanguage;
  List<Language> languages = [
    Language(name: 'İngilizce'),
    Language(name: 'Almanca'),
    Language(name: 'İspanyolca'),
  ];

class LanguageLevel {
  final String level;

  LanguageLevel({required this.level});
}

class CustomLanguageLevelDropdown extends StatelessWidget {
  final String labelText;
  final LanguageLevel? selectedLevel;
  final List<LanguageLevel> options;
  final Function(LanguageLevel?) onChanged;

  CustomLanguageLevelDropdown({
    required this.labelText,
    required this.selectedLevel,
    required this.options,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
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
            child: DropdownButtonFormField<LanguageLevel>(
              value: selectedLevel,
              onChanged: onChanged,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              items: options.map((LanguageLevel level) {
                return DropdownMenuItem<LanguageLevel>(
                  value: level,
                  child: Text(level.level),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

 List<LanguageLevel> languageLevels = [
    LanguageLevel(level: 'Temel Seviye(A1-A2)'),
    LanguageLevel(level: 'Orta Seviye(B1-B2)'),
    LanguageLevel(level: 'İleri Seviye(C1-C2)'),
      LanguageLevel(level: 'Anadil'),
    
  ];