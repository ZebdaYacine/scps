import 'package:app/core/const/common.dart';
import 'package:app/core/errors/exception.dart';
import 'package:app/core/secret/sercret.dart';
import 'package:app/core/state/auth/auth_bloc.dart';
import 'package:app/feature/auth/data/models/auth_model.dart';
import 'package:dio/dio.dart';

abstract interface class AuthRemoteDataSource {
  Future<AuthModel> login({
    required String email,
    required String password,
  });

  Future<EmailOTPModel> sendEmailOTP({
    required String value,
    required String arg,
  });

  Future<SetPwdModel> forgetPwd({
    required String email,
    required String pwd1,
    required String pwd2,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl();

  @override
  Future<AuthModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await Dio().post(
        "${Secret.URL_API}$loginP",
        options: Options(headers: headers),
        data: {
          'email': email,
          'password': password,
        },
      );
      if (response.data == null) {
        throw const ServerException('User is null!');
      }
      logger.i(response.data["data"]);
      return AuthModel.fromJson(response.data["data"]);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<EmailOTPModel> sendEmailOTP(
      {required String value, required String arg}) async {
    try {
      Response<dynamic> response;
      if (arg == "email") {
        response = await Dio().post(
          "${Secret.URL_API}$setemail",
          options: Options(headers: headers),
          data: {
            'email': value,
          },
        );
      } else {
        response = await Dio().post(
          "${Secret.URL_API}$confirmOtp",
          options: Options(headers: headers),
          data: {
            'otp': value,
          },
        );
      }
      return EmailOTPModel.fromJson(response.data);
    } catch (e) {
      // throw ServerException(e.toString());
      return EmailOTPModel(status: false);
    }
  }

  @override
  Future<SetPwdModel> forgetPwd({
    required String email,
    required String pwd1,
    required String pwd2,
  }) async {
    try {
      final response = await Dio().post(
        "${Secret.URL_API}$setPwd",
        options: Options(headers: headers),
        data: {
          'email': email,
          'pwd1': pwd1,
          'pwd2': pwd2,
        },
      );
      if (response.data == null) {
        throw const ServerException('User is null!');
      }
      return SetPwdModel.fromJson(response.data);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
