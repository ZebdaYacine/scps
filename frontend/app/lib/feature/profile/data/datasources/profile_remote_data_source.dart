import 'package:app/core/entities/user_data.dart';
import 'package:app/core/errors/exception.dart';
import 'package:app/core/secret/sercret.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

Logger logger = Logger();

abstract interface class ProfileRemoteDataSource {
  Future<UserData> getProfile({
    required String token,
    required String agant,
  });

  Future<UserData> sendDemand({
    required String token,
    required String link,
  });

  Future<List<UserData>> getPendingDemnds({
    required String token,
  });

  Future<UserData> getInformationCard({
    required String token,
    required String idsecurity,
  });
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  ProfileRemoteDataSourceImpl();
  @override
  Future<UserData> getProfile(
      {required String token, required String agant}) async {
    try {
      final response = await Dio().get(
        "${Secret.URL_API}/${agant}/get-profile",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.data == null) {
        throw const ServerException('User is null!');
      }
      return UserData.fromJson(response.data["data"]);
    } on DioException catch (e) {
      int code = e.response!.statusCode!;
      if (code == 401) {
        throw const ServerException("Token Unauthorized");
      }
      if (code >= 500 && code < 600) {
        throw const ServerException('server offline or internal server error');
      } else if (code != 200) {
        throw const ServerException('Unexpected error');
      }
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserData> getInformationCard(
      {required String token, required String idsecurity}) async {
    try {
      final response = await Dio().post(
        "${Secret.URL_API}/profile/get-information-card",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
        data: {
          'securityId': idsecurity,
        },
      );
      if (response.data == null) {
        throw const ServerException('User is null!');
      }
      return UserData.fromJson(response.data["data"]);
    } on DioException catch (e) {
      int code = e.response!.statusCode!;
      if (code == 401) {
        throw const ServerException("Token Unauthorized");
      }
      if (code >= 500 && code < 600) {
        throw const ServerException('server offline or internal server error');
      } else if (code != 200) {
        throw const ServerException('Unexpected error');
      }
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserData> sendDemand(
      {required String token, required String link}) async {
    try {
      final response = await Dio().post(
        "${Secret.URL_API}/user/send-demand",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
        data: {
          'linkfile': link,
        },
      );
      if (response.data == null) {
        throw const ServerException('User is null!');
      }
      return UserData.fromJson(response.data["data"]);
    } on DioException catch (e) {
      int code = e.response!.statusCode!;
      if (code == 401) {
        throw const ServerException("Token Unauthorized");
      }
      if (code >= 500 && code < 600) {
        throw const ServerException('server offline or internal server error');
      } else if (code != 200) {
        throw const ServerException('Unexpected error');
      }
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<UserData>> getPendingDemnds({required String token}) async {
    try {
      final response = await Dio().get(
        "${Secret.URL_API}/super-user/get-All-demands",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.data == null) {
        throw const ServerException('User is null!');
      }
      logger.d(response.data["data"]);
      List<dynamic> dataList = response.data["data"];
      List<UserData> users =
          dataList.map((data) => UserData.fromJson(data)).toList();
      return users;
    } on DioException catch (e) {
      int code = e.response!.statusCode!;
      if (code == 401) {
        throw const ServerException("Token Unauthorized");
      }
      if (code >= 500 && code < 600) {
        throw const ServerException('server offline or internal server error');
      } else if (code != 200) {
        throw const ServerException('Unexpected error');
      }
      throw ServerException(e.toString());
    }
  }
}
