import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../home_screen.dart';
import 'hex_color.dart';

Image logoWidget(String imageName) {
  return Image.asset(
    imageName,
    fit: BoxFit.fitWidth,
    width: 240,
    height: 240,
    color: Colors.white,
  );
}

// TextField reusableTextField(String text, IconData icon, bool isPasswordType,
//     TextEditingController controller)

TextFormField reusableTextField(
    bool isPasswordType, TextEditingController controller, bool isEmail) {
  return TextFormField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: Colors.black,
    style: TextStyle(color: Colors.black.withOpacity(0.9)),
    decoration: InputDecoration(
      contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      labelStyle: TextStyle(color: Colors.green.withOpacity(0.9)),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.grey.withOpacity(0.2),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
        borderSide: const BorderSide(width: 0, style: BorderStyle.none),
      ),
    ),
    keyboardType: isEmail
        ? TextInputType.emailAddress
        : (isPasswordType ? TextInputType.visiblePassword : TextInputType.text),
    validator: (value) {
      if (value!.isEmpty) {
        return isEmail ? 'Email is required' : 'Password is required';
      }
      bool emailValid = RegExp(
        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
      ).hasMatch(value);
      if (!emailValid) {
        return "Enter valid Email";
      }
      return null;
    },
  );
}

bool isValidEmail(String email) {
  // Use a regular expression pattern to validate the email format
  final RegExp emailRegex = RegExp(
    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
  );
  return emailRegex.hasMatch(email);
}

Container signInSignUpButton(
    BuildContext context, bool isLogin, Function onTap) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(HexColor("#5DB075")),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
      ),
      child: Text(
        isLogin ? 'Log in' : 'Sign up',
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
      ),
    ),
  );
}
