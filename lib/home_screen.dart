import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_telephony_info/flutter_telephony_info.dart';
import 'package:net_analyzer/login_screen.dart';
import 'package:net_analyzer/screens/about_screen.dart';
import 'package:net_analyzer/screens/lan_screen.dart';
import 'package:net_analyzer/screens/tools_screen.dart';
import 'package:net_analyzer/screens/wifi_screen.dart';
import 'package:net_analyzer/utils/colors_utils.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:wifi_connection/WifiConnection.dart';
import 'package:wifi_connection/WifiInfo.dart';
import 'package:device_info_plus/device_info_plus.dart';

// Sets a platform override for desktop to avoid exceptions. See
// https://flutter.dev/desktop#target-platform-override for more info.

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.title});

  final String? title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  WifiInfo _wifiInfo = WifiInfo();
  String _connectionType = 'Unknown';
  String _wifiIpAddress = 'Unknown';
  String _ipv6 = 'Unknown';
  String _dns = 'Unknown';
  String _wifiDetails = 'Unknown';
  String _deviceName = 'Unknown';
  String _product = 'Unknown';
  String _idName = "Unkown";
  String _brandName = 'Unkown';
  // String _cellDetails = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
    _fetchNetworkInfo();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    WifiInfo? wifiInfo;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      wifiInfo = await WifiConnection.wifiInfo;
    } on PlatformException {
      wifiInfo = null;
    }

    if (!mounted) return;

    setState(() {
      _wifiInfo = wifiInfo!;
    });
  }

  Future<void> _fetchNetworkInfo() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return;
    }
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    // IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    // WebBrowserInfo webBrowserInfo = await deviceInfo.webBrowserInfo;
    final devicename = androidInfo.model;
    final productName = androidInfo.product;
    final brandname = androidInfo.brand;

    // final iosname = iosInfo.utsname.machine;
    // final webInfo = webBrowserInfo.userAgent;

    final networkInfo = NetworkInfo();
    final wifiName = await networkInfo.getWifiName();
    final wifiIpAddress = await networkInfo.getWifiIP();
    final ipv6Address = await networkInfo.getWifiIPv6();

    String dnsServers = 'Unknown';

    setState(() {
      _connectionType = connectivityResult.toString();
      _wifiIpAddress = wifiIpAddress ?? 'Unknown';
      _ipv6 = ipv6Address ?? 'Unknown';
      _dns = dnsServers;
      _wifiDetails = wifiName ?? 'Unknown';
      _deviceName = devicename;
      _product = productName;
      _brandName = brandname;
      // _cellDetails = cellDetails;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: SideDrawer(),
        appBar: AppBar(
            title: Text("Information"),
            actions: [
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  AppSettings.openWirelessSettings();
                },
              )
            ],
            backgroundColor: Colors.transparent,
            elevation: 0,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  hexStringToColor("CB2B93"),
                  hexStringToColor("9546C4"),
                  hexStringToColor("5E61F4")
                ]),
              ),
            )),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 50.0,
                  width: 200,
                  color: Colors.green[200],
                  child: const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(10.0, 5.0, 0.0, 0.0),
                        child: Text(
                          'Active Coonection',
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('IP: ${_wifiInfo.ipAddress}'),
                          const SizedBox(
                            height: 25.0,
                          ),
                          Text('IPv6 Address: $_ipv6'),
                          const SizedBox(
                            height: 25.0,
                          ),
                          Text('Network Id: ${_wifiInfo.networkId}'),
                          const SizedBox(
                            height: 8.0,
                          ),
                        ],
                      ))
                    ],
                  ),
                ),
                Container(
                  height: 50.0,
                  width: 200,
                  color: Colors.green[200],
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(10.0, 5.0, 0.0, 0.0),
                        child: Text(
                          'Wi-Fi Connections',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(220, 10, 0, 0),
                        child: IconButton(
                          icon: const Icon(
                            Icons.settings,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            AppSettings.openWIFISettings();
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Wi-Fi IP Address: $_wifiIpAddress'),
                          const SizedBox(
                            height: 25.0,
                          ),
                          Text('DNS Servers: $_dns'),
                          const SizedBox(
                            height: 25.0,
                          ),
                          Text('IPv6 Address: $_ipv6'),
                          const SizedBox(
                            height: 25.0,
                          ),
                          Text('Connection Type: $_connectionType'),
                          const SizedBox(
                            height: 25.0,
                          ),
                          Text('Signal Strength: ${_wifiInfo.signalStrength}'),
                          const SizedBox(
                            height: 25.0,
                          ),
                          Text('Frequency: ${_wifiInfo.frequency}'),
                          const SizedBox(
                            height: 8.0,
                          ),
                        ],
                      ))
                    ],
                  ),
                ),
                Container(
                  height: 50.0,
                  width: 200,
                  color: Colors.green[200],
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(10.0, 5.0, 0.0, 0.0),
                        child: Text(
                          'Wi-Fi Details',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(256, 5, 0, 0),
                        child: IconButton(
                          icon: const Icon(
                            Icons.settings,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            AppSettings.openWIFISettings();
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('SSID: ${_wifiInfo.ssid}'),
                          const SizedBox(
                            height: 25.0,
                          ),
                          Text('BSSID: ${_wifiInfo.bssid}'),
                          const SizedBox(
                            height: 25.0,
                          ),
                          Text('MAC Address: ${_wifiInfo.macAddress}'),
                          const SizedBox(
                            height: 25.0,
                          ),
                          Text('Link Speed: ${_wifiInfo.linkSpeed}'),
                          const SizedBox(
                            height: 25.0,
                          ),
                          Text('Channel: ${_wifiInfo.channel}'),
                          const SizedBox(
                            height: 25.0,
                          ),
                          Text('IsHiddenSSID: ${_wifiInfo.isHiddenSSID}'),
                          const SizedBox(
                            height: 25.0,
                          ),
                          Text('Router IP: ${_wifiInfo.routerIp}'),
                          const SizedBox(
                            height: 25.0,
                          ),
                          Text('Wi-Fi LinkSpeed: ${_wifiInfo.linkSpeed}'),
                          const SizedBox(
                            height: 30.0,
                          ),
                          Text('Wi-Fi HashCode: ${_wifiInfo.hashCode}'),
                        ],
                      ))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Container(
                  height: 50.0,
                  width: 200,
                  color: Colors.green[200],
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(10.0, 5.0, 0.0, 0.0),
                        child: Text(
                          'Cell Details',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(260, 5, 0, 0),
                        child: IconButton(
                          icon: const Icon(
                            Icons.settings,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            AppSettings.openDeviceSettings();
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Device info: $_deviceName'),
                          const SizedBox(
                            height: 25.0,
                          ),
                          Text('Product info: $_product'),
                          const SizedBox(
                            height: 25.0,
                          ),
                          Text('Product BrandName: $_brandName'),
                        ],
                      ))
                    ],
                  ),
                ),
                TextButton(
                    onPressed: () {
                      initPlatformState();
                      _fetchNetworkInfo();
                    },
                    child: Text('Refresh'))
              ],
            ),
          ),
        ));
  }
}

class SideDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            child: const Center(
              child: Text(
                'Network Analyzer',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              hexStringToColor("CB2B93"),
              hexStringToColor("9546C4"),
              hexStringToColor("5E61F4")
            ])),
          ),
          ListTile(
            leading: Icon(Icons.calendar_month_rounded),
            title: Text('Information'),
            onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()))
            },
          ),
          ListTile(
            leading: Icon(Icons.wifi),
            title: Text('Wi-Fi Signal'),
            onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const WifiScreen()))
            },
          ),
          ListTile(
            leading: Icon(Icons.lan_sharp),
            title: Text('LAN Scan'),
            onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LanScreen()))
            },
          ),
          ListTile(
            leading: Icon(Icons.badge),
            title: Text('Tools'),
            onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ToolsScreen()))
            },
          ),
          ListTile(
            leading: Icon(Icons.info_outline_rounded),
            title: Text('About'),
            onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AboutScreen()))
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => {
              FirebaseAuth.instance.signOut().then((value) {
                print("Signed Out");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
              })
            },
          ),
        ],
      ),
    );
  }
}

// ignore: camel_case_types
class wifiSetting {
  void _openWifiSettings(BuildContext context) {
    try {
      MethodChannel('plugins.settings').invokeMethod('wifi');
    } on PlatformException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to open Wi-Fi settings: ${e.message}')),
      );
    }
  }
}
