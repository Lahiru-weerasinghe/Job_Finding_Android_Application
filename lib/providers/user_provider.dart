import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:linkup/constants.dart';
import 'package:linkup/models/job_model.dart';
import 'package:linkup/models/post_model.dart';
import 'package:linkup/models/user_model.dart';
import 'package:http/http.dart' as http;

class UserProvider extends ChangeNotifier {
  User newUser = User.createConstructor(
    firstName: '',
    lastName: '',
    phoneNumber: '',
    email: '',
    position: '',
    password: '',
    profileImageURL:
        'https://firebasestorage.googleapis.com/v0/b/linkup-31422.appspot.com/o/images%2Fuser_profile_default.png?alt=media&token=c2575581-3695-44fa-a30e-02f795f6f669',
  );
  User modifyUser = User.updateConstructor(
    firstName: '',
    lastName: '',
    phoneNumber: '',
    email: '',
    position: '',
    password: '',
  );
  User logUser = User.loginConstructor(
    email: '',
    password: '',
  );
  User user = User(
    firstName: '',
    lastName: '',
    phoneNumber: '',
    email: '',
    password: '',
    profileImageURL: '',
    token: '',
    position: '',
    applications: [],
    educations: [],
    experiences: [],
    id: '',
    jobs: [],
    posts: [],
    skills: [],
  );
  final storage = const FlutterSecureStorage();

  // Create new user profile
  void create(BuildContext context) async {
    final response = await http.post(
      Uri.parse('$baseApi/user/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(
        <String, String>{
          'firstName': newUser.firstName,
          'lastName': newUser.lastName,
          'phoneNumber': newUser.phoneNumber,
          'password': newUser.password,
          'position': newUser.position,
          'email': newUser.email,
          'profileImageURL': newUser.profileImageURL,
        },
      ),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      var authData = User.fromCreateJson(data);
      final token = await storage.read(key: 'authToken');

      if (token != null) {
        await storage.deleteAll();
      }
      await storage.write(key: 'authToken', value: authData.token);
      await storage.write(key: 'userId', value: authData.id);

      // Get user profile
      getProfile(context);

      notifyListeners();
      Fluttertoast.showToast(
        msg: 'Success',
        backgroundColor: colorSuccessLight,
        textColor: colorTextPrimary,
      );
      Navigator.pushNamed(context, '/home');
    }
  }

  // User login
  void login(BuildContext context) async {
    final response = await http.post(
      Uri.parse('$baseApi/user/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(
        <String, String>{
          'email': logUser.email,
          'password': logUser.password,
        },
      ),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      var authData = User.fromJson(data);
      final token = await storage.read(key: 'authToken');

      if (token != null) {
        await storage.deleteAll();
      }
      await storage.write(key: 'authToken', value: authData.token);
      await storage.write(key: 'userId', value: authData.id);

      // Get user profile
      getProfile(context);

      notifyListeners();
      Fluttertoast.showToast(
        msg: 'Login Success',
        backgroundColor: colorSuccessLight,
        textColor: colorTextPrimary,
      );
      Navigator.pushNamed(context, '/home');
    } else {
      notifyListeners();
      Fluttertoast.showToast(
        msg: 'Login Failed',
        backgroundColor: colorErrorLight,
        textColor: colorTextPrimary,
      );
    }
  }

