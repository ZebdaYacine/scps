// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, prefer_const_constructors, library_private_types_in_public_api

import 'package:app/core/const/common.dart';
import 'package:app/core/extension/extension.dart';
import 'package:app/core/state/email/set_email_bloc.dart';
import 'package:app/core/utils/snack_bar.dart';
import 'package:app/core/widgets/auth_field.dart';
import 'package:app/core/widgets/auth_gradient_button.dart';
import 'package:app/core/widgets/loading_bar.dart';
import 'package:app/feature/auth/presentaion/cubit/email_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SendEmailPage extends StatefulWidget {
  const SendEmailPage({super.key});

  @override
  State<SendEmailPage> createState() => _SendEmailPageState();
}

class _SendEmailPageState extends State<SendEmailPage> {
  final valueController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    valueController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: BlocConsumer<SetEmailOTPBloc, SetEmailOTPState>(
            listener: (context, state) {
              if (state is SetEmailOTPResult) {
                if (!state.status) {
                  showSnackBar(context, "6-digit not found ");
                } else {
                  context
                      .read<EmailCubit>()
                      .setEmail(valueController.text.trim());
                  context.go(confirmOtp);
                }
              }
            },
            builder: (context, state) {
              if (state is SetEmailOTPLoading) {
                return const Loader();
              }
              return Center(
                child: SizedBox(
                  width: context.isMobile ? 350 : 400, // Set a specific width
                  child: Card(
                    elevation: 4.0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 30),
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisSize:
                              MainAxisSize.min, // Shrink to fit content
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Pour récupérer votre compte, saisissez un'adresse e-mail.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(height: 20),
                            AuthField(
                              nameFiedl: "Email",
                              controller: valueController,
                              isPwdField: false,
                            ),
                            const SizedBox(height: 10),
                            AuthGradientButton(
                                buttonText: 'Send 6-digit code',
                                onClick: () {
                                  if (formKey.currentState!.validate()) {
                                    BlocProvider.of<SetEmailOTPBloc>(context)
                                        .add(
                                      SendEmail(
                                        email: valueController.text,
                                      ),
                                    );
                                  }
                                }),
                          ],
                        ),
                      ),
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
