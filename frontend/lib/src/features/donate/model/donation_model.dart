class DonationModel {
  final int amount;
  final DateTime? dateUTC;
  final String donationId;
  final String donorId;
  final String recipientId;
  final int? status;

  const DonationModel({
    required this.amount,
    this.dateUTC,
    required this.donationId,
    required this.donorId,
    required this.recipientId,
    this.status,
  });

  // fromJson method
  factory DonationModel.fromJson(Map<String, dynamic> json) {
    return DonationModel(
      amount: json['amount'],
      dateUTC: DateTime.parse(json['dateUTC']),
      donationId: json['donationId'],
      donorId: json['donorId'],
      recipientId: json['recipientId'],
      status: json['status'],
    );
  }

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'dateUTC': dateUTC?.toIso8601String(),
      'donationId': donationId,
      'donorId': donorId,
      'recipientId': recipientId,
      'status': status,
    };
  }
}
