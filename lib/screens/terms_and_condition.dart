import 'package:flutter/material.dart';

import '../reusable_widgets/custom_container.dart';
import '../reusable_widgets/hex_color.dart';

class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions({super.key});

  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms and Conditions'),
        backgroundColor: HexColor("#5DB075"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 10,
              ),
              // const CustomInfoContainer(text: 'Terms and Conditions'),
              Container(
                padding: const EdgeInsets.all(10.0),
                child: const Row(
                  children: [
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "By downloading and using the NetAnalyzer app, you agree to comply with the following terms and conditions:",
                          style: TextStyle(
                              fontSize: 14.2, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ))
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const CustomInfoContainer(text: 'Usage Agreement:'),
              Container(
                padding: const EdgeInsets.all(10.0),
                child: const Row(
                  children: [
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            'You agree to use the NetAnalyzer app solely for its intended purpose of providing network, Wi-Fi, IP, and device information.'),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                            'You will not use the app for any illegal, unauthorized, or unethical activities.'),
                      ],
                    ))
                  ],
                ),
              ),
              const CustomInfoContainer(
                text: 'Account Responsibility:',
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                child: const Row(
                  children: [
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            'If the app requires account registration, you are responsible for maintaining the confidentiality of your account credentials.'),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'You will not share your account information with unauthorized individuals.',
                        ),
                      ],
                    ))
                  ],
                ),
              ),
              const CustomInfoContainer(
                text: 'Data Collection and Usage:',
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                child: const Row(
                  children: [
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "NetAnalyzer collects minimal user data necessary for the app's functionality, such as network and device information."),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                            'We do not collect any personally identifiable information without your explicit consent.'),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                            'Any data collected is used for improving app performance and providing accurate insights.')
                      ],
                    ))
                  ],
                ),
              ),
              const CustomInfoContainer(
                text: 'Data Security:',
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                child: const Row(
                  children: [
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            'NetAnalyzer employs industry-standard security measures to protect your data from unauthorised access, disclosure, or alteration.'),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'We use encryption and secure protocols to safeguard your account credentials and data.',
                        ),
                      ],
                    ))
                  ],
                ),
              ),
              const CustomInfoContainer(
                text: "Children's Privacy:",
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                child: const Row(
                  children: [
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            'NetAnalyzer is not intended for use by children under the age of 13. We do not knowingly collect personal information from children.'),
                      ],
                    ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
