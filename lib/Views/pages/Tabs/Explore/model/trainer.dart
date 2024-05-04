// ignore_for_file: public_member_api_docs, sort_constructors_first
class Trainer {
  final String id;
  final int subscribers;
  final List<String> specializations;
  final String fullName;
  final double lowestPrice;
  final double averageRating;
  final String yearsOfExperienceText;
  final bool isFavorite;  
  Trainer({
    required this.id,
    required this.subscribers,
    required this.specializations,
    required this.fullName,
    required this.lowestPrice,
    required this.averageRating,
    required this.yearsOfExperienceText,
    required this.isFavorite,
  });

  factory Trainer.fromJson(Map<String, dynamic> json) {
    return Trainer(
      id: json['_id'],
      subscribers: json['subscribers'],
      specializations: List<String>.from(json['specializations']),
      fullName: json['fullName'],
      lowestPrice: json['lowestPrice'].toDouble(),
      averageRating: json['averageRating'].toDouble(),
      yearsOfExperienceText: json['yearsOfExperienceText'],
      isFavorite: json['isFavorite'],
    );
  }
}
