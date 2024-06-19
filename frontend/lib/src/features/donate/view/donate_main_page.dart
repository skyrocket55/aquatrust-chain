import 'dart:math';

import 'package:bwt_frontend/src/features/donate/controller/donation_controller.dart';
import 'package:bwt_frontend/src/features/donate/donate.dart';
import 'package:bwt_frontend/src/features/donate/model/donation_model.dart';
import 'package:bwt_frontend/src/features/donate/repo/chaincode_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DonateMainPage extends ConsumerStatefulWidget {
  const DonateMainPage({super.key});

  @override
  ConsumerState<DonateMainPage> createState() => _DonateMainPageState();
}

class _DonateMainPageState extends ConsumerState<DonateMainPage> {
  int currentIndex = 0;
  int count = 3;
  List<String> pageTitle = ["Select NGO", "Select Water Quantity", "Confirm"];
  PageController donationPageController = PageController();

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 500.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: pageTitle.map((e) {
                  return Text(
                    e,
                    style: TextStyle(
                      fontWeight: pageTitle[currentIndex] == e
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: deviceWidth > 900 ? 300.w : 100.w,
              ),
              child: PageView(
                controller: donationPageController,
                scrollDirection: Axis.horizontal,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  SelectNgoScreen(),
                  SelectWaterQuantityScreen(),
                  ConfirmDonationScreen(),
                  FinishDonationScreen()
                ],
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              print("hello");
              if (currentIndex < count - 1) {
                print("hiii");
                if (currentIndex == 1) {
                  print(ref.watch(donationControllerProvider).donationAmount);
                }
                donationPageController.nextPage(
                  duration: const Duration(milliseconds: 100),
                  curve: Curves.linear,
                );
                setState(() => currentIndex++);
              } else {
                print("here");
                final ranId = Random.secure().nextInt(100).toString();
                await ref.read(chaincodeRepoProvider).sendDonation(
                      DonationModel(
                        amount:
                            ref.read(donationControllerProvider).donationAmount,
                        donationId: ranId,
                        donorId: ref
                            .read(donationControllerProvider)
                            .selectedDonorId
                            .toString(),
                        recipientId: ref
                            .read(donationControllerProvider)
                            .selectedRecipientId
                            .toString(),
                      ),
                    );
                final donation =
                    await ref.read(chaincodeRepoProvider).getDonation("don3");
                if (donation != null) {
                  print(donation);
                  ref
                      .read(donationControllerProvider.notifier)
                      .setDonation(donation);
                } else {
                  print("error");
                }
              }
            },
            child: Text(currentIndex != 2 ? "Next" : "Confirm"),
          ),
          TextButton(
            onPressed: () {
              if (currentIndex > 0) {
                donationPageController.previousPage(
                  duration: const Duration(milliseconds: 100),
                  curve: Curves.linear,
                );
                setState(() => currentIndex--);
              }
            },
            child: const Text("Back"),
          ),
        ],
      ),
    );
  }
}
