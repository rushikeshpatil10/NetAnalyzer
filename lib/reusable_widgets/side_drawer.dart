import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:net_analyzer/main.dart';

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
  String _userName = sharedPreferences.getString('name') ?? 'Error';
  // Variable to store the user's name
  // final currentuser = FirebaseAuth.instance;
  final user = FirebaseAuth.instance.currentUser!;
  @override
  void initState() {
    // _fetchUserData();
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
    return ListView(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50.0,
              ),
              Container(
                height: 60,
                width: 60,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    image:
                        DecorationImage(image: AssetImage('assets/icon.png'))),
              ),
              // Image.asset(
              //   'assets/icon.png', // Replace with your logo image path
              //   width: 30.0,
              //   height: 30.0,

              const SizedBox(
                height: 10.0,
              ),
              // ),
              const Text(
                'Network Analyzer',
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontFamily: 'PoppinsRegular',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Hello,',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'PoppinsRegular',
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Text(
                _userName,
                // _userName.toString(), // Display the user's name here
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'PoppinsRegular',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),

        // UserAccountsDrawerHeader(
        //   accountName: Text(_userName ?? 'Guest'),
        //   accountEmail: Text(''), // You can display the user's email here
        //   currentAccountPicture: CircleAvatar(
        //     child: Icon(Icons.person),
        //   ),
        // ),
        const SizedBox(
          height: 20,
        ),
        const Divider(
          // Add a white line (divider)
          color: Colors.white, // Set the color to white
          thickness: 1, // Set the thickness of the line
          indent: 10,
          endIndent: 5,
        ),
        Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
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
                    fontSize: 15),
              ),
              minLeadingWidth: 10,
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
                    fontSize: 15),
              ),
              minLeadingWidth: 10,
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
                      fontSize: 15),
                ),
                minLeadingWidth: 10,
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
                              FirebaseAuth.instance
                                  .signOut()
                                  .then((value) => sharedPreferences.clear())
                                  .then((value) {
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
      ],
    );
  }
}
