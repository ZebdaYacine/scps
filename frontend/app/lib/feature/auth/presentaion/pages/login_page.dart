// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, prefer_const_constructors, library_private_types_in_public_api

import 'dart:io';

import 'package:app/feature/auth/presentaion/pages/web/login_page.dart';
import 'package:app/feature/auth/presentaion/pages/mobile/login_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: kIsWeb
          ? WebLoginPage()
          : (Platform.isAndroid || Platform.isIOS)
              ? MobileLoginPage()
              : Container(),
    );
  }
}
