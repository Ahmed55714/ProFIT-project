class Trainer {
   final String id;
   final int subscribers;
   final List<String> specializations;
   final String fullName;
   final double lowestPrice;
   final double averageRating;
   final String yearsOfExperienceText;
   bool isFavorite; 
   final String? profilePhoto;

   Trainer({
       required this.id,
       required this.subscribers,
       required this.specializations,
       required this.fullName,
       required this.lowestPrice,
       required this.averageRating,
       required this.yearsOfExperienceText,
       required this.isFavorite,
       this.profilePhoto,
   });

   factory Trainer.fromJson(Map<String, dynamic> json) {
       return Trainer(
           id: json['_id'] ?? '', 
           subscribers: json['subscribers'] ?? 0,
           specializations: List<String>.from(json['specializations'] ?? []),
           fullName: json['fullName'] ?? '',
           lowestPrice: json['lowestPrice']?.toDouble() ?? 0.0,
           averageRating: json['averageRating']?.toDouble() ?? 0.0,
           yearsOfExperienceText: json['yearsOfExperience'].toString() ?? '0',
           isFavorite: json['isFavorite'] ?? false,
           profilePhoto: json['profilePhoto'], 
       );
   }

   Map<String, dynamic> toJson() {
       return {
           '_id': id,
           'subscribers': subscribers,
           'specializations': specializations,
           'fullName': fullName,
           'lowestPrice': lowestPrice,
           'averageRating': averageRating,
           'yearsOfExperienceText': yearsOfExperienceText,
           'isFavorite': isFavorite,
           'profilePhoto': profilePhoto,
       };
   }

   void toggleFavorite() {
       isFavorite = !isFavorite;
   }
}
