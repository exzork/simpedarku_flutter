import 'dart:convert';

import 'dart:io';

class ApiResponse{
  String status;
  dynamic data;
  String message;

  ApiResponse({
    required this.status,
    required this.data,
    required this.message
  });

  factory ApiResponse.fromJson(String jsonString){
    Map<String, dynamic> json = jsonDecode(jsonString);
    return ApiResponse(
      status: json['status'],
      data: json['data'],
      message: json['message']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'status': status,
      'data': data,
      'message': message
    };
  }

  @override
  String toString(){
    return json.encode(toJson());
  }
}