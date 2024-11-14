// ignore_for_file: unused_import

import 'dart:io';

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
import 'package:app/feature/profile/presentation/widgets/damand_list.dart';
import 'package:app/feature/profile/presentation/widgets/nav_bar.dart';
import 'package:app/feature/profile/presentation/widgets/user.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class ProfileWebPage extends StatefulWidget {
  const ProfileWebPage({super.key});

  @override
  State<ProfileWebPage> createState() => _ProfileWebPageState();
}

class _ProfileWebPageState extends State<ProfileWebPage> {
  final formKey = GlobalKey<FormState>();
  late final SecurityService securityService;
  UserData? userData;
  String cipherText = "";
  String cipherText1 = "";
  List<UserData> demands = [];

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
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              context.go(startPoint);
            } else if (state is AuthSuccess) {
              context.read<ProfileBloc>().add(
                    GetProfileEvent(
                      token: state.token,
                      agant: "super-user",
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
                } else if (profileState is ProfileFailure) {
                  context.read<AuthBloc>().add(Authlogout());
                  context.go(startPoint);
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
                          userName: userData != null ? userData!.name : "Guest",
                          callback: () {
                            context.read<AuthBloc>().add(Authlogout());
                          },
                        ),
                        const SizedBox(height: 20),
                        BlocConsumer<ProfileBloc, ProfileState>(
                          listener: (context, state) {
                            if (state is GetDemendsFailure) {
                              showSnackBar(context, state.error);
                            }
                            if (state is GetDemendsSuccess) {
                              logger.d(state.userData);
                              demands = state.userData;
                            }
                          },
                          builder: (context, state) {
                            if (state is ProfileLoading) {
                              return const Loader();
                            }
                            if (demands.isEmpty) {
                              return const SizedBox(
                                height: 100,
                                child: Center(
                                  child: Text(
                                    "No demands found",
                                  ),
                                ),
                              );
                            }
                            return DemandList(demands: demands);
                          },
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
