import 'dart:async';

import 'package:flutter/material.dart';
import 'package:storeapp/moduls/auth/screen/login_screen.dart';
import 'package:storeapp/moduls/dashboard/screen/home_screen.dart';
import 'package:storeapp/utils/local_storage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final LocalStorage _localStorage = LocalStorage.localStorageSharedInstance;

  @override
  void initState() {
    super.initState();
    checkLogin();
  }
  Future<void> checkLogin() async {
    Timer(const Duration(seconds: 2), (() async {
      if (await _localStorage.getBoolValue(_localStorage.login) == true) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const HomePage()),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      }
    }));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.network('https://www.shutterstock.com/image-vector/colorful-poster-white-background-ecommerce-260nw-695213800.jpg',
            width: 200,
            height: 200),
      ),
    );
  }
}

