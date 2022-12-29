import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:linkup/constants.dart';
import 'package:linkup/models/job_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class JobProvider extends ChangeNotifier {
  Job job = Job.createJobConstructor(
    companyLogo:
        'https://firebasestorage.googleapis.com/v0/b/linkup-31422.appspot.com/o/images%2FcompanyLogo.jpg?alt=media&token=94afb198-e5c9-417c-bf1b-e729b0a3576e',
    companyName: '',
    position: '',
    id: '',
    salary: '',
    jobImage: '',
    description: '',
  );
  List<Job> jobs = [];
  final storage = const FlutterSecureStorage();

  Future createJob(
    BuildContext context,
  ) async {
    var userId = await storage.read(key: 'userId');
    var authToken = await storage.read(key: 'authToken');

    final response = await http.post(
      Uri.parse('$baseApi/jobs/user/$userId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': authToken,
      },
      body: jsonEncode(
        <String, String>{
          'companyLogo': job.companyLogo,
          'companyName': job.companyName,
          'jobImage': job.jobImage,
          'position': job.position,
          'salary': job.salary,
          'description': job.description,
        },
      ),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      job = Job.fromJson(data);
      jobs.add(job);
      job.companyLogo = '';
      job.companyName = '';
      job.position = '';
      job.salary = '';
      job.description = '';
      job.jobImage = '';
      notifyListeners();
    } else if (response.statusCode == 400) {
      Fluttertoast.showToast(msg: 'Authentication Failed');
      Navigator.pushNamed(context, '/login');
      notifyListeners();
    } else {
      Fluttertoast.showToast(msg: 'Server Error');
      notifyListeners();
    }
  }

  Future<List<Job>> getJobs() async {
    final response = await http.get(
      Uri.parse('$baseApi/jobs/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      jobs.clear();
      final data = jsonDecode(response.body) as List;

      for (Map<String, dynamic> job in data) {
        jobs.add(Job.fromJson(job));
      }

      notifyListeners();
      return jobs;
    } else {
      Fluttertoast.showToast(msg: 'Server Error');
      notifyListeners();
      return null;
    }
  }

  void deleteJob(BuildContext context, String jobId) async {
    var userId = await storage.read(key: 'userId');
    var authToken = await storage.read(key: 'authToken');
    final response = await http.delete(
      Uri.parse('$baseApi/jobs/remove/$userId/$jobId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': authToken,
      },
    );

    if (response.statusCode == 200) {
      notifyListeners();
    } else if (response.statusCode == 400) {
      Fluttertoast.showToast(msg: 'Authentication Failed');
      Navigator.pushNamed(context, '/login');
      notifyListeners();
    } else {
      Fluttertoast.showToast(msg: 'Server Error');
      notifyListeners();
    }
  }

  void updateJob(
    String id,
    String companyLogo,
    String jobImage,
    String description,
    String position,
    String salary,
    String companyName,
    BuildContext context,
  ) async {
    var authToken = await storage.read(key: 'authToken');
    final response = await http.put(
      Uri.parse('$baseApi/jobs/edit/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': authToken,
      },
      body: jsonEncode(
        <String, String>{
          'companyLogo': companyLogo,
          'jobImage': jobImage,
          'description': description,
          'position': position,
          'salary': salary,
          'companyName': companyName,
        },
      ),
    );

    if (response.statusCode == 200) {
      Navigator.pop(context);
      notifyListeners();
    } else if (response.statusCode == 400) {
      Fluttertoast.showToast(msg: 'Authentication Failed');
      Navigator.pushNamed(context, '/login');
      notifyListeners();
    } else {
      Fluttertoast.showToast(msg: 'Server Error');
      notifyListeners();
    }
  }
}
