import 'package:flutter/material.dart';

class ActionBtn extends StatelessWidget {
  final VoidCallback callback;
  final Color color;
  final IconData icon;
  final String title;

  const ActionBtn({
    super.key,
    required this.callback,
    required this.color,
    required this.icon,
    required this.title,
  });
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 4,
      ),
      onPressed: () {
        callback();
      },
      icon: Icon(icon),
      label: Text(title),
    );
  }
}
