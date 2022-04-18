class ErrorResponse{
  List<String> errors = [];

  ErrorResponse({required this.errors});

  ErrorResponse.fromJson(Map<String, dynamic> json){
    errors = json['errors'];
  }

  ErrorResponse.fromMap(Map<String, dynamic> map){
    errors = map['errors'].cast<String>();
  }

  Map<String, dynamic> toJson(){
    final Map<String, String> data = <String, String>{};
    data['errors'] = errors as String;
    return data;
  }

  Map<String, dynamic> toMap(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['errors'] = errors;
    return data;
  }
}