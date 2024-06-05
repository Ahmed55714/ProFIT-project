class Photo {
  final String id;
  final String photoUrl;
  final String createdAt;

  Photo({required this.id, required this.photoUrl, required this.createdAt});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['_id'],
      photoUrl: json['photo'],
      createdAt: json['createdAt'],
    );
  }
}
