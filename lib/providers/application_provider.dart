import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:linkup/constants.dart';
import 'package:linkup/models/application_model.dart';

class ApplicationProvider extends ChangeNotifier {
  final storage = const FlutterSecureStorage();

  void createApplication(
    BuildContext context,
    String jobId,
    String applicantName,
    String nic,
    String phoneNumber,
    String university,
    String skills,
    String languages,
    String linkedIn,
    String gitHub,
  ) async {
    var userId = await storage.read(key: 'userId');
    var authToken = await storage.read(key: 'authToken');
    var response = await http.post(
      Uri.parse('$baseApi/applications/user/$userId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': authToken,
      },
      body: jsonEncode(
        <String, String>{
          'jobId': jobId,
          'applicantName': applicantName,
          'nic': nic,
          'contactNumber': phoneNumber,
          'university': university,
          'skills': skills,
          'languages': languages,
          'linkedIn': linkedIn,
          'github': gitHub,
        },
      ),
    );

    if (response.statusCode == 200) {
      Fluttertoast.showToast(
        msg: 'Application Sent',
        backgroundColor: colorSuccess,
        textColor: colorTextPrimary,
      );
      notifyListeners();
      // Navigator.pushNamed(context, '/home');
    } else if (response.statusCode == 400) {
      Fluttertoast.showToast(msg: 'Authentication Failed');
      Navigator.pushNamed(context, '/login');
      notifyListeners();
    } else {
      Fluttertoast.showToast(msg: 'Server Error');
      notifyListeners();
    }
  }

  Future<List<Application>> getUserApplications(BuildContext context) async {
    List<Application> userApplications = [];
    var userId = await storage.read(key: 'userId');
    var authToken = await storage.read(key: 'authToken');
    print(userId);
    var response = await http.get(
      Uri.parse('$baseApi/applications/user/$userId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': authToken,
      },
    );

    if (response.statusCode == 200) {
      final applications = jsonDecode(response.body) as List;

      for (Map<String, dynamic> application in applications) {
        userApplications.add(Application.fromJson(application));
      }
      return userApplications;
    } else if (response.statusCode == 400) {
      Fluttertoast.showToast(msg: 'Authentication Failed');
      Navigator.pushNamed(context, '/login');
      notifyListeners();
      return [];
    } else {
      Fluttertoast.showToast(msg: 'Server Error');
      notifyListeners();
      return [];
    }
  }

  void updateApplication(
    BuildContext context,
    String applicationId,
    String applicantName,
    String nic,
    String phoneNumber,
    String university,
    String skills,
    String languages,
    String linkedIn,
    String gitHub,
  ) async {
    var authToken = await storage.read(key: 'authToken');
    var response = await http.put(
      Uri.parse('$baseApi/applications/edit/$applicationId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': authToken,
      },
      body: jsonEncode(<String, String>{
        'applicantName': applicantName,
        'nic': nic,
        'contactNumber': phoneNumber,
        'university': university,
        'skills': skills,
        'languages': languages,
        'linkedIn': linkedIn,
        'github': gitHub,
      }),
    );

    if (response.statusCode == 200) {
      Navigator.pop(context);
      notifyListeners();
    } else if (response.statusCode == 400) {
      Fluttertoast.showToast(msg: 'Authentication Failed');
      Navigator.pushNamed(context, '/login');
      notifyListeners();
      return null;
    } else {
      Fluttertoast.showToast(msg: 'Server Error');
      notifyListeners();
      return null;
    }
  }

  void deleteApplication(
    BuildContext context,
    String applicationId,
  ) async {
    var userId = await storage.read(key: 'userId');
    var authToken = await storage.read(key: 'authToken');
    var response = await http.delete(
      Uri.parse('$baseApi/applications/remove/$userId/$applicationId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': authToken,
      },
    );

    if (response.statusCode == 200) {
      getUserApplications(context);
      notifyListeners();
    } else if (response.statusCode == 400) {
      Fluttertoast.showToast(msg: 'Authentication Failed');
      Navigator.pushNamed(context, '/login');
      notifyListeners();
      return null;
    } else {
      Fluttertoast.showToast(msg: 'Server Error');
      notifyListeners();
      return null;
    }
  }
}
