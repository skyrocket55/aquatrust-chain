import 'package:bwt_frontend/src/features/authentication/view/login_screen.dart';
import 'package:bwt_frontend/src/features/authentication/view/ngo_registration_screen.dart';
import 'package:bwt_frontend/src/features/donate/donate.dart';
import 'package:bwt_frontend/src/features/donate/view/donate_main_page.dart';
import 'package:flutter/material.dart';


class Routing {
  static const String loginScreen = '/';
  static const String ngoRegistrationScreen = '/ngoRegistration';
  static const String donateMainPage = '/donateMainPage';
  static const String selectNgoScreen = '/selectNgoScreen';
  static const String selectWaterQtyScreen = '/selectWaterQtyScreen';
  static const String confirmDonationScreen = '/confirmDonationScreen';
  static const String finishDonationScreen = '/finishDonationScreen';

  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginScreen:
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
          settings: const RouteSettings(
            name: loginScreen,
          ),
        );
      case donateMainPage:
        return MaterialPageRoute(
          builder: (context) => const DonateMainPage(),
          settings: const RouteSettings(
            name: donateMainPage,
          ),
        );
      case ngoRegistrationScreen:
        return MaterialPageRoute(
          builder: (context) => const NgoRegistrationScreen(),
          settings: const RouteSettings(
            name: ngoRegistrationScreen,
          ),
        );
      case selectNgoScreen:
        return MaterialPageRoute(
          builder: (context) => const SelectNgoScreen(),
          settings: const RouteSettings(
            name: selectNgoScreen,
          ),
        );
      case selectWaterQtyScreen:
        return MaterialPageRoute(
          builder: (context) => const SelectWaterQuantityScreen(),
          settings: const RouteSettings(
            name: selectWaterQtyScreen,
          ),
        );
      case confirmDonationScreen:
        return MaterialPageRoute(
          builder: (context) => const ConfirmDonationScreen(),
          settings: const RouteSettings(
            name: confirmDonationScreen,
          ),
        );
      case finishDonationScreen:
        return MaterialPageRoute(
          builder: (context) => const FinishDonationScreen(),
          settings: const RouteSettings(
            name: finishDonationScreen,
          ),
        );
      // case onBoarding:
      //   return MaterialPageRoute(
      //     builder: (context) => const GetStartedScreen(),
      //     settings: const RouteSettings(
      //       name: splashScreen,
      //     ),
      //   );
      default:
        throw Exception('Unknown route: ${settings.name}');
    }
  }
}
