// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, prefer_const_constructors, library_private_types_in_public_api
import 'dart:async';

import 'package:app/core/const/common.dart';
import 'package:app/core/extension/extension.dart';
import 'package:app/core/state/email/set_email_bloc.dart';
import 'package:app/core/theme/app_pallete.dart';
import 'package:app/core/utils/snack_bar.dart';
import 'package:app/core/widgets/auth_gradient_button.dart';
import 'package:app/core/widgets/loading_bar.dart';
import 'package:app/feature/auth/presentaion/pages/send_email_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class SendOtpPage extends StatefulWidget {
  const SendOtpPage({super.key});

  @override
  State<SendOtpPage> createState() => _SendOtpPageState();
}

class _SendOtpPageState extends State<SendOtpPage> {
  final valueController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  var _timer = 60;
  Timer? countdownTimer;
  String otpCode = "";

  @override
  void dispose() {
    valueController.dispose();
    countdownTimer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    startCountdown();
  }

  void startCountdown() {
    countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_timer > 0) {
          _timer--;
        } else {
          timer.cancel();
          context.go(setemail);
        }
      });
    });
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
              MaterialPageRoute(
                builder: (context) => SendEmailPage(),
              ),
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
      body: BlocConsumer<SetEmailOTPBloc, SetEmailOTPState>(
        listener: (context, state) {
          if (state is SetEmailOTPResult) {
            if (!state.status) {
              showSnackBar(context, "OTP code is not correct");
            } else {
              context.go(setPwd);
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min, // Shrink to fit content
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _timer.toString(),
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: AppPallete.gradient1,
                            ),
                          ),
                        ),
                        Text(
                          "Pour récupérer votre compte, saisissez un'adresse e-mail.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 20),
                        PinCodeTextField(
                          appContext: context,
                          length: 6,
                          onChanged: (value) {
                            otpCode = value;
                          },
                          onCompleted: (value) {
                            otpCode = value;
                          },
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(5),
                            fieldHeight: 50,
                            fieldWidth: 40,
                            inactiveColor: AppPallete.gradient1,
                          ),
                          keyboardType: TextInputType.number,
                          cursorColor: Colors.black,
                        ),
                        const SizedBox(height: 10),
                        AuthGradientButton(
                          buttonText: "Valider",
                          onClick: () {
                            if (formKey.currentState!.validate()) {
                              BlocProvider.of<SetEmailOTPBloc>(context).add(
                                SendOTP(
                                  otpCode: otpCode,
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
