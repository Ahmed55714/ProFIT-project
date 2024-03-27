class Profile {
  String id;
  String firstName;
  String lastName;
  String email;
  String profilePhoto;
  String phoneNumber;

  Profile({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.profilePhoto,
    required this.phoneNumber,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      profilePhoto: json['profilePhoto'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
    );
  }

  Profile copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? profilePhoto,
    String? phoneNumber,
  }) {
    return Profile(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      profilePhoto: profilePhoto ?? this.profilePhoto,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
}
