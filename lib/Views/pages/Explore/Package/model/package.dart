class Package {
  final String id;
  final String packageName;
  final String packageType;
  final String description;
  final int price;
  final int duration;

  Package({
    required this.id,
    required this.packageName,
    required this.packageType,
    required this.description,
    required this.price,
    required this.duration,
  });

  factory Package.fromJson(Map<String, dynamic> json) {
    return Package(
      id: json['_id'],
      packageName: json['packageName'],
      packageType: json['packageType'],
      description: json['description'],
      price: json['price'],
      duration: json['duration'],
    );
  }
}
