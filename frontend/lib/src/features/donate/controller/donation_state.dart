part of 'donation_controller.dart';

enum DonationStatus {
  initial,
  loading,
  donorAndRecipientSelected,
  amountSelected,
  transactionConfirmed,
  transactionFinished,
  errorGettingDonation,
  errorSendingDonation,
  errorFetchingNgoList,
  errorFetchingDonorsList,
  successfullyLoadedNgoList,
  successfullyLoadedDonorsList,
  successfullySentDonation,
  successfullyFetchedDonation,
}

class DonationState extends Equatable {
  const DonationState({
    this.status = DonationStatus.initial,
    this.errorText = "",
    this.donorsList = const [],
    this.recipientList = const [],
    this.selectedDonorId = 0,
    this.selectedRecipientId = -1,
    this.donationAmount = 0,
    this.donation,
  });

  final DonationStatus status;
  final String errorText;
  final List<DonorModel> donorsList;
  final List<RecipientModel> recipientList;
  final int selectedDonorId;
  final int selectedRecipientId;
  final int donationAmount;
  final DonationModel? donation;

  DonationState copyWith({
    DonationStatus? status,
    String? errorText,
    List<DonorModel>? donorsList,
    List<RecipientModel>? recipientList,
    int? selectedDonorId,
    int? selectedRecipientId,
    int? donationAmount,
    DonationModel? donation,
  }) {
    return DonationState(
      donation: donation ?? this.donation,
      donationAmount: donationAmount ?? this.donationAmount,
      status: status ?? this.status,
      errorText: errorText ?? this.errorText,
      donorsList: donorsList ?? this.donorsList,
      recipientList: recipientList ?? this.recipientList,
      selectedDonorId: selectedDonorId ?? this.selectedDonorId,
      selectedRecipientId: selectedRecipientId ?? this.selectedRecipientId,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorText,
        donorsList,
        recipientList,
        selectedDonorId,
        selectedRecipientId,
      ];
}
