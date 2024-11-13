import 'package:flutter/material.dart';

class SelectButton extends StatelessWidget {
  final VoidCallback callback;
  const SelectButton({super.key, required this.callback});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 4,
      ),
      onPressed: () {
        callback();
      },
      icon: const Icon(Icons.cloud_upload),
      label: const Text('Select File'),
    );
  }
}
