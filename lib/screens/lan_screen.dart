import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lan_scanner/lan_scanner.dart';

import '../home_screen.dart';
import '../utils/colors_utils.dart';

class LanScreen extends StatefulWidget {
  const LanScreen({super.key});

  @override
  State<LanScreen> createState() => _LanScreenState();
}

class _LanScreenState extends State<LanScreen> {
  final List<HostModel> _hosts = <HostModel>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideDrawer(),
      appBar: AppBar(
          title: Text("LAN Signal"),
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  final scanner = LanScanner(debugLogging: true);

                  final stream = scanner.icmpScan(
                    '192.168.0',
                    progressCallback: (progress) {
                      if (kDebugMode) {
                        print('progress: $progress');
                      }
                    },
                  );

                  stream.listen((HostModel host) {
                    setState(() {
                      _hosts.add(host);
                    });
                  });
                },
                child: const Text('Scan'),
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final host = _hosts[index];

                  return Card(
                    child: ListTile(
                      title: Text(host.ip),
                    ),
                  );
                },
                itemCount: _hosts.length,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
