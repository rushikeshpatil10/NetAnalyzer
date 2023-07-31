import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import '../home_screen.dart';
import '../login_screen.dart';
import '../screens/about_screen.dart';
import 'hex_color.dart';

class SideDrawer extends StatefulWidget {
  const SideDrawer({super.key});

  @override
  State<SideDrawer> createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  String? _userName;
  // Variable to store the user's name
  // final currentuser = FirebaseAuth.instance;
  final user = FirebaseAuth.instance.currentUser!;
  @override
  void initState() {
    _fetchUserData();
    // getProfile();
    super.initState();
    // Fetch the user's data when the widget is created
  }

  // Function to fetch user data from Firestore and update _userName
  Future<void> _fetchUserData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        setState(() {
          _userName = userSnapshot.get('Name');
        });
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 230.0,
      child: Drawer(
        backgroundColor: HexColor("#5DB075"),
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: HexColor("#5DB075")),

              child: const Column(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/icon.png'),
                    radius: 25.0,
                  ),
                  // Image.asset(
                  //   'assets/icon.png', // Replace with your logo image path
                  //   width: 30.0,
                  //   height: 30.0,
                  SizedBox(
                    height: 10.0,
                  ),
                  // ),
                  Text(
                    'Network Analyzer',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'CustomFont',
                    ),
                  ),
                  // Text(
                  //   _userName.toString().trim(),
                  //   // _userName.toString(), // Display the user's name here
                  //   style: const TextStyle(
                  //     color: Colors.white,
                  //     fontFamily: 'PoppinsRegular',
                  //     fontWeight: FontWeight.bold,
                  //     fontSize: 16,
                  //   ),
                  // ),
                ],
              ),

              // decoration: BoxDecoration(
              //     gradient: LinearGradient(colors: [
              //   hexStringToColor("CB2B93"),
              //   hexStringToColor("9546C4"),
              //   hexStringToColor("5E61F4")
              // ])),
            ),
            // UserAccountsDrawerHeader(
            //   accountName: Text(_userName ?? 'Guest'),
            //   accountEmail: Text(''), // You can display the user's email here
            //   currentAccountPicture: CircleAvatar(
            //     child: Icon(Icons.person),
            //   ),
            // ),
            const Divider(
              // Add a white line (divider)
              color: Colors.white, // Set the color to white
              thickness: 2, // Set the thickness of the line
            ),
            ListTile(
              leading: const Icon(
                Icons.calendar_month_rounded,
                color: Colors.white,
              ),
              title: const Text(
                'Information',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'PoppinsRegular',
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              onTap: () => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()))
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.info_outline_rounded,
                color: Colors.white,
              ),
              title: const Text(
                'About',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'PoppinsRegular',
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              onTap: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AboutScreen()))
              },
            ),
            ListTile(
                leading: const Icon(
                  Icons.exit_to_app,
                  color: Colors.white,
                ),
                title: const Text(
                  'Logout',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'PoppinsRegular',
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                onTap: () {
                  // Show the logout confirmation dialog
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Logout"),
                        content:
                            const Text("Are you sure you want to log out?"),
                        actions: <Widget>[
                          TextButton(
                            style: TextButton.styleFrom(
                                textStyle: const TextStyle(fontSize: 16)),
                            child: Text("No",
                                style: TextStyle(
                                    color: HexColor("#5DB075"),
                                    fontWeight: FontWeight.bold)),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                                textStyle: const TextStyle(fontSize: 16)),
                            child: Text(
                              "Yes",
                              style: TextStyle(
                                  color: HexColor("#5DB075"),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            onPressed: () {
                              // Perform the logout operation
                              FirebaseAuth.instance.signOut().then((value) {
                                print("Signed Out");
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginScreen(),
                                  ),
                                );
                              });
                            },
                          ),
                        ],
                      );
                    },
                  );
                }),
          ],
        ),
      ),
    );
  }
}
