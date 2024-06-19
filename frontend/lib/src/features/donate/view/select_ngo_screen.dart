import 'package:bwt_frontend/src/features/donate/controller/donation_controller.dart';
import 'package:bwt_frontend/src/features/donate/repo/backend_repo.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bwt_frontend/src/features/donate/donate.dart'
    show DonorModel, RecipientModel;
import 'package:loading_overlay/loading_overlay.dart';

class SelectNgoScreen extends ConsumerStatefulWidget {
  const SelectNgoScreen({super.key});

  @override
  ConsumerState<SelectNgoScreen> createState() => _SelectNgoScreenState();
}

class _SelectNgoScreenState extends ConsumerState<SelectNgoScreen> {
  List<RecipientModel> ngos = [];
  List<DonorModel> donors = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadNgo();
    });
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: false,
      child: Column(
        children: [
          SearchableDropdown(
            ngoNames: donors,
            onChange: (newDonor) {
              if (newDonor?.id != null) {
                ref
                    .read(donationControllerProvider.notifier)
                    .setCurrentSelectDonor(newDonor!.id!);
              }
            },
            title: 'Select A Donor',
          ),
          SearchableDropdown(
            ngoNames: ngos,
            onChange: (newRecipient) {
              if (newRecipient?.id != null) {
                ref
                    .read(donationControllerProvider.notifier)
                    .setCurrentSelectNgo(newRecipient!.id!);
              }
            },
            title: 'Select A NGO',
          ),
          Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              if (ref.watch(donationControllerProvider).selectedRecipientId !=
                  -1) {
                final state = ref.watch(donationControllerProvider);
                final currentSelectedRecipient = ngos.firstWhere(
                  (element) => element.id == state.selectedRecipientId,
                );
                return Column(
                  children: [
                    Text(
                      "NGO Details:",
                      style: TextStyle(
                        fontSize: 22.h,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(
                        horizontal: 100.w,
                      ),
                      children: [
                        buildListTile(
                          icon: Icons.person,
                          title: "Name",
                          description: currentSelectedRecipient.ngoName,
                        ),
                        buildListTile(
                          icon: Icons.ac_unit_outlined,
                          title: "Profile",
                          description: currentSelectedRecipient.profile,
                        ),
                        buildListTile(
                          icon: Icons.group,
                          title: "Communities",
                          description:
                              currentSelectedRecipient.communitiesSupported,
                        ),
                        buildListTile(
                          icon: Icons.water,
                          title: "Water Demand",
                          description: currentSelectedRecipient.waterDemand,
                        ),
                        buildListTile(
                          icon: Icons.wallet,
                          title: "Donation Received",
                          description:
                              currentSelectedRecipient.totalDonationReceived,
                        ),
                      ],
                    ),
                  ],
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }

  ListTile buildListTile({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(fontSize: 15.h, color: Colors.black),
      ),
      leading: Icon(icon),
      trailing: Text(
        description,
        style: TextStyle(fontSize: 15.h, color: Colors.black),
      ),
    );
  }

  void _loadNgo() async {
    ngos = await ref.read(backendRepoProvider).getNgosList();
    donors = await ref.read(backendRepoProvider).getDonorsList();
    ref.read(donationControllerProvider.notifier).setRecipientList(ngos);
    ref.read(donationControllerProvider.notifier).setDonorList(donors);
    setState(() {});
  }
}

class SearchableDropdown extends StatelessWidget {
  final List<dynamic> ngoNames;
  final void Function(dynamic newRecipient) onChange;
  final String title;

  const SearchableDropdown({
    super.key,
    required this.ngoNames,
    required this.onChange,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: DropdownSearch<dynamic>(
        items: ngoNames,
        dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            labelText: title,
            contentPadding: const EdgeInsets.fromLTRB(12, 12, 8, 0),
            border: const OutlineInputBorder(),
          ),
        ),
        itemAsString: (recipient) {
          try {
            return recipient.ngoName;
          } catch (e) {
            return recipient.companyName;
          }
        },
        popupProps: const PopupProps.menu(
          showSearchBox: true,
        ),
        onChanged: onChange,
      ),
    );
  }
}
