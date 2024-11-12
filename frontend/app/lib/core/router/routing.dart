import 'package:app/core/const/common.dart';
import 'package:app/feature/auth/presentaion/pages/login_page.dart';
import 'package:app/feature/auth/presentaion/pages/rest_password_page.dart';
import 'package:app/feature/auth/presentaion/pages/send_email_page.dart';
import 'package:app/feature/auth/presentaion/pages/send_otp_page.dart';
import 'package:app/feature/profile/presentation/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    //Starting routers
    GoRoute(
      path: startPoint,
      builder: (BuildContext context, GoRouterState state) {
        return const LoginPage();
      },
    ),

    //Auth routers
    GoRoute(
      path: setemailPath,
      builder: (BuildContext context, GoRouterState state) {
        return const SendEmailPage();
      },
    ),
    GoRoute(
      path: setPwdPath,
      builder: (BuildContext context, GoRouterState state) {
        return const ResetPwdPage();
      },
    ),
    GoRoute(
      path: confirmOtpPath,
      builder: (BuildContext context, GoRouterState state) {
        return const SendOtpPage();
      },
    ),
    GoRoute(
      path: setPwdPath,
      builder: (BuildContext context, GoRouterState state) {
        return const ResetPwdPage();
      },
    ),

    //Profile routers
    GoRoute(
      path: profilePath,
      builder: (BuildContext context, GoRouterState state) {
        return const ProfilePage();
      },
    ),
  ],
);
