import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bwt_frontend/src/features/donate/donate.dart'
    show RecipientModel;

class SelectNgoScreen extends StatefulWidget {
  const SelectNgoScreen({super.key});

  @override
  State<SelectNgoScreen> createState() => _SelectNgoScreenState();
}

class _SelectNgoScreenState extends State<SelectNgoScreen> {
  List<RecipientModel> recipientList = [];
  RecipientModel? currentSelectedRecipient;

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    final recipient1 = RecipientModel(
      ngoName: "Hope for Tomorrow",
      profile: "Education and Healthcare",
      phone: "(555) 555-1234",
      email: "hope@tomorrow.org",
      address: "123 Main Street, Anytown, CA 12345",
      contactPerson: "Sarah Jones",
      dateRegistered: DateTime.now(),
      communitiesSupported: "Low-income families, Children",
      waterDemand: "High",
      totalDonationReceived: "\$10,000",
    );

    final recipient2 = RecipientModel(
      ngoName: "Clean Water Initiative",
      profile: "Water Sanitation and Hygiene",
      phone: "(555) 555-5678",
      email: "cleanwater@initiative.org",
      address: "456 Elm Street, Anytown, CA 98765",
      contactPerson: "David Lee",
      dateRegistered: DateTime.now(),
      communitiesSupported: "Rural communities",
      waterDemand: "Critical",
      totalDonationReceived: "\$5,000",
    );

    final recipient3 = RecipientModel(
      ngoName: "Animal Shelter Network",
      profile: "Animal Welfare",
      phone: "(555) 555-9012",
      email: "animalshelter@network.com",
      address: "789 Oak Street, Anytown, NY 54321",
      contactPerson: "Maria Garcia",
      dateRegistered: DateTime.now().subtract(const Duration(days: 30)),
      // 30 days ago
      communitiesSupported: "Abandoned pets",
      waterDemand: "Moderate",
      totalDonationReceived: "\$2,000",
    );

    final List<RecipientModel> recipientList = [
      recipient1,
      recipient2,
      recipient3,
    ];

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: deviceWidth > 900 ? 300.w : 100.w,
      ),
      child: Column(
        children: [
          SearchableDropdown(
            ngoNames: recipientList,
            onChange: (newRecipient) {
              setState(() {
                currentSelectedRecipient = newRecipient;
              });

              print(currentSelectedRecipient?.ngoName);
            },
          ),
          if (currentSelectedRecipient != null)
            ListView(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(
                horizontal: 100.w,
              ),
              children: [
                buildListTile(
                  icon: Icons.person,
                  title: "Name",
                  description: currentSelectedRecipient!.ngoName,
                ),
                buildListTile(
                  icon: Icons.ac_unit_outlined,
                  title: "Profile",
                  description: currentSelectedRecipient!.profile,
                ),
                buildListTile(
                  icon: Icons.group,
                  title: "Communities",
                  description: currentSelectedRecipient!.communitiesSupported,
                ),
                buildListTile(
                  icon: Icons.water,
                  title: "Water Demand",
                  description: currentSelectedRecipient!.waterDemand,
                ),
                buildListTile(
                  icon: Icons.wallet,
                  title: "Donation Received",
                  description: currentSelectedRecipient!.totalDonationReceived,
                ),
              ],
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
}

class SearchableDropdown extends StatelessWidget {
  final List<RecipientModel> ngoNames;
  final void Function(RecipientModel? newRecipient) onChange;

  const SearchableDropdown({
    super.key,
    required this.ngoNames,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: DropdownSearch<RecipientModel>(
        items: ngoNames,
        dropdownDecoratorProps: const DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            labelText: "Select a Recipient",
            contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
            border: OutlineInputBorder(),
          ),
        ),
        itemAsString: (recipient) => recipient.ngoName,
        popupProps: const PopupProps.menu(
          showSearchBox: true,
        ),
        onChanged: onChange,
      ),
    );
  }
}
