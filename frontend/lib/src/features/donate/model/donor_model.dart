enum DonorType { supplier, buyer }

class DonorModel {
  final int? id;
  final String companyName;
  final String phone;
  final String email;
  final String address;
  final String contactPerson;
  final DonorType donorType;
  final DateTime dateJoined;
  final String donationAllocation;

  const DonorModel({
    required this.id,
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
    int? id,
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
      id: id ?? this.id,
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

  // fromJson method
  factory DonorModel.fromJson(Map<String, dynamic> json) {
    return DonorModel(
      id: json['id'],
      companyName: json['company_name'],
      phone: json['phone'],
      email: json['email'],
      address: json['address'],
      contactPerson: json['contact_person'],
      donorType: _donorTypeFromString(json['donor_type']),
      dateJoined: DateTime.parse(json['date_joined']),
      donationAllocation: json['donation_allocation'],
    );
  }

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'company_name': companyName,
      'phone': phone,
      'email': email,
      'address': address,
      'contact_person': contactPerson,
      'donor_type': _donorTypeToString(donorType),
      'date_joined': dateJoined.toIso8601String(),
      'donation_allocation': donationAllocation,
    };
  }

  // Helper method to convert DonorType enum to string
  static String _donorTypeToString(DonorType donorType) {
    switch (donorType) {
      case DonorType.supplier:
        return 'SUPPLIER';
      case DonorType.buyer:
        return 'BUYER';
    }
  }

  // Helper method to convert string to DonorType enum
  static DonorType _donorTypeFromString(String donorType) {
    switch (donorType.toUpperCase()) {
      case 'SUPPLIER':
        return DonorType.supplier;
      case 'BUYER':
        return DonorType.buyer;
      default:
        throw ArgumentError('Invalid donor type');
    }
  }
}
