class HeartRate {
  final String id;
  final String trainee;
  final int bpm;
  final String createdAt;
  final String updatedAt;
  final int v;

  HeartRate({
    required this.id,
    required this.trainee,
    required this.bpm,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory HeartRate.fromJson(Map<String, dynamic> json) {
    return HeartRate(
      id: json['_id'],
      trainee: json['trainee'],
      bpm: json['bpm'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'trainee': trainee,
      'bpm': bpm,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': v,
    };
  }
}
