// ignore_for_file: use_key_in_widget_constructors, public_member_api_docs, sort_constructors_first, must_be_immutable

import 'package:flutter/material.dart';
import 'package:app/core/extension/extension.dart';

class NavBarCard extends StatefulWidget {
  final String userName;
  final VoidCallback callback;
  NavBarCard({Key? key, required this.userName, required this.callback})
      : super(key: key);
  @override
  _NavBarCardState createState() => _NavBarCardState();
}

class _NavBarCardState extends State<NavBarCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: Colors.white,
      shadowColor: Colors.grey.shade300,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 35.0,
                  backgroundImage: NetworkImage(
                    'https://cdn1.iconfinder.com/data/icons/user-pictures/101/malecostume-512.png',
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  widget.userName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: context.isMobile ? 20 : 30,
                  ),
                ),
              ],
            ),
            IconButton(
              icon: const Icon(Icons.logout_sharp, size: 30),
              onPressed: () {
                widget.callback();
              },
            ),
          ],
        ),
      ),
    );
  }
}
