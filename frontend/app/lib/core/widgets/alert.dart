import 'package:app/core/extension/extension.dart';
import 'package:flutter/material.dart';

class AlertComponent extends StatelessWidget {
  final String msg;
  const AlertComponent({
    super.key,
    required this.msg,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      contentPadding: const EdgeInsets.all(20),
      content: SizedBox(
        width: context.isMobile
            ? context.responsiveWidth(90)
            : context.responsiveWidth(60),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Alert",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  icon: const Icon(Icons.cancel_outlined),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              msg,
              style: TextStyle(
                fontSize: context.isMobile ? 16 : 20,
                color: Colors.black45,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

void showCustomAlertDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return const AlertComponent(
          msg:
              "يتم التسجيل الأولي حضوريا على مستوى الوكالة يرجى التقرب من الوكالة مصحوب بالوثائق التالية ");
    },
  );
}
