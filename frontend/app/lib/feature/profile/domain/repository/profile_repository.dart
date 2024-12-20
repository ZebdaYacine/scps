import 'package:app/core/entities/user_data.dart';
import 'package:app/core/errors/failure.dart';
import 'package:dartz/dartz.dart';

abstract interface class ProfileRepository {
  Future<Either<Failure, UserData>> getProfile({
    required String token,
    required String agant,
  });

  Future<Either<Failure, bool>> updateDemand({
    required String token,
    required UserData user,
  });

  Future<Either<Failure, UserData>> getInformationsCard({
    required String token,
    required String idsecurity,
  });

  Future<Either<Failure, UserData>> sendDemand({
    required String token,
    required String link,
  });

  Future<Either<Failure, List<UserData>>> getAllDemands({
    required String token,
  });
}
