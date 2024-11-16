import 'package:app/core/const/common.dart';
import 'package:app/core/errors/exception.dart';
import 'package:app/core/secret/sercret.dart';
import 'package:app/core/state/auth/bloc/auth_bloc.dart';
import 'package:app/feature/auth/data/models/auth_model.dart';
import 'package:dio/dio.dart';

abstract interface class AuthRemoteDataSource {
  Future<AuthModel> register({
    required String name,
    required String email,
    required String password,
  });

  Future<AuthModel> login({
    required String agant,
    required String username,
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
  Future<AuthModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await Dio().post(
        "${Secret.URL_API}$createAccount",
        options: Options(headers: headers),
        data: {
          'name': name,
          'email': email,
          'password': password,
        },
      );
      int code = response.statusCode!;
      logger.d(code);

      if (response.data == null) {
        throw const ServerException('User is null!');
      }
      return AuthModel.fromJson(response.data["data"]);
    } on DioException catch (e) {
      int code = e.response!.statusCode!;
      if (code >= 400 && code < 500) {
        throw const ServerException("bad request");
      } else if (code >= 500 && code < 600) {
        throw const ServerException('server offline or internal server error');
      } else if (code != 200) {
        throw const ServerException('Unexpected error');
      }
      throw ServerException(e.toString());
    }
  }

  @override
  Future<AuthModel> login({
    required String agant,
    required String username,
    required String password,
  }) async {
    try {
      logger.d(Secret.URL_API);
      final response = await Dio().post(
        "${Secret.URL_API}$loginP",
        options: Options(
          headers: headers,
        ),
        data: {
          'agant': agant,
          'username': username,
          'password': password,
        },
      );

      if (response.data == null) {
        throw const ServerException('User is null!');
      }
      logger.d(response.data["data"]);

      return AuthModel.fromJson(response.data["data"]);
    } on DioException catch (e) {
      int code = e.response!.statusCode!;
      if (code >= 400 && code < 500) {
        throw const ServerException("incorrect credentials");
      } else if (code >= 500 && code < 600) {
        throw const ServerException('server offline or internal server error');
      } else if (code != 200) {
        throw const ServerException('Unexpected error');
      }
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
    } on DioException catch (e) {
      int code = e.response!.statusCode!;
      if (code >= 500 && code < 600) {
        throw const ServerException('server offline or internal server error');
      } else if (code != 200) {
        throw const ServerException('Unexpected error');
      }
      throw ServerException(e.toString());
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
    } on DioException catch (e) {
      int code = e.response!.statusCode!;
      if (code >= 500 && code < 600) {
        throw const ServerException('server offline or internal server error');
      } else if (code != 200) {
        throw const ServerException('Unexpected error');
      }
      throw ServerException(e.toString());
    }
  }
}
