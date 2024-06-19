import 'package:bwt_frontend/src/features/donate/controller/donation_controller.dart';
import 'package:bwt_frontend/src/features/donate/donate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectWaterQuantityScreen extends ConsumerStatefulWidget {
  const SelectWaterQuantityScreen({super.key});

  @override
  ConsumerState<SelectWaterQuantityScreen> createState() =>
      _SelectWaterQuantityScreenState();
}

class _SelectWaterQuantityScreenState
    extends ConsumerState<SelectWaterQuantityScreen> {
  int selectedQuantity = 0;
  TextEditingController amountController = TextEditingController();
  DonorModel? donor;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Donor Details:",
          style: TextStyle(
            fontSize: 22.h,
            fontWeight: FontWeight.bold,
          ),
        ),
        Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            if (donor == null) {
              final selectedDonor = ref
                  .watch(donationControllerProvider.notifier)
                  .getSelectedDonor();
              donor = selectedDonor;
            }

            return ListView(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(
                horizontal: 100.w,
              ),
              children: [
                buildListTile(
                  icon: Icons.person,
                  title: "Name",
                  description: donor?.companyName ?? "",
                ),
                buildListTile(
                  icon: Icons.wallet,
                  title: "Donor Relation",
                  description: donor?.donorType.name ?? "",
                ),
                buildListTile(
                  icon: Icons.wallet,
                  title: "Donation Allocation",
                  description: donor?.donationAllocation ?? "",
                ),
              ],
            );
          },
        ),
        buildSelector(),
      ],
    );
  }

  Widget buildSelector() {
    return SizedBox(
      height: 220.h,
      width: 430.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildQuantityButton(1000),
              buildQuantityButton(2000),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildQuantityButton(2500),
              SizedBox(
                height: 100.h,
                width: 200.w,
                child: TextFormField(
                  controller: amountController,
                  decoration: const InputDecoration(hintText: "Custom"),
                  onChanged: (value) => ref
                      .read(donationControllerProvider.notifier)
                      .setDonationAmount(int.parse(value)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildQuantityButton(int quantity) {
    return GestureDetector(
      onTap: () {
        ref
            .read(donationControllerProvider.notifier)
            .setDonationAmount(quantity);
        setState(() {
          selectedQuantity = quantity;
        });
      },
      child: Container(
        height: 100.h,
        width: 200.w,
        decoration: BoxDecoration(
          color:
              selectedQuantity == quantity ? Colors.grey : Colors.transparent,
          border: Border.all(color: Colors.grey, width: 5.h),
          borderRadius: BorderRadius.circular(15.h),
        ),
        child: Center(
          child: Text(
            "${quantity}L",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.h,
            ),
          ),
        ),
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
