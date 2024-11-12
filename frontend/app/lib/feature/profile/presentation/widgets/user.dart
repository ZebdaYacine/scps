import 'package:app/core/state/auth/auth_bloc.dart';
import 'package:app/core/widgets/auth_gradient_button.dart';
import 'package:app/feature/profile/presentation/widgets/information_card.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:app/core/utils/security.dart';
import 'package:app/core/entities/user_data.dart';

class User extends StatefulWidget {
  final UserData? userData;
  final String cipherText;
  final String cipherText1;
  final SecurityService securityService;

  const User({
    super.key,
    required this.userData,
    required this.cipherText,
    required this.cipherText1,
    required this.securityService,
  });

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          color: Colors.white,
          shadowColor: Colors.grey.shade300,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "__ E-CHIFA CARD __",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                QrImageView(
                  data: widget.cipherText,
                  version: QrVersions.auto,
                  size: 300.0,
                  embeddedImageStyle: const QrEmbeddedImageStyle(
                    size: Size(60, 60),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 30),
        AuthGradientButton(
          buttonText: 'Consulter vos ayant droits',
          onClick: () {
            setState(() {
              logger.d(widget.securityService.decryptData(widget.cipherText1));
            });
            showDialog(
              context: context,
              builder: (context) {
                return InformationCard(
                  title: "Les ayant droits",
                  informations: widget.userData!,
                );
              },
            );
          },
        ),
      ],
    );
  }
}
