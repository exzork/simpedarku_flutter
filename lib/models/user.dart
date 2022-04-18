import 'dart:convert';

class User {
  int id;
  String name;
  String email;
  String apiToken;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.apiToken,
  });

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    apiToken: json["api_token"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "email": email,
    "api_token": apiToken,
  };
}

class UserProfile{
  int? id;
  String? name;
  String? email;
  int? isAdmin;
  int? isStakeholder;
  String? stakeholderId;
  String? gender;
  String? nik;
  String? address;
  String? bloodType;
  String? phone;
  String? emergencyContact;
  String? password;
  String? passwordConfirmation;
  String? currentPassword;

  UserProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.isAdmin,
    required this.isStakeholder,
    required this.stakeholderId,
    required this.gender,
    required this.nik,
    required this.address,
    required this.bloodType,
    required this.phone,
    required this.emergencyContact
  });

  factory UserProfile.fromJson(String str) => UserProfile.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserProfile.fromMap(Map<String, dynamic> json) => UserProfile(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    isAdmin: json["is_admin"],
    isStakeholder: json["is_stakeholder"],
    stakeholderId: json["stakeholder_id"],
    gender: json['gender'],
    nik: json['nik'],
    address: json['address'],
    bloodType: json['blood_type'],
    phone: json['phone'],
    emergencyContact: json['emergency_contact'],
  );

  Map<String, dynamic> toMap()=>{
    "email": email,
    "address": address,
    "blood_type": bloodType,
    "phone": phone,
    "emergency_contact": emergencyContact,
    "password": password,
    "password_confirmation": passwordConfirmation,
    "current_password": currentPassword
  };
}

class UserResponse{
  User? user;

  UserResponse({
    required this.user
  });

  factory UserResponse.fromJson(String str) => UserResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserResponse.fromMap(Map<String, dynamic> json) => UserResponse(
    user: json["user"] == null ? null : User.fromMap(json["user"]),
  );

  Map<String, dynamic> toMap() => {
    "user": user?.toMap(),
  };

  @override
  String toString() {
    return toMap().toString();
  }
}

class UserProfileResponse{
  UserProfile? userProfile;

  UserProfileResponse({
    required this.userProfile
  });

  factory UserProfileResponse.fromJson(String str) => UserProfileResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserProfileResponse.fromMap(Map<String, dynamic> json) => UserProfileResponse(
    userProfile: json["user"] == null ? null : UserProfile.fromMap(json["user"]),
  );

  Map<String, dynamic> toMap() => {
    "user": userProfile?.toMap(),
  };

  @override
  String toString() {
    return toMap().toString();
  }
}

class UserLogin{
  String? email;
  String? password;

  UserLogin({
    required this.email,
    required this.password
  });

  factory UserLogin.fromJson(String str) => UserLogin.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserLogin.fromMap(Map<String, dynamic> json) => UserLogin(
    email: json["email"],
    password: json["password"],
  );

  Map<String, dynamic> toMap() => {
    "email": email,
    "password": password,
  };

  @override
  String toString() {
    return toMap().toString();
  }
}

class UserRegister{
  String? name;
  String? gender;
  String? nik;
  String? address;
  String? bloodType;
  String? emergencyContact;
  String? email;
  String? phone;
  String? password;
  String? passwordConfirmation;

  UserRegister({
    required this.name,
    required this.gender,
    required this.nik,
    required this.address,
    required this.bloodType,
    required this.emergencyContact,
    required this.email,
    required this.phone,
    required this.password,
    required this.passwordConfirmation
  });

  factory UserRegister.fromJson(String str) => UserRegister.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserRegister.fromMap(Map<String, dynamic> json) => UserRegister(
    name: json["name"],
    gender: json["gender"],
    nik: json["nik"],
    address: json["address"],
    bloodType: json["blood_type"],
    emergencyContact: json["emergency_contact"],
    email: json["email"],
    phone: json["phone"],
    password: json["password"],
    passwordConfirmation: json["password_confirmation"],
  );

  Map<String, dynamic> toMap() => {
    "name": name,
    "gender": gender,
    "nik": nik,
    "address": address,
    "blood_type": bloodType,
    "emergency_contact": emergencyContact,
    "email": email,
    "phone": phone,
    "password": password,
    "password_confirmation": passwordConfirmation,
  };

  @override
  String toString() {
    return toMap().toString();
  }
}