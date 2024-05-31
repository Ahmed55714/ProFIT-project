class Challenge {
  final String? id;
  final String? title;
  final String? imagePath;
  final String? formattedTimeElapsed;

  Challenge({
     this.id,
     this.title,
    this.imagePath,
    this.formattedTimeElapsed,
  });

  factory Challenge.fromJson(Map<String, dynamic> json) {
    return Challenge(
      id: json['_id'],
      title: json['title'],
      imagePath: json['image'],
      formattedTimeElapsed: json['formattedTimeElapsed'],
    );
  }
}
