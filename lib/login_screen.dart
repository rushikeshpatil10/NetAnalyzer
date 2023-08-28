import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:net_analyzer/main.dart';
import 'package:net_analyzer/reusable_widgets/reusable_widgets.dart';
import 'package:net_analyzer/screens/forget_password.dart';
import 'package:net_analyzer/screens/terms_and_condition.dart';
import 'package:net_analyzer/signup_screen.dart';
import 'package:net_analyzer/utils/colors_utils.dart';
import 'package:net_analyzer/reusable_widgets/hex_color.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

Future<String> fetchName() async {
  var snapshot = await FirebaseFirestore.instance
      .collection('users')
      .where('Email', isEqualTo: FirebaseAuth.instance.currentUser!.email)
      .get();
  return snapshot.docs.first.get('Name');
}

class _LoginScreenState extends State<LoginScreen> {
  // validator({Key ? key}): super(Key: key);
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  final GlobalKey<FormState> _key1 = GlobalKey<FormState>();
  final GlobalKey<FormState> _key2 = GlobalKey<FormState>();
  bool passToggle = true;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  20, MediaQuery.of(context).size.height * 0.2, 20, 0),
              child: Column(
                children: <Widget>[
                  // logoWidget('assets/logo1.png'),
                  Text(
                    "Network Analyzer",
                    style: TextStyle(
                        fontFamily: 'PoppinsRegular',
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
                      style:
                          TextStyle(color: HexColor("#5DB075"), fontSize: 16),
                    ),
                  ),

                  // reusableTextField(false, _emailTextController, false),
                  Form(
                    key: _key1,
                    autovalidateMode: AutovalidateMode.always,
                    child: TextFormField(
                        controller: _emailTextController,
                        obscureText: false,
                        enableSuggestions: false,
                        autocorrect: false,
                        cursorColor: Colors.black,
                        style: TextStyle(color: Colors.black.withOpacity(0.9)),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
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

                  ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.fromLTRB(20, 0, 5, 0.0),
                    title: Text(
                      'Password',
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(color: HexColor("#5DB075"), fontSize: 16),
                    ),
                  ),
                  Form(
                    key: _key2,
                    autovalidateMode: AutovalidateMode.always,
                    child: TextFormField(
                        controller: _passwordTextController,
                        obscureText: passToggle,
                        enableSuggestions: false,
                        autocorrect: false,
                        cursorColor: Colors.black,
                        style: TextStyle(color: Colors.black.withOpacity(0.9)),
                        decoration: InputDecoration(
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                passToggle = !passToggle;
                              });
                            },
                            child: Icon(
                              passToggle
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: HexColor('5DB075'),
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
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
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return " Password is required";
                          } else if (_passwordTextController.text.length < 6) {
                            return 'Password Length Should be 6 characters';
                          }
                        }
                        // MultiValidator([
                        //   RequiredValidator(errorText: "Password is required"),
                        //   // EmailValidator(errorText: "Password is required ")
                        // ]),
                        ),
                  ),
                  // reusableTextField(false, _passwordTextController, false),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 35,
                    width: double.infinity,
                    child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          // style: DefaultTextStyle.of.(context).style,
                          children: <TextSpan>[
                            const TextSpan(
                                text:
                                    'By click on Log In button\nI accept the terms & conditions of ',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 11)),
                            TextSpan(
                                text: 'Network Analyzer',
                                style: TextStyle(
                                    color: HexColor("#5DB075"),
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    print('Click');
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const TermsAndConditions(),
                                      ),
                                    );
                                  } // Set the desired color here
                                ),
                          ],
                        )),
                  ),
                  // const SizedBox(
                  //   height: 10,
                  // ),

                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(90)),
                    child: ElevatedButton(
                      onPressed: () async {
                        // onTap();
                        if (_key1.currentState!.validate() ||
                            _key2.currentState!.validate()) {
                          try {
                            final authResult = await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                              email: _emailTextController.text,
                              password: _passwordTextController.text,
                            );
                            print('Success');
                            // _emailTextController.clear();
                            // _passwordTextController.clear();

                            final userName = await fetchName();
                            await sharedPreferences.setString("name", userName);

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomeScreen()),
                            );
                          } catch (error) {
                            print("Error: ${error.toString()}");
                          }
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            HexColor("#5DB075")),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8))),
                      ),
                      child: const Text(
                        'Log in',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                  ),

                  // signInSignUpButton(context, true, () {
                  //   FirebaseAuth.instance
                  //       .signInWithEmailAndPassword(
                  //           email: _emailTextController.text,
                  //           password: _passwordTextController.text)
                  //       .then((value) => fetchName())
                  //       .then((value) =>
                  //           sharedPreferences.setString("name", value))
                  //       .then((value) {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => const HomeScreen()));
                  //   }).onError((error, stackTrace) {
                  //     print("Error ${error.toString()}");
                  //   });
                  // }
                  // ),
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
                                    builder: (context) =>
                                        const forgetPassword()));
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
