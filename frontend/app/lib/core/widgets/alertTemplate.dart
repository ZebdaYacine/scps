// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, prefer_const_constructors, library_private_types_in_public_api
import 'package:app/core/extension/extension.dart';
import 'package:flutter/material.dart';

class AlertTemplate extends StatelessWidget {
  final String errorMsg;
  const AlertTemplate({
    super.key,
    required this.errorMsg,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.isMobile
          ? context.responsiveWidth(100)
          : context.responsiveWidth(60),
      height: context.isMobile
          ? context.responsiveWidth(100)
          : context.responsiveWidth(30),
      child: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Ajouter nouveau dossier",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  icon: Icon(Icons.cancel_outlined),
                ),
              ],
            ),
            Icon(
              size: context.isMobile ? 200 : 300,
              Icons.wifi_off,
              color: Colors.black54,
            ),
            SizedBox(height: 2),
            Text(
              'Ooops',
              style: TextStyle(
                fontSize: 40.0,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center, // Center the text
            ),
            SizedBox(height: 2),
            Text(
              errorMsg,
              style: TextStyle(
                fontSize: context.isMobile ? 20 : 40,
                color: Colors.black45,
              ),
            ),
            SizedBox(height: 10),
            IconButton(
              iconSize: context.isMobile
                  ? context.responsiveHeight(10)
                  : context.responsiveHeight(5),
              onPressed: () {},
              icon: Icon(Icons.refresh),
            ),
          ],
        ),
      ),
    );
  }
}
