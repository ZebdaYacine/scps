// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, prefer_const_constructors, library_private_types_in_public_api

import 'package:app/core/const/common.dart';
import 'package:app/core/theme/app_pallete.dart';
import 'package:app/feature/auth/presentaion/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/core/extension/extension.dart';
import 'package:app/core/state/auth/auth_bloc.dart';
import 'package:app/core/utils/snack_bar.dart';
import 'package:app/core/widgets/auth_field.dart';
import 'package:app/core/widgets/auth_gradient_button.dart';
import 'package:app/core/widgets/loading_bar.dart';
import 'package:go_router/go_router.dart';

class MobileCreateAccountPage extends StatefulWidget {
  const MobileCreateAccountPage({super.key});

  @override
  State<MobileCreateAccountPage> createState() =>
      _MobileCreateAccountPageState();
}

class _MobileCreateAccountPageState extends State<MobileCreateAccountPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final pwdController1 = TextEditingController();
  final pwdController2 = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    pwdController1.dispose();
    pwdController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppPallete.gradient1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
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
                showSnackBar(
                  context,
                  state.error,
                );
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
                          "Create Votre Account",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: context.isMobile ? 25 : 30,
                          ),
                        ),
                        const SizedBox(height: 20),
                        AuthField(
                          nameFiedl: "Nom",
                          controller: nameController,
                          isPwdField: false,
                        ),
                        AuthField(
                          nameFiedl: "Email",
                          controller: emailController,
                          isPwdField: false,
                        ),
                        const SizedBox(
                            height: 10), // Added spacing for better UI
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
                        SizedBox(
                          height: 20,
                        ),
                        AuthGradientButton(
                          buttonText: 'Creer Votre Compte',
                          onClick: () {
                            if (formKey.currentState!.validate()) {
                              if (pwdController1.text == pwdController2.text) {
                                BlocProvider.of<AuthBloc>(context).add(
                                  AuthRegister(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: pwdController1.text,
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