import 'dart:io';

import 'package:app/core/const/common.dart';
import 'package:app/core/extension/extension.dart';
import 'package:app/core/theme/app_pallete.dart';
import 'package:app/feature/auth/presentaion/cubit/email_cubit.dart';
import 'package:app/feature/auth/presentaion/pages/send_otp_page.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/core/state/auth/bloc/auth_bloc.dart';
import 'package:app/core/utils/snack_bar.dart';
import 'package:app/core/widgets/auth_field.dart';
import 'package:app/core/widgets/auth_gradient_button.dart';
import 'package:app/core/widgets/loading_bar.dart';
import 'package:go_router/go_router.dart';

class ResetPwdPage extends StatefulWidget {
  const ResetPwdPage({super.key});

  @override
  State<ResetPwdPage> createState() => _ResetPwdPageState();
}

class _ResetPwdPageState extends State<ResetPwdPage> {
  final pwdController1 = TextEditingController();
  final pwdController2 = TextEditingController();
  final formKey = GlobalKey<FormState>();
  Map<String, dynamic> decryptedData = {};
  String agant = "";

  @override
  void dispose() {
    pwdController1.dispose();
    pwdController2.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      agant = 'pharmacy';
    } else if (Platform.isAndroid || Platform.isIOS) {
      agant = 'insured';
    } else if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
      agant = 'worker';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppPallete.gradient1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(
              context,
              MaterialPageRoute(builder: (context) => const SendOtpPage()),
            );
          },
        ),
        title: const Text(
          'E-CHIFFA',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthFailure) {
                showSnackBar(context, state.error);
              } else if (state is AuthSuccess) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Alert'),
                        content: const Text(
                            'Your password has been set successfully'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              context.go(startPoint);
                            },
                            child: const Text('go to login page'),
                          ),
                        ],
                      );
                    });
              }
            },
            builder: (context, state) {
              if (state is AuthLoading) {
                return const Loader();
              }
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Réinitialiser le mot de passe",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: context.isMobile ? 25 : 30,
                          ),
                        ),
                        AuthField(
                          nameFiedl: "Mot de passe",
                          controller: pwdController1,
                          isObscureText: true,
                        ),
                        AuthField(
                          nameFiedl: "Confirmer mot de passe",
                          controller: pwdController2,
                          isObscureText: true,
                        ),
                        AuthGradientButton(
                          buttonText: 'Valide',
                          onClick: () {
                            if (formKey.currentState!.validate()) {
                              if (pwdController1.text == pwdController2.text) {
                                BlocProvider.of<AuthBloc>(context).add(
                                  AuthForgetPwd(
                                    email:
                                        context.read<EmailCubit>().getEmail(),
                                    pwd1: pwdController1.text,
                                    pwd2: pwdController1.text,
                                  ),
                                );
                              } else {
                                showSnackBar(
                                    context, "passwords are not the same");
                              }
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
