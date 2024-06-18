enum DonorType { supplier, buyer }

class DonorModel {
  final String companyName;
  final String phone;
  final String email;
  final String address;
  final String contactPerson;
  final DonorType donorType;
  final DateTime dateJoined;
  final String donationAllocation;

  const DonorModel({
    required this.companyName,
    required this.phone,
    required this.email,
    required this.address,
    required this.contactPerson,
    required this.donorType,
    required this.dateJoined,
    required this.donationAllocation,
  });

  DonorModel copyWith({
    String? companyName,
    String? phone,
    String? email,
    String? address,
    String? contactPerson,
    DonorType? donorType,
    DateTime? dateJoined,
    String? donationAllocation,
  }) {
    return DonorModel(
      companyName: companyName ?? this.companyName,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      address: address ?? this.address,
      contactPerson: contactPerson ?? this.contactPerson,
      donorType: donorType ?? this.donorType,
      dateJoined: dateJoined ?? this.dateJoined,
      donationAllocation: donationAllocation ?? this.donationAllocation,
    );
  }
}
