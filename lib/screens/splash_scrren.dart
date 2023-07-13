import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../home_screen.dart';
import '../login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var isLogin = false;
  var auth = FirebaseAuth.instance;

  checkIfLogin() async {
    auth.authStateChanges().listen((User? user) {
      if (user != null && mounted) {
        setState(() {
          isLogin = true;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    checkIfLogin();
    _navigatehome();
    // Timer(Duration(seconds: 6), () {
    //   Navigator.pushReplacement(
    //       context,
    //       MaterialPageRoute(
    //           builder: (context) =>
    //               isLogin ? const HomeScreen() : const LoginScreen()));
    //   checkIfLogin();
    // });
  }

  _navigatehome() async {
    await Future.delayed(const Duration(seconds: 10), () {});
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                isLogin ? const HomeScreen() : const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.black,
          child: const Center(
            child: Text(
              'Net Analyzer',
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          )),
    );
  }
}
