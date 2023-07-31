import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:net_analyzer/main.dart';
import 'package:net_analyzer/reusable_widgets/hex_color.dart';
import 'package:net_analyzer/reusable_widgets/reusable_widgets.dart';
import 'package:net_analyzer/utils/colors_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();
  User? user;

  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  Future<void> _handleSignUp() async {
    try {
      String email = _emailTextController.text.trim();
      String password = _passwordTextController.text.trim();

      if (email.isEmpty || password.isEmpty) {
        // Show an error message or snackbar for empty fields
        return;
      }

      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Additional actions after successful sign-up if needed
      print('User signed up: ${userCredential.user?.uid}');

      // Save user data to Firestore
      await addUserDetails(
        _userNameTextController.text.trim(),
        _emailTextController.text.trim(),
      );

      await sharedPreferences.setString(
          'name', _userNameTextController.text.trim());
      // Navigate to the homepage after successful sign-up
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      // Handle sign-up errors (e.g., email already in use)
      print('Sign-up error: $e');
    }
  }

  Future addUserDetails(String name, String email) async {
    await FirebaseFirestore.instance
        .collection('users')
        .add({'Name': name, 'Email': email});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.green),
        centerTitle: true,
      ),
      body: Container(
        // width: MediaQuery.of(context).size.width,
        // height: MediaQuery.of(context).size.height,
        // decoration: BoxDecoration(
        // gradient: LinearGradient(colors: [
        // hexStringToColor("CB2B93"),
        // hexStringToColor("9546C4"),
        // hexStringToColor("5E61F4")
        // ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 120, 20, 0),
            child: Column(
              children: <Widget>[
                Text(
                  "Network Analyzer",
                  style: TextStyle(
                      fontFamily: 'CustomFont',
                      color: HexColor("#5DB075"),
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 50,
                ),
                ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.fromLTRB(20, 0, 5, 0.0),
                  title: Text(
                    'Name',
                    textAlign: TextAlign.start,
                    style: TextStyle(color: HexColor("#5DB075"), fontSize: 16),
                  ),
                ),
                reusableTextField(false, _userNameTextController),
                ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.fromLTRB(20, 0, 5, 0.0),
                  title: Text(
                    'Email ID',
                    textAlign: TextAlign.start,
                    style: TextStyle(color: HexColor("#5DB075"), fontSize: 16),
                  ),
                ),
                reusableTextField(false, _emailTextController),
                ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.fromLTRB(20, 0, 5, 0.0),
                  title: Text(
                    'Password',
                    textAlign: TextAlign.start,
                    style: TextStyle(color: HexColor("#5DB075"), fontSize: 16),
                  ),
                ),
                reusableTextField(false, _passwordTextController),
                const SizedBox(
                  height: 20,
                ),
                RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      // style: DefaultTextStyle.of.(context).style,
                      children: <TextSpan>[
                        const TextSpan(
                            text:
                                'By click on Sign Up button\nI accept the terms & conditions of ',
                            style: TextStyle(color: Colors.black)),
                        TextSpan(
                          text: 'Network Analyzer',
                          style: TextStyle(
                              color: HexColor("#5DB075"),
                              fontWeight: FontWeight
                                  .bold), // Set the desired color here
                        ),
                      ],
                    )),
                const SizedBox(
                  height: 10,
                ),
                // signInSignUpButton(context, false, () {
                //   FirebaseAuth.instance
                //       .createUserWithEmailAndPassword(
                //           email: _emailTextController.text,
                //           password: _passwordTextController.text)
                //       .then((value) {
                //     // print("Created New Account");
                //     addUserDetails(
                //       _userNameTextController.text.trim(),
                //       _emailTextController.text.trim(),
                //     );

                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) => const HomeScreen()),
                //     );
                //   }).onError((error, stackTrace) {
                //     print("Error ${error.toString()}");
                //   });
                // })

                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(90)),
                  child: ElevatedButton(
                    onPressed: () {
                      _handleSignUp();
                      addUserDetails(
                        _userNameTextController.text.trim(),
                        _emailTextController.text.trim(),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(HexColor("#5DB075")),
                      // backgroundColor: MaterialStateProperty.resolveWith((states) {
                      //   if (states.contains(MaterialState.pressed)) {
                      //     return Colors.black26;
                      //   }
                      //   return Colors.white;
                      // }),

                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8))),
                    ),
                    child: const Text(
                      'Sign up',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
