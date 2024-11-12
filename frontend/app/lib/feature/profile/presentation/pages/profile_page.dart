// ignore_for_file: unused_import

import 'dart:io';
import 'dart:ui_web';
// import 'dart:ui';
import 'package:app/core/const/common.dart';
import 'package:app/core/entities/user_data.dart';
import 'package:app/core/extension/extension.dart';
import 'package:app/core/secret/sercret.dart';
import 'package:app/core/state/auth/auth_bloc.dart';
import 'package:app/core/utils/security.dart';
import 'package:app/core/utils/snack_bar.dart';
import 'package:app/core/widgets/loading_bar.dart';
import 'package:app/feature/profile/presentation/bloc/profile_bloc.dart';
import 'package:app/feature/profile/presentation/cubit/token_cubit.dart';
import 'package:app/feature/profile/presentation/widgets/pharmacy.dart';
import 'package:app/feature/profile/presentation/widgets/user.dart';
import 'package:app/feature/profile/presentation/widgets/worker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final formKey = GlobalKey<FormState>();
  late final SecurityService securityService;
  UserData? userData;
  String cipherText = "";
  String cipherText1 = "";

  @override
  void initState() {
    super.initState();
    securityService = SecurityService(Secret.aesKey);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthBloc>().add(CheckStorge());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthFailure) {
                context.go(startPoint);
              } else if (state is AuthSuccess) {
                context
                    .read<ProfileBloc>()
                    .add(GetProfileEvent(token: state.token));
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
                      cipherText =
                          securityService.encryptData(userData!.toJson());
                      cipherText1 = cipherText;
                      if (!kIsWeb) {
                        if ((Platform.isAndroid || Platform.isIOS)) {
                          cipherText =
                              securityService.encryptData(userData!.toJson());
                          cipherText1 = cipherText;
                        }
                      }
                    } else {
                      showSnackBar(context, "no data available");
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
                          Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            color: Colors.white,
                            shadowColor: Colors.grey.shade300,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const CircleAvatar(
                                        radius: 35.0,
                                        backgroundImage: NetworkImage(
                                          'https://cdn1.iconfinder.com/data/icons/user-pictures/101/malecostume-512.png',
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        userData?.name ?? "",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: context.isMobile ? 20 : 30,
                                        ),
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.logout_sharp,
                                        size: 30),
                                    onPressed: () {
                                      context
                                          .read<AuthBloc>()
                                          .add(Authlogout());
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          if (kIsWeb)
                            const Pharmacy()
                          else if (Platform.isWindows ||
                              Platform.isLinux ||
                              Platform.isMacOS)
                            const Worker()
                          else if (Platform.isIOS || Platform.isAndroid)
                            User(
                              userData: userData,
                              cipherText: cipherText,
                              cipherText1: cipherText1,
                              securityService: securityService,
                            )
                          else
                            const Text("Not yet supported"),
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
    );
  }
}
