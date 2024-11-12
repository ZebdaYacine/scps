// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app/core/extension/extension.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AuthField extends StatefulWidget {
  final String nameFiedl;
  final TextEditingController controller;
  final bool isObscureText;
  final bool isPwdField;

  const AuthField({
    super.key,
    required this.nameFiedl,
    required this.controller,
    this.isObscureText = false,
    this.isPwdField = true,
  });

  @override
  State<AuthField> createState() => _AuthFieldState();
}

class _AuthFieldState extends State<AuthField> {
  late bool _isObscureText;

  @override
  void initState() {
    super.initState();
    _isObscureText = widget.isObscureText;
  }

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
          decoration: InputDecoration(
            labelText: widget.nameFiedl,
            suffixIcon: widget.isPwdField
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        _isObscureText = !_isObscureText;
                      });
                    },
                    child: Icon(
                      _isObscureText ? Icons.visibility : Icons.visibility_off,
                    ),
                  )
                : null,
          ),
          validator: (value) {
            return (value == "" || value == null)
                ? "${widget.nameFiedl} is empty"
                : null;
          },
          controller: widget.controller,
          obscureText: widget.isPwdField ? _isObscureText : false,
        ),
      ),
    );
  }
}
