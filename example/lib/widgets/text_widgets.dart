import 'package:flutter/material.dart';
import 'package:insta_login_example/extensions/numeric.dart';

class InfoWidget extends StatelessWidget {
  const InfoWidget({super.key, required this.title, required this.subtitle});
  final String title, subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RichText(
          text: TextSpan(
            style: const TextStyle(color: Colors.black),
            children: [
              TextSpan(
                text: '$title: ',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(text: subtitle),
            ],
          ),
        ),
        5.vertical,
      ],
    );
  }
}
