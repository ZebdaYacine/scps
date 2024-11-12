import 'package:app/core/entities/auth.dart';
import 'package:app/core/errors/exception.dart';
import 'package:app/core/errors/failure.dart';
import 'package:app/feature/auth/data/datasources/auth_remote_data_source.dart';
import 'package:app/feature/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, Auth>> login(
      {required String email, required String password}) async {
    try {
      final user = await remoteDataSource.login(
        email: email,
        password: password,
      );
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> sendEmailOTP(
      {required String value, required String arg}) async {
    try {
      final result = await remoteDataSource.sendEmailOTP(
        value: value,
        arg: arg,
      );
      return right(result.status);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> forgetPwd(
      {required String email,
      required String pwd1,
      required String pwd2}) async {
    try {
      final result = await remoteDataSource.forgetPwd(
        email: email,
        pwd1: pwd1,
        pwd2: pwd2,
      );
      return right(result.status);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
