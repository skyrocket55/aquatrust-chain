class RecipientModel {
  final String ngoName;
  final String profile;
  final String phone;
  final String email;
  final String address;
  final String contactPerson;
  final DateTime dateRegistered;
  final String communitiesSupported;
  final String waterDemand;
  final String totalDonationReceived;

  const RecipientModel({
    required this.ngoName,
    required this.profile,
    required this.phone,
    required this.email,
    required this.address,
    required this.contactPerson,
    required this.dateRegistered,
    required this.communitiesSupported,
    required this.waterDemand,
    required this.totalDonationReceived,
  });

  RecipientModel copyWith({
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
    );
  }
}
