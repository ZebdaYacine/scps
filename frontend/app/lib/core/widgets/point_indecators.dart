import 'package:flutter/material.dart';

class PointIndicator extends StatelessWidget {
  final String text;

  PointIndicator({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: text == "Approved" ? Colors.green : Colors.red,
      ),
    );
  }
}
