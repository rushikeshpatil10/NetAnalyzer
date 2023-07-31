import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:net_analyzer/reusable_widgets/hex_color.dart';

import '../reusable_widgets/reusable_widgets.dart';

class forgetPassword extends StatefulWidget {
  const forgetPassword({super.key});

  @override
  State<forgetPassword> createState() => _forgetPasswordState();
}

class _forgetPasswordState extends State<forgetPassword> {
  TextEditingController _emailTextController = TextEditingController();

  @override
  void dispose() {
    _emailTextController.dispose();
    super.dispose();
  }

  Future<void> passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailTextController.text.trim());

      // Show a pop-up when the email is successfully sent
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Password Reset Email Sent"),
            content: Text(
                "An email has been sent to ${_emailTextController.text.trim()} with instructions to reset your password."),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(e.message.toString()),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.green),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 50,
              ),
              Text(
                "Network Analyzer",
                style: TextStyle(
                    fontFamily: 'CustomFont',
                    color: HexColor("#5DB075"),
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 100,
              ),
              RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    // style: DefaultTextStyle.of.(context).style,
                    children: <TextSpan>[
                      const TextSpan(
                          text: 'Enter your ',
                          style: TextStyle(color: Colors.black, fontSize: 16)),
                      TextSpan(
                        text: 'Email ID ',
                        style: TextStyle(
                            color: HexColor("#5DB075"),
                            fontWeight: FontWeight.bold,
                            fontSize: 16), // Set the desired color here
                      ),
                      const TextSpan(
                          text: 'and we will send you a Password reset link ',
                          style: TextStyle(color: Colors.black, fontSize: 16)),
                    ],
                  )),
              const SizedBox(
                height: 20,
              ),
              reusableTextField(false, _emailTextController),
              const SizedBox(
                height: 15,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(90)),
                child: ElevatedButton(
                  onPressed: () {
                    passwordReset();
                    // Call the function to show the dialog
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(HexColor("#5DB075")),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                    // color: HexColor("#5DB075"),
                  ),
                  child: const Text(
                    "Reset Password",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
