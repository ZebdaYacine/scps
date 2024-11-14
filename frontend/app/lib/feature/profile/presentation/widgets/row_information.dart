// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, prefer_const_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';

class RowInformation extends StatelessWidget {
  final String title;
  final String value;
  final TextStyle style1;
  final TextStyle style2;
  const RowInformation({
    super.key,
    required this.title,
    required this.value,
    this.style1 = const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.bold,
      color: Colors.blueGrey,
    ),
    this.style2 = const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.bold,
      color: Colors.blueGrey,
    ),
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: style1,
          textAlign: TextAlign.center,
        ),
        Text(
          value,
          style: style2,
        ),
      ],
    );
  }
}
