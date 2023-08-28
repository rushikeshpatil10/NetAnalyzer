import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

import 'package:net_analyzer/home_screen.dart';
import 'package:net_analyzer/reusable_widgets/hex_color.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../reusable_widgets/custom_container.dart';
import '../reusable_widgets/side_drawer.dart';

// import '../utils/colors_utils.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  String _appName = '';
  String _version = '';
  String _buildNumber = '';

  @override
  void initState() {
    super.initState();
    _getAppInformation();
  }

  Future<void> _getAppInformation() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    setState(() {
      _appName = packageInfo.appName;
      _version = packageInfo.version;
      _buildNumber = packageInfo.buildNumber;
    });
  }

  final _advancedDrawerController = AdvancedDrawerController();
  void _handleMenuButtonPressed() {
    _advancedDrawerController.showDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
        backdrop: Container(
          width: double.infinity,
          height: double.infinity,
          color: HexColor("#5DB075"),
        ),
        controller: _advancedDrawerController,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        animateChildDecoration: true,
        rtlOpening: false,
        openScale: 0.8,
        openRatio: 0.45,
        disabledGestures: false,
        childDecoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.white),
          borderRadius: const BorderRadius.all(Radius.circular(50)),
        ),
        drawer: SideDrawer(),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: HexColor("#5DB075"),
            title: Text("About"),
            leading: IconButton(
              onPressed: _handleMenuButtonPressed,
              icon: ValueListenableBuilder<AdvancedDrawerValue>(
                valueListenable: _advancedDrawerController,
                builder: (_, value, __) {
                  return AnimatedSwitcher(
                    duration: Duration(milliseconds: 250),
                    child: Icon(
                      value.visible ? Icons.clear : Icons.menu,
                      key: ValueKey<bool>(value.visible),
                    ),
                  );
                },
              ),
            ),
          ),
          // appBar: AppBar(
          //   title: Text('About'),
          //   backgroundColor: HexColor("#5DB075"),
          //   elevation: 0,
          //   // flexibleSpace: Container(
          //   //   decoration: BoxDecoration(
          //   //     gradient: LinearGradient(colors: [
          //   //       hexStringToColor("CB2B93"),
          //   //       hexStringToColor("9546C4"),
          //   //       hexStringToColor("5E61F4")
          //   //     ]),
          //   //   ),
          //   // )
          // ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const CustomInfoContainer(text: 'Description'),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    child: const Row(
                      children: [
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "The Network Connection and Wi-Fi Channel Details app: Powerful tool for monitoring and optimizing network connectivity."),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                                "Real-time info on Wi-Fi/cellular connection, insights on Wi-Fi channels, interference, and signal strength for better performance."),
                          ],
                        ))
                      ],
                    ),
                  ),
                  const CustomInfoContainer(text: 'App Features'),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    child: const Row(
                      children: [
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'Real-time monitoring of Wi-Fi and cellular connection status.'),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                                'Displaying current network type (Wi-Fi, cellular, etc.).'),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Signal strength and network quality indicators.',
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Network IP address, subnet mask, and gateway details.',
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Wi-Fi access point details, including MAC address and manufacturer.',
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Public IP address and ISP information.',
                            ),
                          ],
                        ))
                      ],
                    ),
                  ),
                  const CustomInfoContainer(
                    text: 'App Details',
                  ),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'App Name: $_appName',
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Version: $_version',
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Build Number: $_buildNumber', // Display buildNumber as an alternative for buildDate
                            ),
                          ],
                        ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
