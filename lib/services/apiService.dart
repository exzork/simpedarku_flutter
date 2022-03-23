import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:simpedarku/models/user.dart';
import 'package:localstorage/localstorage.dart';
import 'package:simpedarku/services/apiResponse.dart';

import '../models/reports.dart';

class ApiService {
  static const String baseUrl = "https://simpedarku-dev.exzork.me";
  static final LocalStorage storage = LocalStorage('simpedarku');

  static http.Client client = http.Client();


  static Map<String,String> headers = {
    'Accept' : 'application/json'
  };

  static Future<Map<String, String>> headersWithToken() async {
    await storage.ready.then((_) {
      String? token = storage.getItem('token');
      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }
    });
    return headers;
  }

  static Future<ApiResponse> login(String email, String password) async {
    final response = await client.post(Uri.parse(baseUrl + "/login"), body: {
      "email": email,
      "password": password,
    }, headers: headers);
    log(response.body);
    return ApiResponse.fromJson(response.body);
  }

  static Future<ApiResponse> register(String name, String email, String password) async {
    final response = await client.post(Uri.parse(baseUrl + "/register"), body: {
      "name": name,
      "email": email,
      "password": password,
    }, headers: headers);
    log(response.body);
    return ApiResponse.fromJson(response.body);
  }

  static Future<ApiResponse> logout() async {
    final response = await client.post(Uri.parse(baseUrl + "/logout"), headers: await headersWithToken());
    if(response.statusCode == 200) {
      await storage.setItem('token', null);
    }
    return ApiResponse.fromJson(response.body);
  }

  static Future<UserProfile?> getUser() async {
    final response = await client.get(Uri.parse(baseUrl + "/api/user/profile"),headers: await headersWithToken());
    log(response.body);
    ApiResponse apiResponse = ApiResponse.fromJson(response.body);
    UserProfileResponse? userProfileResponse;
    if(apiResponse.status == "success") {
      userProfileResponse = UserProfileResponse.fromMap(apiResponse.data);
    }
    return userProfileResponse?.userProfile;
  }

  static Future<bool> checkLogin() async {
    log("checkLogin");
    final response = await client.get(Uri.parse(baseUrl + "/api/user/profile"), headers: await headersWithToken());
    if (response.statusCode == 200) {
      log(response.body);
      return true;
    } else {
      log(response.body);
      return false;
    }
  }

  static Future<List<Report>> getReports() async {
    List<Report> reports = [];
    final response = await client.get(Uri.parse(baseUrl + "/api/reports"), headers: await headersWithToken());
    ApiResponse apiResponse = ApiResponse.fromJson(response.body);
    ReportsResponse? reportsResponse = ReportsResponse.fromMap(apiResponse.data);
    if(apiResponse.status == "success") {
      reports = reportsResponse.reports;
    }
    return reports;
  }
}