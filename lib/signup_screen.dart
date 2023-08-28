import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:net_analyzer/main.dart';
import 'package:net_analyzer/reusable_widgets/hex_color.dart';
import 'package:net_analyzer/reusable_widgets/reusable_widgets.dart';
import 'package:net_analyzer/screens/terms_and_condition.dart';
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
  final GlobalKey<FormState> _key1 = GlobalKey<FormState>();
  final GlobalKey<FormState> _key2 = GlobalKey<FormState>();
  final GlobalKey<FormState> _key3 = GlobalKey<FormState>();
  bool passToggle = true;
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
        height: double.infinity,
        width: double.infinity,
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
                      fontFamily: 'PoppinsRegular',
                      color: HexColor("#5DB075"),
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30,
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
                // reusableTextField(false, _userNameTextController, false),
                Form(
                  key: _key1,
                  autovalidateMode: AutovalidateMode.always,
                  child: TextFormField(
                    controller: _userNameTextController,
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
                        // borderSide:
                        //     const BorderSide(width: 0, style: BorderStyle.none),
                      ),
                    ),
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Name is required ";
                      }
                      return null;
                    },
                    // validator: MultiValidator([
                    //   RequiredValidator(errorText: "Name is required"),
                    // ]),
                  ),
                ),
                ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.fromLTRB(20, 0, 5, 0.0),
                  title: Text(
                    'Email ID',
                    textAlign: TextAlign.start,
                    style: TextStyle(color: HexColor("#5DB075"), fontSize: 16),
                  ),
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
                ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.fromLTRB(20, 0, 5, 0.0),
                  title: Text(
                    'Password',
                    textAlign: TextAlign.start,
                    style: TextStyle(color: HexColor("#5DB075"), fontSize: 16),
                  ),
                ),
                // reusableTextField(false, _passwordTextController, false),
                Form(
                  key: _key3,
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
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return " Password is required";
                        } else if (_passwordTextController.text.length < 6) {
                          return 'Password Length Should be 6 characters';
                        }
                      }
                      // validator: MinLengthValidator(6,
                      //     errorText: 'Should be At least 6 Digit Length'),
                      ),
                ),
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
                                  'By click on Sign Up button\nI accept the terms & conditions of ',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 11)),
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
                      if (_key1.currentState!.validate() ||
                          _key2.currentState!.validate() ||
                          _key3.currentState!.validate()) {
                        try {
                          addUserDetails(
                            _userNameTextController.text.trim(),
                            _emailTextController.text.trim(),
                          );
                          _handleSignUp();

                          // print('Success');
                          // _emailTextController.clear();
                          // _passwordTextController.clear();
                          // _userNameTextController.clear();
                        } catch (e) {
                          print("Error: ${e.toString()}");
                        }
                      }
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
