import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:simpedarku/components/login.dart';
import 'package:simpedarku/models/user.dart';
import 'package:simpedarku/services/apiResponse.dart';
import 'package:simpedarku/services/apiService.dart';

import '../models/error.dart';
import 'home.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final LocalStorage storage = LocalStorage('simpedarku');

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _nikController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _emergencyContactController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  String _genderValue = "-- JENIS KELAMIN --";
  String _bloodTypeValue = "-- Golongan Darah --";

  register(context) async {
    UserRegister data = UserRegister(
        name: _nameController.text,
        nik: _nikController.text,
        address: _addressController.text,
        emergencyContact: _emergencyContactController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        password: _passwordController.text,
        passwordConfirmation: _confirmPasswordController.text,
        bloodType: _bloodTypeValue,
        gender: _genderValue);

    ApiResponse response = await ApiService.register(data);
    if (response.status == "success") {
      UserResponse userResponse = UserResponse.fromMap(response.data);
      User user = userResponse.user as User;
      await storage.ready.then((_) => storage.setItem("token", user.apiToken));
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (BuildContext context) => const HomeView()),
          (route) => false);
    } else {
      ErrorResponse errorResponse = ErrorResponse.fromMap(response.data);
      Alert(
              context: context,
              title: "Error",
              desc: errorResponse.errors.join("\n"))
          .show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
            child: Container(
                padding: const EdgeInsets.all(20),
                child: Image.asset("assets/images/logo.png")),
            flex: 1),
        Expanded(
          child: Container(
              width: double.infinity,
              color: Colors.red[600],
              child: Container(
                padding: const EdgeInsets.all(20),
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    const Text(
                      "Register",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      child: TextField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          label: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            padding: const EdgeInsets.all(5),
                            child: const Text(
                              "Nama Lengkap",
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                          hoverColor: Colors.white,
                          fillColor: Colors.white,
                          filled: true,
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(3)),
                      alignment: Alignment.center,
                      child: DropdownButton<String>(
                        hint: const Text("Pilih Jenis Kelamin"),
                        isExpanded: true,
                        underline: Container(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _genderValue = newValue!;
                          });
                        },
                        value: _genderValue,
                        items: ["-- Jenis Kelamin --", "Laki-laki", "Perempuan"]
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value.toUpperCase(),
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      child: TextField(
                        controller: _nikController,
                        decoration: InputDecoration(
                          label: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            padding: const EdgeInsets.all(5),
                            child: const Text(
                              "NIK",
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                          hoverColor: Colors.white,
                          fillColor: Colors.white,
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
                        controller: _addressController,
                        decoration: InputDecoration(
                          label: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            padding: const EdgeInsets.all(5),
                            child: const Text(
                              "Alamat",
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                          hoverColor: Colors.white,
                          fillColor: Colors.white,
                          filled: true,
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(3)),
                      alignment: Alignment.center,
                      child: DropdownButton<String>(
                        focusColor: Colors.white,
                        isExpanded: true,
                        underline: Container(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _bloodTypeValue = newValue!;
                          });
                        },
                        value: _bloodTypeValue,
                        items: ["-- Golongan Darah --", "A", "B", "AB", "O"]
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
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
                              color: Colors.white,
                            ),
                            padding: const EdgeInsets.all(5),
                            child: const Text(
                              "Kontak Darurat",
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                          hoverColor: Colors.white,
                          fillColor: Colors.white,
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
                              color: Colors.white,
                            ),
                            padding: const EdgeInsets.all(5),
                            child: const Text(
                              "Email",
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                          hoverColor: Colors.white,
                          fillColor: Colors.white,
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
                              color: Colors.white,
                            ),
                            padding: const EdgeInsets.all(5),
                            child: const Text(
                              "No Handphone",
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                          hoverColor: Colors.white,
                          fillColor: Colors.white,
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
                              color: Colors.white,
                            ),
                            padding: const EdgeInsets.all(5),
                            child: const Text(
                              "Password",
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                          hoverColor: Colors.white,
                          fillColor: Colors.white,
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
                        controller: _confirmPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          label: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            padding: const EdgeInsets.all(5),
                            child: const Text(
                              "Konfirmasi Password",
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                          hoverColor: Colors.white,
                          fillColor: Colors.white,
                          filled: true,
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue[600],
                        minimumSize: const Size.fromHeight(40),
                      ),
                      child: const Text(
                        "DAFTAR",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                      onPressed: () => {register(context)},
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue[600],
                        minimumSize: const Size.fromHeight(40),
                      ),
                      child: const Text(
                        "MASUK",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                      onPressed: () => {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const LoginView()),
                            (route) => false)
                      },
                    )
                  ],
                ),
              )),
          flex: 3,
        ),
      ],
    ));
  }
}
