import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simpedarku/models/error.dart';
import 'package:simpedarku/models/user.dart';
import 'package:simpedarku/services/apiResponse.dart';

import '../services/apiService.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);


  @override
  _ProfileViewState createState() => _ProfileViewState();

}
class _ProfileViewState extends State<ProfileView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _nikController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _bloodTypeController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _emergencyContactController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController = TextEditingController();
  final TextEditingController _currentPasswordController = TextEditingController();

  UserProfile? userProfile;

  @override
  initState() {
    _loadUserProfile();
    super.initState();
  }

  _loadUserProfile() async {
    userProfile = await ApiService.getUser();
    if (userProfile != null) {
      _nameController.text = userProfile?.name ?? "";
      _nikController.text = userProfile?.nik ?? "";
      _genderController.text = userProfile?.gender ?? "";
      _addressController.text = userProfile?.address ?? "";
      _emergencyContactController.text = userProfile?.emergencyContact ?? "";
      _emailController.text = userProfile?.email ?? "";
      _phoneController.text = userProfile?.phone ?? "";
      _bloodTypeController.text = userProfile?.bloodType?? "";
    }
  }

  _saveUserProfile() async {
    userProfile?.address = _addressController.text;
    userProfile?.emergencyContact = _emergencyContactController.text;
    userProfile?.email = _emailController.text;
    userProfile?.phone = _phoneController.text;
    userProfile?.password = _passwordController.text;
    userProfile?.passwordConfirmation = _passwordConfirmController.text;
    userProfile?.currentPassword = _currentPasswordController.text;

    ApiResponse apiResponse = await ApiService.updateUser(userProfile!);
    if(apiResponse.status == "success") {
      userProfile = null;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Success"),
            content: Text("Profile has been updated"),
            actions: <Widget>[
              TextButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        }
      );
    }else{
      showDialog(
        context: context,
        builder: (BuildContext context) {
          ErrorResponse errorResponse = ErrorResponse.fromMap(apiResponse.data);
          return AlertDialog(
            title: Text("Error"),
            content: Text(errorResponse.errors.join("\n")),
            actions: <Widget>[
              TextButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        }
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[600],
        title: Text('Profile'),
      ),
      body: Container(
          padding: const EdgeInsets.all(10),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: TextField(
                  controller: _nameController,
                  enabled: false,
                  style: TextStyle(color: Colors.grey[600]),
                  decoration: InputDecoration(
                    label: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[200],
                      ),
                      padding: const EdgeInsets.all(5),
                      child: const Text(
                        "Nama Lengkap",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    hoverColor: Colors.white,
                    fillColor: Colors.grey[200],
                    filled: true,
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: TextField(
                  controller: _nikController,
                  enabled: false,
                  style: TextStyle(color: Colors.grey[600]),
                  decoration: InputDecoration(
                    label: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[200],
                      ),
                      padding: const EdgeInsets.all(5),
                      child: const Text(
                        "NIK",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    hoverColor: Colors.white,
                    fillColor: Colors.grey[200],
                    filled: true,
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: TextField(
                  controller: _genderController,
                  enabled: false,
                  style: TextStyle(color: Colors.grey[600]),
                  decoration: InputDecoration(
                    label: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[200],
                      ),
                      padding: const EdgeInsets.all(5),
                      child: const Text(
                        "Jenis Kelamin",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    hoverColor: Colors.white,
                    fillColor: Colors.grey[200],
                    filled: true,
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: TextField(
                  controller: _bloodTypeController,
                  enabled: false,
                  style: TextStyle(color: Colors.grey[600]),
                  decoration: InputDecoration(
                    label: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[200],
                      ),
                      padding: const EdgeInsets.all(5),
                      child: const Text(
                        "Golongan Darah",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    hoverColor: Colors.white,
                    fillColor: Colors.grey[200],
                    filled: true,
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              Container(
                height: 1,
                color: Colors.grey[200],
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: TextField(
                  controller: _addressController,
                  decoration: InputDecoration(
                    label: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[200],
                      ),
                      padding: const EdgeInsets.all(5),
                      child: const Text(
                        "Alamat",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    hoverColor: Colors.white,
                    fillColor: Colors.grey[200],
                    filled: true,
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: TextField(
                  controller: _emergencyContactController,
                  decoration: InputDecoration(
                    label: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[200],
                      ),
                      padding: const EdgeInsets.all(5),
                      child: const Text(
                        "Kontak Darurat",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    hoverColor: Colors.white,
                    fillColor: Colors.grey[200],
                    filled: true,
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    label: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[200],
                      ),
                      padding: const EdgeInsets.all(5),
                      child: const Text(
                        "Email",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    hoverColor: Colors.white,
                    fillColor: Colors.grey[200],
                    filled: true,
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: TextField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    label: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[200],
                      ),
                      padding: const EdgeInsets.all(5),
                      child: const Text(
                        "No Handphone",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    hoverColor: Colors.white,
                    fillColor: Colors.grey[200],
                    filled: true,
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    label: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[200],
                      ),
                      padding: const EdgeInsets.all(5),
                      child: const Text(
                        "Ubah Password",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    hoverColor: Colors.white,
                    fillColor: Colors.grey[200],
                    filled: true,
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: TextField(
                  controller: _passwordConfirmController,
                  obscureText: true,
                  decoration: InputDecoration(
                    label: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[200],
                      ),
                      padding: const EdgeInsets.all(5),
                      child: const Text(
                        "Konfirmasi Password",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    hoverColor: Colors.white,
                    fillColor: Colors.grey[200],
                    filled: true,
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              Container(
                height: 1,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: TextField(
                  controller: _currentPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    label: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[200],
                      ),
                      padding: const EdgeInsets.all(5),
                      child: const Text(
                        "Password Sekarang",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    hoverColor: Colors.white,
                    fillColor: Colors.grey[200],
                    filled: true,
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red[600],
                    minimumSize: const Size.fromHeight(50),
                  ),
                  onPressed: () async =>{ await _saveUserProfile()},
                  child: const Text(
                    "Simpan",
                    style: TextStyle(color: Colors.white),
                  ),
              )
            ],
          ),
        )
    );
  }
}