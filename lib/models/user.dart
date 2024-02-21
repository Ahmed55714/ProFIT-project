class User {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String mobile;
  final bool isTrainer;

  User({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.mobile,
    this.isTrainer = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'mobile': mobile,
      'isTrainer': isTrainer,
    };
  }
}
