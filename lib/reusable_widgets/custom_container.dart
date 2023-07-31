import 'package:flutter/material.dart';

class CustomInfoContainer extends StatelessWidget {
  const CustomInfoContainer({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      width: 200,
      color: const Color.fromRGBO(93, 176, 117, 0.5),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 5.0, 0.0, 0.0),
            child: Text(
              text,
            ),
          ),
        ],
      ),
    );
  }
}
