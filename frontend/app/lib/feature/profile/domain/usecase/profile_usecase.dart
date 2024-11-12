// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app/core/entities/user_data.dart';
import 'package:app/core/errors/failure.dart';
import 'package:app/feature/profile/domain/repository/profile_repository.dart';
import 'package:dartz/dartz.dart';

class ProfileUsecase {
  final ProfileRepository profileRepository;
  ProfileUsecase({
    required this.profileRepository,
  });

  Future<Either<Failure, UserData>> getProfile(UserProfileParams params) async {
    return await profileRepository.getProfile(
      token: params.token,
    );
  }

  Future<Either<Failure, UserData>> getInformationsCard(
      InformationCardParams params) async {
    return await profileRepository.getInformationsCard(
      token: params.token,
      idsecurity: params.idsecurity,
    );
  }
}

class UserProfileParams {
  final String token;

  UserProfileParams({
    required this.token,
  });
}

class InformationCardParams {
  final String token;
  final String idsecurity;

  InformationCardParams({
    required this.token,
    required this.idsecurity,
  });
}
