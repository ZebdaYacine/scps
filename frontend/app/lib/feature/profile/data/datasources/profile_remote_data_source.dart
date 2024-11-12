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
    } catch (e) {
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
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
