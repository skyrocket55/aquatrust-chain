import 'package:bwt_frontend/src/features/donate/donate.dart';
import 'package:bwt_frontend/src/features/donate/model/donation_model.dart';
import 'package:bwt_frontend/src/features/donate/repo/backend_repo.dart';
import 'package:bwt_frontend/src/features/donate/repo/chaincode_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'donation_state.dart';

final donationControllerProvider =
    StateNotifierProvider<DonationController, DonationState>(
  (ref) => DonationController(
    chaincode: ref.read(chaincodeRepoProvider),
    backend: ref.read(backendRepoProvider),
  ),
);

class DonationController extends StateNotifier<DonationState> {
  DonationController({
    required ChaincodeRepository chaincode,
    required BackendRepository backend,
  })  : _chaincode = chaincode,
        _backend = backend,
        super(const DonationState());

  final ChaincodeRepository _chaincode;
  final BackendRepository _backend;

  void setCurrentSelectNgo(int id) {
    state = state.copyWith(
      selectedRecipientId: id,
    );
  }

  void setCurrentSelectDonor(int id) {
    state = state.copyWith(
      selectedDonorId: id,
    );
  }

  void setDonorList(List<DonorModel> donors) {
    state = state.copyWith(donorsList: donors);
  }

  void setRecipientList(List<RecipientModel> recipients) {
    state = state.copyWith(recipientList: recipients);
  }

  void setDonationAmount(int amount) {
    state = state.copyWith(donationAmount: amount);
  }

  RecipientModel getSelectedRecipient() {
    return state.recipientList.firstWhere(
      (element) => element.id == state.selectedRecipientId,
    );
  }

  DonorModel getSelectedDonor() {
    return state.donorsList.firstWhere(
      (element) => element.id == state.selectedDonorId,
    );
  }

  void setDonation(DonationModel donationModel) {
    state = state.copyWith(donation: donationModel);
  }

  Future<void> sendDonation({
    required String donationId,
    required String donorId,
    required String recipientId,
    required int amount,
  }) async {
    state = state.copyWith(status: DonationStatus.loading);

    try {
      final result = await _chaincode.sendDonation(
        DonationModel(
          amount: amount,
          donationId: donationId,
          donorId: donorId,
          recipientId: recipientId,
        ),
      );

      state = state.copyWith(
        status: result
            ? DonationStatus.successfullySentDonation
            : DonationStatus.errorSendingDonation,
      );
    } catch (e) {
      state = state.copyWith(
        status: DonationStatus.errorSendingDonation,
        errorText: e.toString(),
      );
    }
  }

  Future<void> fetchDonationDetails(String donationId) async {
    state = state.copyWith(status: DonationStatus.loading);

    try {
      final result = await _chaincode.getDonation(donationId);

      if (result != null) {
        state = state.copyWith(
          status: DonationStatus.successfullyFetchedDonation,
          // donation: result,
        );
      } else {
        state = state.copyWith(
          status: DonationStatus.errorGettingDonation,
          // donation: null,
        );
      }
    } catch (e) {
      state = state.copyWith(
        status: DonationStatus.errorGettingDonation,
        // donation: null,
      );
    }
  }

  Future<void> fetchDonorsList() async {
    state = state.copyWith(status: DonationStatus.loading);
    try {
      final donors = await _backend.getDonorsList();
      state = state.copyWith(
        status: DonationStatus.successfullyLoadedDonorsList,
        donorsList: donors,
      );
    } catch (e) {
      // Handle failure scenario
      state = state.copyWith(
        status: DonationStatus.errorFetchingDonorsList,
        errorText: e.toString(),
      );
    }
  }

  Future<void> fetchRecipientsList() async {
    state = state.copyWith(status: DonationStatus.loading);
    try {
      final recipients = await _backend.getNgosList();
      state = state.copyWith(
        status: DonationStatus.successfullyLoadedNgoList,
        recipientList: recipients,
      );
    } on Exception catch (e) {
      // Handle failure scenario
      state = state.copyWith(
        status: DonationStatus.errorFetchingNgoList,
        errorText: e.toString(),
      );
    }
  }

// Example of registering a new NGO recipient
// Future<void> registerNgo(RecipientModel ngo) async {
//   state = state.copyWith(status: DonationStatus.loading);
//
//   try {
//     final success = await _backend.registerNgo(ngo);
//
//     if (success) {
//       // Update state if registration is successful
//       state = state.copyWith(
//         status: DonationStatus.,
//         // Optionally update state with success message or updated lists
//       );
//     } else {
//       // Handle failure scenario
//       state = state.copyWith(
//         status: DonationStatus.failure,
//         errorText: 'Failed to register NGO',
//       );
//     }
//   } catch (e) {
//     // Handle exception scenario
//     state = state.copyWith(
//       status: DonationStatus.failure,
//       errorText: e.toString(),
//     );
//   }
// }
}
