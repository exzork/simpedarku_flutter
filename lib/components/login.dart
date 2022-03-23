import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:simpedarku/components/home.dart';
import 'package:simpedarku/models/user.dart';
import 'package:simpedarku/services/apiResponse.dart';

import '../main.dart';
import '../services/apiService.dart';

class LoginView extends StatefulWidget {
  final ValueChanged<int> setLoggedIn;
  const LoginView({Key? key, required this.setLoggedIn}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  static LocalStorage storage = LocalStorage('simpedarku');
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  login() async {
    ApiResponse response = await ApiService.login(_emailController.text, _passwordController.text);
    if(response.status == "success"){
      UserResponse userResponse = UserResponse.fromMap(response.data);
      User user = userResponse.user as User;
      await storage.ready.then((_) async {
        await storage.setItem('token', user.apiToken);
      });
      widget.setLoggedIn(1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
              ),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  child: const Text('Login'),
                  onPressed: () async {
                    await login();
                  },
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}