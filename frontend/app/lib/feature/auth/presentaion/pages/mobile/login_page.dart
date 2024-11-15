// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, prefer_const_constructors, library_private_types_in_public_api

import 'package:app/core/const/common.dart';
import 'package:app/core/state/auth/cubit/token_cubit.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/core/extension/extension.dart';
import 'package:app/core/state/auth/bloc/auth_bloc.dart';
import 'package:app/core/utils/snack_bar.dart';
import 'package:app/core/widgets/auth_field.dart';
import 'package:app/core/widgets/auth_gradient_button.dart';
import 'package:app/core/widgets/loading_bar.dart';
import 'package:go_router/go_router.dart';

class MobileLoginPage extends StatefulWidget {
  const MobileLoginPage({super.key});

  @override
  State<MobileLoginPage> createState() => _MobileLoginPageState();
}

class _MobileLoginPageState extends State<MobileLoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<AuthBloc>(context).add(CheckStorge());
    });
  }

  @override
  void dispose() {
    // Clean up controllers to prevent memory leaks
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              showSnackBar(context, state.error);
            } else if (state is AuthSuccess) {
              // context.read<TokenCubit>().setToken(state.token);
              context.go(profile);
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
                      CircleAvatar(
                        backgroundImage: AssetImage(
                          'assets/cnas.png',
                        ),
                        radius: context.responsiveHeight(16),
                        backgroundColor: Colors.transparent,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Platfrom E-CHIFFA",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: context.isMobile ? 23 : 30,
                        ),
                      ),
                      const SizedBox(height: 20),
                      AuthField(
                        nameFiedl: "N'de securite Social",
                        controller: usernameController,
                        isPwdField: false,
                      ),
                      const SizedBox(height: 10), // Added spacing for better UI
                      AuthField(
                        nameFiedl: "Mot de passe",
                        controller: passwordController,
                        isObscureText: true,
                      ),
                      const SizedBox(height: 15), // Added spacing for better UI
                      AuthGradientButton(
                        buttonText: 'Login',
                        onClick: () {
                          if (formKey.currentState!.validate()) {
                            BlocProvider.of<AuthBloc>(context).add(
                              Authlogin(
                                agant: "USER",
                                usernme: usernameController.text,
                                password: passwordController.text,
                              ),
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 15),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(fontSize: 18, color: Colors.black),
                          children: [
                            TextSpan(
                              text: 'Forget my password',
                              style: const TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  context.go(setemail);
                                },
                            ),
                            const TextSpan(text: " & "),
                            TextSpan(
                              text: "I don't have an account",
                              style: const TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  context.go(createAccount);
                                },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
