class Trainer {
   final String id;
   final int subscribers;
   final List<String> specializations;
   final String fullName;
   final double lowestPrice;
   final double averageRating;
   final String yearsOfExperienceText;
   final bool isFavorite;
   final String? profilePhoto;  // Make profilePhoto nullable if it can be absent

   Trainer({
       required this.id,
       required this.subscribers,
       required this.specializations,
       required this.fullName,
       required this.lowestPrice,
       required this.averageRating,
       required this.yearsOfExperienceText,
       required this.isFavorite,
       this.profilePhoto,  // Nullable field
   });

   factory Trainer.fromJson(Map<String, dynamic> json) {
       return Trainer(
           id: json['_id'] ?? '', 
           subscribers: json['subscribers'] ?? 0,
           specializations: List<String>.from(json['specializations'] ?? []),
           fullName: json['fullName'] ?? '',
           lowestPrice: json['lowestPrice']?.toDouble() ?? 0.0,
           averageRating: json['averageRating']?.toDouble() ?? 0.0,
           yearsOfExperienceText: json['yearsOfExperienceText'] ?? '',
           isFavorite: json['isFavorite'] ?? false,
           profilePhoto: json['profilePhoto'], 
       );
   }
}
