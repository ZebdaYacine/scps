import 'package:app/core/entities/auth.dart';
import 'package:app/core/errors/failure.dart';
import 'package:dartz/dartz.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, Auth>> register({
    required String name,
    required String email,
    required String password,
  });
  Future<Either<Failure, Auth>> login({
    required String agant,
    required String email,
    required String password,
  });

  Future<Either<Failure, bool>> sendEmailOTP({
    required String value,
    required String arg,
  });

  Future<Either<Failure, bool>> forgetPwd({
    required String email,
    required String pwd1,
    required String pwd2,
  });
}
