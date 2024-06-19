class RecipientModel {
  final int? id;
  final String ngoName;
  final String profile;
  final String phone;
  final String email;
  final String address;
  final String contactPerson;
  final DateTime? dateRegistered;
  final String communitiesSupported;
  final String waterDemand;
  final String totalDonationReceived;

  const RecipientModel({
    this.id,
    required this.ngoName,
    required this.profile,
    required this.phone,
    required this.email,
    required this.address,
    required this.contactPerson,
     this.dateRegistered,
    required this.communitiesSupported,
    required this.waterDemand,
    required this.totalDonationReceived,
  });

  RecipientModel copyWith({
    int? id,
    String? ngoName,
    String? profile,
    String? phone,
    String? email,
    String? address,
    String? contactPerson,
    DateTime? dateRegistered,
    String? communitiesSupported,
    String? waterDemand,
    String? totalDonationReceived,
  }) {
    return RecipientModel(
      ngoName: ngoName ?? this.ngoName,
      profile: profile ?? this.profile,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      address: address ?? this.address,
      contactPerson: contactPerson ?? this.contactPerson,
      dateRegistered: dateRegistered ?? this.dateRegistered,
      communitiesSupported: communitiesSupported ?? this.communitiesSupported,
      waterDemand: waterDemand ?? this.waterDemand,
      totalDonationReceived:
          totalDonationReceived ?? this.totalDonationReceived,
      id: id ?? this.id,
    );
  }

  // fromJson method
  factory RecipientModel.fromJson(Map<String, dynamic> json) {
    return RecipientModel(
      id: json['id'],
      ngoName: json['ngo_name'],
      profile: json['profile'],
      phone: json['phone'],
      email: json['email'],
      address: json['address'],
      contactPerson: json['contact_person'],
      dateRegistered: json['date_registered'],
      communitiesSupported: json['communities_supported'],
      waterDemand: json['water_demand'],
      totalDonationReceived: json['total_donation_received'],
    );
  }

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'ngo_name': ngoName,
      'profile': profile,
      'phone': phone,
      'email': email,
      'address': address,
      'contact_person': contactPerson,
      'date_registered': dateRegistered?.toIso8601String(),
      'communities_supported': communitiesSupported,
      'water_demand': waterDemand,
      'total_donation_received': totalDonationReceived,
    };
  }
}
