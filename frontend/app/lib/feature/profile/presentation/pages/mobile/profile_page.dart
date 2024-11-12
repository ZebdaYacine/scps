// ignore_for_file: unused_import

import 'dart:convert';
import 'dart:io';
import 'package:app/core/const/common.dart';
import 'package:app/core/entities/user_data.dart';
import 'package:app/core/extension/extension.dart';
import 'package:app/core/secret/sercret.dart';
import 'package:app/core/state/auth/auth_bloc.dart';
import 'package:app/core/utils/security.dart';
import 'package:app/core/utils/snack_bar.dart';
import 'package:app/core/widgets/auth_gradient_button.dart';
import 'package:app/core/widgets/loading_bar.dart';
import 'package:app/feature/profile/presentation/bloc/profile_bloc.dart';
import 'package:app/feature/profile/presentation/cubit/token_cubit.dart';
import 'package:app/feature/profile/presentation/widgets/nav_bar.dart';
import 'package:app/feature/profile/presentation/widgets/pharmacy.dart';
import 'package:app/feature/profile/presentation/widgets/upload_button_file.dart';
import 'package:app/feature/profile/presentation/widgets/user.dart';
import 'package:app/feature/profile/presentation/widgets/worker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class ProfileMobilePage extends StatefulWidget {
  const ProfileMobilePage({super.key});

  @override
  State<ProfileMobilePage> createState() => _ProfileMobilePageState();
}

class _ProfileMobilePageState extends State<ProfileMobilePage> {
  final formKey = GlobalKey<FormState>();
  late final SecurityService securityService;
  UserData? userData;
  String cipherText = "";
  String cipherText1 = "";
  String token = "";

  @override
  void initState() {
    super.initState();
    securityService = SecurityService(Secret.aesKey);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthBloc>().add(CheckStorge());
    });
  }

  Future<void> _handleRefresh() async {
    logger.i("Refreshing profile data...");
    context.read<ProfileBloc>().add(
          GetProfileEvent(
            token: token,
            agant: "user",
          ),
        );
    await Future.delayed(const Duration(seconds: 1));
  }

  String base64String = "No file selected";
  String message = "";
  bool showQRCode = true;
  bool showUploadFile = true;
  bool showMsg = true;

  // Function to pick file and convert it to base64
  Future<void> pickFileAndConvertToBase64() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);
      List<int> fileBytes = await file.readAsBytes();
      String base64String = base64Encode(fileBytes);
      setState(() {
        this.base64String = base64String;
      });
      print("Base64 Encoded File: $base64String");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthFailure) {
                  context.go(startPoint);
                } else if (state is AuthSuccess) {
                  token = state.token;
                  context.read<ProfileBloc>().add(
                        GetProfileEvent(
                          token: state.token,
                          agant: "user",
                        ),
                      );
                } else if (state is LogoutSuccess) {
                  context.go(startPoint);
                }
              },
              builder: (context, authState) {
                return BlocConsumer<ProfileBloc, ProfileState>(
                  listener: (context, profileState) {
                    if (profileState is ProfileSuccess) {
                      userData = profileState.userData;
                      if (userData != null) {
                        if (userData!.request) {
                          if (userData!.status == "accepted") {
                            setState(() {
                              showQRCode = true;
                              showMsg = false;
                              showUploadFile = false;
                            });
                          } else {
                            setState(() {
                              showQRCode = false;
                              showMsg = true;
                              showUploadFile = false;
                              message = "Votre demande ${userData!.status}";
                            });
                          }
                        } else {
                          setState(() {
                            showQRCode = false;
                            showMsg = false;
                            showUploadFile = true;
                          });
                        }
                        logger.d(showQRCode);
                        logger.d(showMsg);
                        logger.d(showUploadFile);
                        cipherText =
                            securityService.encryptData(userData!.toJson());
                        cipherText1 = cipherText;
                      } else {
                        showSnackBar(context, "No data available");
                      }
                    } else if (profileState is ProfileFailure) {
                      showSnackBar(context, profileState.error);
                    }
                  },
                  builder: (context, profileState) {
                    if (profileState is ProfileLoading) {
                      return const Loader();
                    }
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            NavBarCard(
                              userName:
                                  userData != null ? userData!.name : "Guest",
                              callback: () {
                                context.read<AuthBloc>().add(Authlogout());
                              },
                            ),
                            const SizedBox(height: 30),
                            if (showUploadFile)
                              UploadButton(
                                callback: () async {
                                  FilePickerResult? result =
                                      await FilePicker.platform.pickFiles(
                                    allowedExtensions: ['jpg', 'png', 'pdf'],
                                    type: FileType.custom,
                                  );
                                  if (result != null) {
                                    setState(() {
                                      base64String = result.files.single.name;
                                    });
                                  }
                                },
                              ),
                            const SizedBox(height: 10),
                            if (showUploadFile)
                              Text(
                                base64String,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            const SizedBox(
                              width: 50,
                            ),
                            if (showMsg)
                              Text(
                                message,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            if (showUploadFile)
                              AuthGradientButton(
                                buttonText: 'envoyer votre demande',
                                onClick: () {},
                              ),
                            const SizedBox(height: 10),
                            if (showQRCode)
                              User(
                                userData: userData,
                                cipherText: cipherText,
                                cipherText1: cipherText1,
                                securityService: securityService,
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
