import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:bwt_frontend/src/features/donate/donate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final backendRepoProvider = Provider((_) => BackendRepository());

class BackendRepository {
  Future<bool> registerNgo(RecipientModel ngo) async {
    final String url = 'http://localhost:3001/registration/recipients/register';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(ngo.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Registration successful
        return true;
      } else {
        // Registration failed
        print('Failed to register NGO: ${response.body}');
        return false;
      }
    } on Exception catch (e) {
      // Handle any exceptions that occur during the request
      print('Error registering NGO: $e');
      return false;
    }
  }

  Future<List<RecipientModel>> getNgosList() async {
    final String url = 'http://localhost:3001/registration/recipients?size=20';
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        List<RecipientModel> list = [];
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        jsonResponse["transactions"].forEach((e) {
          list.add(RecipientModel.fromJson(e));
        });
        return list;
      } else {
        print('Failed to load NGOs: ${response.body}');
        return [];
      }
    } on Exception catch (e) {
      print('Error loading NGOs: $e');
      return [];
    }
  }

  Future<bool> registerDonor(DonorModel donor) async {
    final String url = 'http://localhost:3001/registration/donors/register';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(donor.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        print('Failed to register donor: ${response.body}');
        return false;
      }
    } on Exception catch (e) {
      print('Error registering donor: $e');
      return false;
    }
  }

  Future<List<DonorModel>> getDonorsList() async {
    final String url = 'http://localhost:3001/registration/donors?size=20';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<DonorModel> list = [];
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        jsonResponse["transactions"].forEach((e) {
          list.add(DonorModel.fromJson(e));
        });
        return list;
      } else {
        print('Failed to load donors: ${response.body}');
        return [];
      }
    } on Exception catch (e) {
      print('Error loading donors: $e');
      return [];
    }
  }

  Future<RecipientModel?> getNgoById(String id) async {
    final String url = 'http://localhost:3001/registration/recipients/$id';
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return RecipientModel.fromJson(jsonResponse);
      } else {
        print('Failed to load NGO: ${response.body}');
        return null;
      }
    } on Exception catch (e) {
      print('Error loading NGO: $e');
      return null;
    }
  }

  Future<DonorModel?> getDonorById(String id) async {
    final String url = 'http://localhost:3001/registration/donors/$id';
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return DonorModel.fromJson(jsonResponse);
      } else {
        print('Failed to load donor: ${response.body}');
        return null;
      }
    } on Exception catch (e) {
      print('Error loading donor: $e');
      return null;
    }
  }
}
