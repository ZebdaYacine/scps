import 'package:app/core/const/common.dart';
import 'package:app/core/const/secure_storge.dart';
import 'package:app/feature/auth/domain/usecase/auth_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

part 'auth_event.dart';
part 'auth_state.dart';

final logger = Logger();

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUsecase _authUsecase;
  AuthBloc({required AuthUsecase authUsecase})
      : _authUsecase = authUsecase,
        super(AuthInitial()) {
    on<CheckStorge>(_checkStroge);
    on<Authlogin>(_onAuthLogin);
    on<Authlogout>(_onAuthlogout);
    on<AuthForgetPwd>(_onAuthForgetPwd);
  }

  void _onAuthlogout(Authlogout event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    SecureStorage.writeStrogeByKey(keyAuth, "");
    emit(LogoutSuccess());
  }

  void _checkStroge(CheckStorge event, Emitter<AuthState> emit) async {
    try {
      String? value = await SecureStorage.readStrogeByKey(keyAuth);
      if (value?.isEmpty ?? true) {
        emit(AuthFailure("Token is empty"));
      } else {
        emit(AuthSuccess(value!));
      }
    } catch (e) {
      logger.e('Error reading storage: $e');
      emit(AuthFailure("Failed to read token from storage"));
    }
  }

  void _onAuthLogin(Authlogin event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await _authUsecase.login(
      UserLoginParams(
        email: event.usernme,
        password: event.password,
      ),
    );

    result.fold(
      (l) async {
        emit(AuthFailure(l.message));
        SecureStorage.writeStrogeByKey(keyAuth, "");
      },
      (r) async {
        emit(AuthSuccess(r.token));
        SecureStorage.writeStrogeByKey(keyAuth, r.token);
      },
    );
  }

  void _onAuthForgetPwd(AuthForgetPwd event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await _authUsecase.forgetPassword(
      ForgetPasswordarams(
        email: event.email,
        pwd1: event.pwd1,
        pwd2: event.pwd2,
      ),
    );
    result.fold(
      (l) async {
        emit(AuthFailure(l.message));
      },
      (r) async {
        emit(AuthSuccess(r.toString()));
      },
    );
  }
}
