import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:simpedarku/components/home.dart';
import 'package:simpedarku/components/register.dart';
import 'package:simpedarku/models/error.dart';
import 'package:simpedarku/models/user.dart';
import 'package:simpedarku/services/apiResponse.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../main.dart';
import '../services/apiService.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  static LocalStorage storage = LocalStorage('simpedarku');
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  initState() {
    super.initState();
  }

  login(context) async {
    ApiResponse response = await ApiService.login(UserLogin(email: _emailController.text, password: _passwordController.text));
    if (response.status == "success") {
      UserResponse userResponse = UserResponse.fromMap(response.data);
      User user = userResponse.user as User;
      await storage.ready.then((_) async {
        await storage.setItem('token', user.apiToken);
      });
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context)=>const HomeView()), (route) => false);
    } else {
      ErrorResponse errorResponse = ErrorResponse.fromMap(response.data);
      Alert(context: context, title: "Error", desc: errorResponse.errors.join("\n")).show();
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
                child: Image.asset("assets/images/logo.png")
              ),
              flex: 1
          ),
          Expanded(
            child: Container(
              color: Colors.red[600],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    "MASUK",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size.fromHeight(40),
                            primary: Colors.blue[600],
                          ),
                          child: const Text(
                            "MASUK",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                          onPressed: () => login(context),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(40),
                            primary: Colors.blue[600],
                          ),
                          child: const Text(
                            "DAFTAR",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                          onPressed: () => {
                            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context)=>const RegisterView()), (route) => false)
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }
}
