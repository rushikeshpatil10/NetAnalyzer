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
  final GlobalKey<FormState> _key2 = GlobalKey<FormState>();

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
                    fontFamily: 'PoppinsRegular',
                    color: HexColor("#5DB075"),
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 80,
              ),
              RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    // style: DefaultTextStyle.of.(context).style,
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Enter your ',
                          style: TextStyle(color: Colors.black, fontSize: 16)),
                      TextSpan(
                        text: 'Email ID ',
                        style: TextStyle(
                            color: Colors.black,
                            // fontWeight: FontWeight.bold,
                            fontSize: 16), // Set the desired color here
                      ),
                      TextSpan(
                          text: 'and we will send you a Password reset link ',
                          style: TextStyle(color: Colors.black, fontSize: 16)),
                    ],
                  )),
              const SizedBox(
                height: 20,
              ),
              // reusableTextField(false, _emailTextController, false),
              Form(
                key: _key2,
                autovalidateMode: AutovalidateMode.always,
                child: TextFormField(
                    controller: _emailTextController,
                    obscureText: false,
                    enableSuggestions: false,
                    autocorrect: false,
                    cursorColor: Colors.black,
                    style: TextStyle(color: Colors.black.withOpacity(0.9)),
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      labelStyle:
                          TextStyle(color: Colors.green.withOpacity(0.9)),
                      filled: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      fillColor: Colors.grey.withOpacity(0.2),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        // borderSide: const BorderSide(
                        //     width: 0, style: BorderStyle.none),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      bool emailValid = RegExp(
                              r"^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$")
                          .hasMatch(value!);
                      if (value.isEmpty) {
                        return 'Email is required';
                      } else if (!emailValid) {
                        return "Enter Valid Email";
                      }
                    }
                    // validator: MultiValidator([
                    //   RequiredValidator(errorText: "Email is required"),
                    //   EmailValidator(errorText: "Email is required ")
                    // ]),
                    ),
              ),
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
