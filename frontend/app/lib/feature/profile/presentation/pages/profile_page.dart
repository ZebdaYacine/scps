// ignore_for_file: unused_import

import 'dart:io';

import 'package:app/core/const/common.dart';
import 'package:app/core/entities/user_data.dart';
import 'package:app/core/extension/extension.dart';
import 'package:app/core/secret/sercret.dart';
import 'package:app/core/state/auth/auth_bloc.dart';
import 'package:app/core/theme/app_pallete.dart';
import 'package:app/core/utils/security.dart';
import 'package:app/core/utils/snack_bar.dart';
import 'package:app/core/widgets/loading_bar.dart';
import 'package:app/feature/profile/presentation/bloc/profile_bloc.dart';
import 'package:app/feature/profile/presentation/cubit/token_cubit.dart';
import 'package:app/feature/profile/presentation/pages/mobile/profile_page.dart';
import 'package:app/feature/profile/presentation/pages/web/profile_page.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppPallete.gradient1,
        title: const Text(
          'E-CHIFFA',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: kIsWeb ? const ProfileWebPage() : const ProfileMobilePage(),
    );
  }
}
