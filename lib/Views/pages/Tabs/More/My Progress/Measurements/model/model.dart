class Measurement {
  final String createdAt;

  Measurement({required this.createdAt});

  factory Measurement.fromJson(Map<String, dynamic> json) {
    return Measurement(
      createdAt: json['createdAt'],
    );
  }
}

class MeasurementsData {
  final List<Measurement> weight;
  final List<Measurement> bodyFat;
  final List<Measurement> waistArea;
  final List<Measurement> neckArea;

  MeasurementsData({
    required this.weight,
    required this.bodyFat,
    required this.waistArea,
    required this.neckArea,
  });

  factory MeasurementsData.fromJson(Map<String, dynamic> json) {
    return MeasurementsData(
      weight: (json['weight'] as List)
          .map((i) => Measurement.fromJson(i))
          .toList(),
      bodyFat: (json['bodyFat'] as List)
          .map((i) => Measurement.fromJson(i))
          .toList(),
      waistArea: (json['waistArea'] as List)
          .map((i) => Measurement.fromJson(i))
          .toList(),
      neckArea: (json['neckArea'] as List)
          .map((i) => Measurement.fromJson(i))
          .toList(),
    );
  }
}
