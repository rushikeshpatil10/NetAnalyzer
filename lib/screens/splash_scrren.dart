// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../home_screen.dart';
import '../login_screen.dart';
import '../reusable_widgets/hex_color.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var isLogin = false;
  var auth = FirebaseAuth.instance;

  // checkIfLogin() async {
  //   auth.authStateChanges().listen((User? user) {
  //     if (user != null && mounted) {
  //       setState(() {
  //         isLogin = true;
  //       });
  //     }
  //   });
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   checkIfLogin();
  //   // _navigatehome();
  //   // Timer(Duration(seconds: 6), () {
  //   //   Navigator.pushReplacement(
  //   //       context,
  //   //       MaterialPageRoute(
  //   //           builder: (context) =>
  //   //               isLogin ? const HomeScreen() : const LoginScreen()));
  //   //   checkIfLogin();
  //   // });
  // }

  // _navigatehome() async {
  //   await Future.delayed(const Duration(seconds: 10), () {});
  //   // ignore: use_build_context_synchronously
  //   Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(
  //           builder: (context) =>
  //               isLogin ? const HomeScreen() : const LoginScreen()));
  // }

  @override
  void initState() {
    super.initState();
    // Check if the user is logged in using Firebase
    _checkLoggedIn();
  }

  Future<void> _checkLoggedIn() async {
    // Initialize Firebase
    await Firebase.initializeApp();

    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    // Check if the user is already logged in
    if (user != null) {
      setState(() {
        isLogin = true;
      });
    } else {
      setState(() {
        isLogin = false;
      });
    }

    // Wait for 2 seconds to show the splash screen
    await Future.delayed(const Duration(seconds: 2));

    // Navigate to the appropriate screen
    if (isLogin) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor("#5DB075"),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icon.png', // Replace with your logo image path
                width: 50,
                height: 50,
              ),
              const SizedBox(height: 15),
              const Text(
                'Network Analyzer',
                style: TextStyle(
                  fontFamily: 'PoppinsRegular',
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ));
  }
}

// class HexColor extends Color {
//   // This class extends Color to provide a constructor that takes a hex string
//   // and converts it to the corresponding Color object.

//   HexColor(String hexColor) : super(_getColorFromHex(hexColor));

//   static int _getColorFromHex(String hexColor) {
//     hexColor = hexColor.toUpperCase().replaceAll("#", "");
//     if (hexColor.length == 6) {
//       hexColor = "FF" + hexColor;
//     }
//     return int.parse(hexColor, radix: 16);
//   }
// }
