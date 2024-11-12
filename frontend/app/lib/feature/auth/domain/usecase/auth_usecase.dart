// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app/core/entities/auth.dart';
import 'package:app/core/errors/failure.dart';
import 'package:app/feature/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class AuthUsecase {
  final AuthRepository authRepository;
  AuthUsecase({
    required this.authRepository,
  });

  Future<Either<Failure, Auth>> login(UserLoginParams params) async {
    return await authRepository.login(
      email: params.email,
      password: params.password,
    );
  }

  Future<Either<Failure, bool>> sendEmailOTP(
      EmailOTPParams params, String arg) async {
    return await authRepository.sendEmailOTP(
      value: params.value,
      arg: arg,
    );
  }

  Future<Either<Failure, bool>> forgetPassword(
      ForgetPasswordarams params) async {
    return await authRepository.forgetPwd(
      pwd1: params.pwd1,
      pwd2: params.pwd2,
    );
  }
}

class EmailOTPParams {
  final String value;

  EmailOTPParams({
    required this.value,
  });
}

class ForgetPasswordarams {
  final String pwd1;
  final String pwd2;

  ForgetPasswordarams({
    required this.pwd1,
    required this.pwd2,
  });
}

class UserLoginParams {
  final String email;
  final String password;

  UserLoginParams({
    required this.email,
    required this.password,
  });
}
