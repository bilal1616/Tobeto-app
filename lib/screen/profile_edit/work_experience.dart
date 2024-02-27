class WorkExperience {
  final String company;
  final String position;
  final String description;
  final String sector;
  final String city;
  final String startDate;
  final String endDate;
  final String country;
  final String tc;

  WorkExperience({
    required this.company,
    required this.position,
    required this.description,
    required this.sector,
    required this.city,
    required this.startDate,
    required this.endDate,
    required this.country,
    required this.tc,
  });

  factory WorkExperience.fromFirestore(Map<String, dynamic> data) {
    return WorkExperience(
      company: data['company'] ?? '',
      position: data['position'] ?? '',
      description: data['description'] ?? '',
      sector: data['sector'] ?? '',
      city: data['city'] ?? '',
      startDate: data['startDate'] ?? '',
      endDate: data['endDate'] ?? '',
      country: data['country'] ?? '',
      tc: data['tc'] ?? '',
    );
  }
}
