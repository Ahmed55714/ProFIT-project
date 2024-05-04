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
      id: json['_id'],
      fullName: json['fullName'],
      location: json['location'],
      age: json['age'],
      specializations: List<String>.from(json['specializations']),
      email: json['email'],
      gender: json['gender'],
      subscribers: json['subscribers'],
      qualificationsAndAchievements: List<String>.from(json['qualificationsAndAchievements']),
      createdAt: json['createdAt'],
      biography: json['biography'],
      phoneNumber: json['phoneNumber'],
      profilePhoto: json['profilePhoto'],
      yearsOfExperience: json['yearsOfExperience'],
    );
  }
}
