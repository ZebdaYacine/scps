import 'package:app/core/entities/user_data.dart';
import 'package:app/core/errors/exception.dart';
import 'package:app/core/errors/failure.dart';
import 'package:app/feature/profile/data/datasources/profile_remote_data_source.dart';
import 'package:app/feature/profile/domain/repository/profile_repository.dart';
import 'package:dartz/dartz.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, UserData>> getProfile(
      {required String token, required String agant}) async {
    try {
      final user = await remoteDataSource.getProfile(
        token: token,
        agant: agant,
      );
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserData>> getInformationsCard({
    required String token,
    required String idsecurity,
  }) async {
    try {
      final user = await remoteDataSource.getInformationCard(
          token: token, idsecurity: idsecurity);
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
