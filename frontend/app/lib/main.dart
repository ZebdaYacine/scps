import 'package:app/core/router/routing.dart';
import 'package:app/core/state/auth/bloc/auth_bloc.dart';
import 'package:app/core/state/email/set_email_bloc.dart';
import 'package:app/core/theme/theme.dart';
import 'package:app/feature/auth/data/datasources/auth_remote_data_source.dart';
import 'package:app/feature/auth/data/repositoryImpl/auth_repositoy_impl.dart';
import 'package:app/feature/auth/domain/usecase/auth_usecase.dart';
import 'package:app/feature/auth/presentaion/cubit/email_cubit.dart';
import 'package:app/feature/profile/data/datasources/profile_remote_data_source.dart';
import 'package:app/feature/profile/data/repositoryImpl/profile_repositoy_impl.dart';
import 'package:app/feature/profile/domain/usecase/profile_usecase.dart';
import 'package:app/feature/profile/presentation/bloc/demand/demand_bloc_bloc.dart';
import 'package:app/feature/profile/presentation/bloc/profiel/profile_bloc.dart';
import 'package:app/feature/profile/presentation/cubit/state_request_cubit.dart';
import 'package:app/core/state/auth/cubit/token_cubit.dart';
import 'package:app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});
  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => EmailCubit(),
        ),
        // BlocProvider(
        //   create: (context) => StateRequestCubit(),
        // ),
        BlocProvider(
          create: (context) => TokenCubit(),
        ),
        BlocProvider(
          create: (context) => AuthBloc(
            authUsecase: AuthUsecase(
              authRepository: AuthRepositoryImpl(
                AuthRemoteDataSourceImpl(),
              ),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => SetEmailOTPBloc(
            authUsecase: AuthUsecase(
              authRepository: AuthRepositoryImpl(
                AuthRemoteDataSourceImpl(),
              ),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => ProfileBloc(
            profileUsecase: ProfileUsecase(
              profileRepository: ProfileRepositoryImpl(
                ProfileRemoteDataSourceImpl(),
              ),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => DemandBloc(
            profileUsecase: ProfileUsecase(
              profileRepository: ProfileRepositoryImpl(
                ProfileRemoteDataSourceImpl(),
              ),
            ),
          ),
        ),
      ],
      child: Builder(builder: (context) {
        return MaterialApp.router(
          routerConfig: router,
          theme: AppTheme.darkThemeMode,
          debugShowCheckedModeBanner: false,
        );
      }),
    );
  }
}
