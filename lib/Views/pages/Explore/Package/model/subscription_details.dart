class SubscriptionDetails {
  final String trainerName;
  final String profilePhoto;
  final String subscriptionType;
  final String duration;
  final String startDate;
  final String endDate;

  SubscriptionDetails({
    required this.trainerName,
    required this.profilePhoto,
    required this.subscriptionType,
    required this.duration,
    required this.startDate,
    required this.endDate,
  });

  factory SubscriptionDetails.fromJson(Map<String, dynamic> json) {
  return SubscriptionDetails(
    trainerName: json['trainerName'] as String? ?? 'Default Name',
    profilePhoto: json['profilePhoto'] as String? ?? 'Default URL',
    subscriptionType: json['SubscriptionType'] as String? ?? 'Default Type',
    duration: json['Duration'].toString(),
    startDate: json['startDate'] as String? ?? 'Start Date',
    endDate: json['endDate'] as String? ?? 'End Date',
  );
}

}
