import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:net_analyzer/reusable_widgets/reusable_widgets.dart';
import 'package:net_analyzer/screens/forget_password.dart';
import 'package:net_analyzer/signup_screen.dart';
import 'package:net_analyzer/utils/colors_utils.dart';
import 'package:net_analyzer/reusable_widgets/hex_color.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              20, MediaQuery.of(context).size.height * 0.2, 20, 0),
          child: Column(
            children: <Widget>[
              // logoWidget('assets/logo1.png'),
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
              // ListTile(
              //   title: Text(
              //     'Email',
              //     style: TextStyle(color: Colors.green),
              //   ),
              // ),
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
                              'By click on Log In button\nI accept the terms & conditions of ',
                          style: TextStyle(color: Colors.black)),
                      TextSpan(
                        text: 'Network Analyzer',
                        style: TextStyle(
                            color: HexColor("#5DB075"),
                            fontWeight:
                                FontWeight.bold), // Set the desired color here
                      ),
                    ],
                  )),
              const SizedBox(
                height: 10,
              ),

              signInSignUpButton(context, true, () {
                FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                        email: _emailTextController.text,
                        password: _passwordTextController.text)
                    .then((value) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()));
                }).onError((error, stackTrace) {
                  print("Error ${error.toString()}");
                });
              }),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const forgetPassword()));
                      },
                      child: Text(
                        "Forget Password",
                        style: TextStyle(
                            color: HexColor("#5DB075"),
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              signUpOption(),
            ],
          ),
        ),
      ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have account?",
            style: TextStyle(color: Colors.black)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SignUpScreen()));
          },
          child: Text(
            "Sign Up",
            style: TextStyle(
                color: HexColor("#5DB075"), fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
