import 'package:bwt_frontend/src/features/donate/controller/donation_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConfirmDonationScreen extends ConsumerStatefulWidget {
  const ConfirmDonationScreen({super.key});

  @override
  ConsumerState<ConfirmDonationScreen> createState() =>
      _ConfirmDonationScreenState();
}

class _ConfirmDonationScreenState extends ConsumerState<ConfirmDonationScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer(
          builder: (context, ref, child) {
            final selectedDonor = ref
                .read(donationControllerProvider.notifier)
                .getSelectedDonor();
            final selectedNgo = ref
                .read(donationControllerProvider.notifier)
                .getSelectedRecipient();
            final quantity = ref.read(donationControllerProvider).donationAmount;
            return ListView(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(
                horizontal: 100.w,
              ),
              children: [
                buildListTile(
                  icon: Icons.person,
                  title: "Donor",
                  description: selectedDonor.companyName,
                ),
                buildListTile(
                  icon: Icons.group,
                  title: "NGO",
                  description: selectedNgo.ngoName,
                ),
                buildListTile(
                  icon: Icons.water,
                  title: "Quantity",
                  description: "${quantity}L",
                ),
              ],
            );
          },
        ),
      ],
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
