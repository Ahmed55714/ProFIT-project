class TransformationDetails {
  final String title;
  final String description;
  final String beforeImage;
  final String afterImage;

  TransformationDetails({
    required this.title,
    required this.description,
    required this.beforeImage,
    required this.afterImage,
  });

  factory TransformationDetails.fromJson(Map<String, dynamic> json) {
    return TransformationDetails(
      title: json['title'],
      description: json['description'],
      beforeImage: json['beforeImage'],
      afterImage: json['afterImage'],
    );
  }
}