  // Get user profile
  Future<User> getProfile(BuildContext context) async {
    final authToken = await storage.read(key: 'authToken');
    final response = await http.get(
      Uri.parse('$baseApi/user/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': authToken,
      },
    );
    print('object' + response.statusCode.toString());
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      user = User.fromJson(data);
      notifyListeners();
      print(user.posts.length);
      return user;
    } else if (response.statusCode == 400) {
      Fluttertoast.showToast(msg: 'Authentication Failed');
      Navigator.pushNamedAndRemoveUntil(context, '/login', (router) => false);
      return null;
    } else {
      Fluttertoast.showToast(msg: 'Server Error');
      notifyListeners();
      return null;
    }
  }

  // Get user posts
  Future<List<Post>> getUserPosts(BuildContext context) async {
    User user = await getProfile(context);
    final List<Post> userPosts = [];
    print('object');
    if (user.posts.isNotEmpty) {
      final data = user.posts;
      for (Map<String, dynamic> post in data) {
        userPosts.add(Post.fromJson(post));
      }
      return userPosts;
    }
    notifyListeners();
    return [];
  }

  // Get user posts
  Future<List<Job>> getUserJobs(BuildContext context) async {
    User user = await getProfile(context);
    final List<Job> userJobs = [];
    print(user.jobs.isNotEmpty);
    if (user != null && user.jobs.isNotEmpty) {
      final data = user.jobs;
      for (Map<String, dynamic> job in data) {
        userJobs.add(Job.fromJson(job));
      }
      return userJobs;
    }
    notifyListeners();
    return [];
  }

  // Update user profile image
  void updateProfileImage(BuildContext context) async {
    final authToken = await storage.read(key: 'authToken');
    final response = await http.put(
      Uri.parse('$baseApi/user/edit'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': authToken,
      },
      body: jsonEncode(
        <String, String>{
          'Id': user.id,
          'profileImageURL': user.profileImageURL,
        },
      ),
    );

    if (response.statusCode == 200) {
      // Get updated user profile
      getProfile(context);

      notifyListeners();
      Fluttertoast.showToast(
        msg: 'Update Success',
        backgroundColor: colorSuccess,
        textColor: colorTextPrimary,
      );
    } else if (response.statusCode == 400) {
      Fluttertoast.showToast(
        msg: 'Authentication Failed',
        backgroundColor: colorError,
        textColor: colorTextPrimary,
      );
      notifyListeners();
    } else {
      Fluttertoast.showToast(
        msg: 'Server Error',
        backgroundColor: colorError,
        textColor: colorTextPrimary,
      );
      notifyListeners();
    }
  }

  // Update user profile
  Future<User> updateUser(BuildContext context) async {
    final authToken = await storage.read(key: 'authToken');
    final response = await http.put(
      Uri.parse('$baseApi/user/edit'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': authToken,
      },
      body: jsonEncode(
        <String, String>{
          'Id': modifyUser.id,
          'firstName': modifyUser.firstName,
          'lastName': modifyUser.lastName,
          'phoneNumber': modifyUser.phoneNumber,
          'position': modifyUser.position,
          'password': modifyUser.password,
          'email': modifyUser.email,
        },
      ),
    );

    if (response.statusCode == 200) {
      // Get updated user profile
      getProfile(context);

      notifyListeners();
      Fluttertoast.showToast(
        msg: 'Update Success',
        backgroundColor: colorSuccess,
        textColor: colorTextPrimary,
      );
      Navigator.pushNamed(context, '/home');
      return user;
    } else if (response.statusCode == 400) {
      Fluttertoast.showToast(
        msg: 'Authentication Failed',
        backgroundColor: colorError,
        textColor: colorTextPrimary,
      );
      notifyListeners();
      return null;
    } else {
      Fluttertoast.showToast(
        msg: 'Server Error',
        backgroundColor: colorError,
        textColor: colorTextPrimary,
      );
      notifyListeners();
      return null;
    }
  }

  void deleteUser(BuildContext context) async {
    var userId = user.id;
    final authToken = await storage.read(key: 'authToken');
    final response = await http.delete(
      Uri.parse('$baseApi/user/remove/$userId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': authToken,
      },
    );

    if (response.statusCode == 200) {
      await storage.deleteAll();
      Navigator.pushNamed(context, '/signup');
    } else if (response.statusCode == 400) {
      Fluttertoast.showToast(msg: 'Authentication Failed');
      notifyListeners();
      return null;
    } else {
      print(response.statusCode);
      Fluttertoast.showToast(msg: 'Server Error');
      notifyListeners();
      return null;
    }
  }
}
