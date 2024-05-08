class TrainerAbout {
  final String id;
  final String fullName;
  final String location;
  final String age;
  final List<String> specializations;
  final String email;
  final String gender;
  final int subscribers;
  final List<String> qualificationsAndAchievements;
  final String createdAt;
  final String biography;
  final String phoneNumber;
  final String profilePhoto;
  final String yearsOfExperience;

  TrainerAbout({
    required this.id,
    required this.fullName,
    required this.location,
    required this.age,
    required this.specializations,
    required this.email,
    required this.gender,
    required this.subscribers,
    required this.qualificationsAndAchievements,
    required this.createdAt,
    required this.biography,
    required this.phoneNumber,
    required this.profilePhoto,
    required this.yearsOfExperience,
  });

  factory TrainerAbout.fromJson(Map<String, dynamic> json) {
    return TrainerAbout(
      id: json['_id'] ?? '', 
      fullName: json['fullName'] ?? 'Unknown', 
      location: json['location'] ?? 'Unknown location', 
      age: json['age'] ?? 'Unknown', 
      specializations: List<String>.from(json['specializations'] ?? []), 
      email: json['email'] ?? 'No email',
      gender: json['gender'] ?? 'Unknown', 
      subscribers: json['subscribers'] ?? 0, 
      qualificationsAndAchievements: List<String>.from(json['qualificationsAndAchievements'] ?? []), // Empty list if null
      createdAt: json['createdAt'] ?? DateTime.now().toString(),
      biography: json['biography'] ?? 'No biography provided', 
      phoneNumber: json['phoneNumber'] ?? 'No phone number',
      profilePhoto: json['profilePhoto'] ?? 'No image', 
      yearsOfExperience: json['yearsOfExperience'] ?? '0',
    );
  }
}
