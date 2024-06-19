import 'dart:convert';
import 'package:bwt_frontend/src/features/donate/model/donation_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final chaincodeRepoProvider = Provider((_) => ChaincodeRepository());

class ChaincodeRepository {
  final String _baseUrl = 'http://localhost:3000/api';
  final String _identityLabel = 'User1@org1.example.com';
  final Dio _dio = Dio();


  Future<bool> sendDonation(DonationModel donationModel) async {
    _dio.options.baseUrl = 'http://localhost:3000/api';

    try {
      final response = await _dio.post(
        '/send-donation',
        data: {
          "functionName": "createDonation",
          "args": [
            donationModel.donationId,
            donationModel.donorId,
            donationModel.recipientId,
            donationModel.amount,
          ]
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'identitylabel': 'User1@org1.example.com', // Add your required headers here
          },
        ),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.data);
        return !jsonResponse.containsKey("error");
      } else {
        print('Failed to send donation: ${response.data}');
        return false;
      }
    } on DioException catch (e) {
      print('Error sending donation: $e');
      return false;
    }
  }

  Future<DonationModel?> getDonation(String donationId) async {
    final String url = '$_baseUrl/query-donation/$donationId';
    final headers = {
      'identityLabel': _identityLabel,
    };

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        return DonationModel.fromJson(jsonResponse["transaction"]);
      } else {
        print('Failed to get donation: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error getting donation: $e');
      return null;
    }
  }
}
