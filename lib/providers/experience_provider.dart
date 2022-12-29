import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:linkup/constants.dart';
import 'package:linkup/models/experience_model.dart';

class ExperienceProvider extends ChangeNotifier {
  List<Experience> experiences = [];
  FlutterSecureStorage storage = const FlutterSecureStorage();

  void addExperience(
    String position,
    String company,
    String description,
    BuildContext context,
  ) async {
    var userId = await storage.read(key: 'userId');
    var authToken = await storage.read(key: 'authToken');
    var response = await http.post(
      Uri.parse('$baseApi/experiences/user/$userId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': authToken,
      },
      body: jsonEncode(<String, String>{
        'position': position,
        'description': description,
        'companyName': company,
      }),
    );

    if (response.statusCode == 200) {
      getExperience(context);
      Navigator.pop(context);
      notifyListeners();
    } else if (response.statusCode == 400) {
      Fluttertoast.showToast(msg: 'Authentication Failed');
      Navigator.pushNamedAndRemoveUntil(context, '/login', (router) => false);
    } else {
      Fluttertoast.showToast(msg: 'Server Error');
      notifyListeners();
    }
  }

  Future<List<Experience>> getExperience(BuildContext context) async {
    var authToken = await storage.read(key: 'authToken');
    var response = await http.get(
      Uri.parse('$baseApi/experiences/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': authToken,
      },
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body) as List;
      List<Experience> experiences = [];

      for (Map<String, dynamic> experience in data) {
        experiences.add(Experience.fromJson(experience));
      }
      notifyListeners();
      return experiences;
    } else if (response.statusCode == 400) {
      Fluttertoast.showToast(msg: 'Authentication Failed');
      Navigator.pushNamedAndRemoveUntil(context, '/login', (router) => false);
      return [];
    } else {
      Fluttertoast.showToast(msg: 'Server Error');
      notifyListeners();
      return [];
    }
  }
}
