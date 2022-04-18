import 'dart:convert';

import 'dart:developer';

import 'dart:io';

import 'package:camera/camera.dart';

class Report{
  int? id;
  dynamic type;
  dynamic user;
  String? title;
  String? location;
  String? description;
  String? imageUrl;
  XFile? image;
  String? status;
  String? createdAt;

  Report({
    this.id,
    this.type,
    this.user,
    this.title,
    this.location,
    this.description,
    this.imageUrl,
    this.image,
    this.status,
    this.createdAt,
  });

  factory Report.fromJson(String str){
    Map<String, dynamic> json = jsonDecode(str);
    return Report(
      id: json['id'],
      type: json['type'],
      user: json['user'],
      title: json['title'],
      location: json['location'],
      description: json['description'],
      imageUrl: json['image_url'],
      status: json['status'],
      createdAt: json['created_at'],
    );
  }

  factory Report.fromMap(Map<String, dynamic> json){
    return Report(
      id: json['id'],
      type: json['type'],
      user: json['user'],
      title: json['title'],
      location: json['location'],
      description: json['description'],
      imageUrl: json['image_url'],
      status: json['status'],
      createdAt: json['created_at'],
    );
  }

  Map<String, String> toMap(){
    return {
      'type': type,
      'title': title ?? '',
      'location': location ?? '',
      'description': description ?? '',
    };
  }

  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'type': type,
      'user': user,
      'title': title,
      'location': location,
      'description': description,
      'image_url': imageUrl,
      'status': status,
      'created_at': createdAt,
    };
  }

  static List<Report> fromJsonList(List<dynamic> jsonList){
    return jsonList.map((e) => Report.fromJson(e)).toList();
  }

  static List<Report> fromMapList(List<dynamic> mapList){
    return mapList.map((e) => Report.fromMap(e)).toList();
  }

  static List<Map<String, dynamic>> toJsonList(List<Report> reportList){
    return reportList.map((e) => e.toJson()).toList();
  }
}

class ReportsResponse{
  List<Report> reports;

  ReportsResponse({
    required this.reports,
  });

  factory ReportsResponse.fromJson(String str){
    Map<String, dynamic> json = jsonDecode(str);
    return ReportsResponse(
      reports: Report.fromJsonList(json['reports']),
    );
  }

  factory ReportsResponse.fromMap(Map<String, dynamic> map){
    return ReportsResponse(
      reports: Report.fromMapList(map['reports']),
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'reports': Report.toJsonList(reports),
    };
  }
}