import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        strokeWidth: 6,
        color: Color.fromARGB(255, 37, 145, 222),
        backgroundColor: Color.fromARGB(255, 61, 165, 255),
      ),
    );
  }
}
