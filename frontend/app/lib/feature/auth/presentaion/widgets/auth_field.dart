// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app/core/extension/extension.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AuthField extends StatelessWidget {
  String nameFiedl;
  final TextEditingController controller;
  final bool isObscureText;

  AuthField({
    super.key,
    required this.nameFiedl,
    required this.controller,
    this.isObscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        width: context.isMobile
            ? context.responsiveWidth(100)
            : context.responsiveWidth(40),
        height: context.isMobile
            ? context.responsiveWidth(15)
            : context.responsiveWidth(5),
        child: TextFormField(
          decoration: InputDecoration(labelText: nameFiedl),
          validator: (value) {
            return (value == "") ? "$nameFiedl is empty" : "";
          },
          controller: controller,
          obscureText: isObscureText,
          // obscuringCharacter: ".",
        ),
      ),
    );
  }
}
