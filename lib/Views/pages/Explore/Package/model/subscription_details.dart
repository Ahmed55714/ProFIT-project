class SubscriptionDetails {
  final String trainerName;
  final String profilePhoto;
  final String subscriptionType;
  final String duration;
  final String startDate;
  final String endDate;
  final double price;
   String trainerId = '';
  

  SubscriptionDetails({
    required this.trainerName,
    required this.profilePhoto,
    required this.subscriptionType,
    required this.duration,
    required this.startDate,
    required this.endDate,
    required this.price,
    required this.trainerId,
  
  });

  factory SubscriptionDetails.fromJson(Map<String, dynamic> json) {
    return SubscriptionDetails(
      trainerName: json['trainerName'] as String? ?? 'Default Name',
      profilePhoto: json['profilePhoto'] as String? ?? 'Default URL',
      subscriptionType: json['SubscriptionType'] as String? ?? 'Default Type',
      duration: json['Duration'].toString(),
      startDate: json['startDate'] as String? ?? 'Start Date',
      endDate: json['endDate'] as String? ?? 'End Date',
      price: (json['paidAmount'] != null) ? json['paidAmount'].toDouble() : 0.0,
      trainerId: json['trainerId'] as String? ?? 'Trainer ID',
    );
  }
}
