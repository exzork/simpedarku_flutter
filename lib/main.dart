import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:simpedarku/components/home.dart';
import 'package:simpedarku/services/apiResponse.dart';
import 'package:simpedarku/services/apiService.dart';

import 'package:simpedarku/models/user.dart';
import 'package:simpedarku/components/login.dart';

void main() {
  runApp(const CheckLogin());
}

class CheckLogin extends StatefulWidget {
  const CheckLogin({Key? key}) : super(key: key);

  @override
  _CheckLoginState createState() => _CheckLoginState();
}

class _CheckLoginState extends State<CheckLogin> {
  LocalStorage localstorage = LocalStorage("simpedarku");

  @override
  void initState() {
    super.initState();
    userProfile();
  }

  int isLogedin = -1;
  bool isChecking = false;

  doLogin() async {
    log('doLogin');
    ApiService.login("test@mail.com", "admin123").then((value) {
      UserResponse userResponse = UserResponse.fromMap(value.data);
      User user = userResponse.user as User;
      localstorage.setItem("token", user.apiToken);
      setState(() {
        isLogedin = 1;
      });
    });
  }

  userProfile() async {
    log('userProfile');
    UserProfile? userProfile = await ApiService.getUser();
    if (userProfile != null) {
      setState(() {
        isLogedin = 1;
      });
    }else{
      setState(() {
        isLogedin = 0;
      });
    }
  }

  Future<int> checkLogin() async {
    return isLogedin;
  }

  _setIsLogedin(int isLogedin) {
    setState(() {
      this.isLogedin = isLogedin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: checkLogin(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          switch (snapshot.data) {
            case 0:
              return LoginView(setLoggedIn: _setIsLogedin);
            case 1:
              return const HomeView();
            default:
              return const MaterialApp(
                home: Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
          }
        } else {
          return const MaterialApp(
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
      },
    );
  }
}
