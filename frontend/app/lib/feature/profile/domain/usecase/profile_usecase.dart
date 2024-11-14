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
      agant: params.agant,
    );
  }

  Future<Either<Failure, UserData>> getInformationsCard(
      InformationCardParams params) async {
    return await profileRepository.getInformationsCard(
      token: params.token,
      idsecurity: params.idsecurity,
    );
  }

  Future<Either<Failure, UserData>> sendDemand(DemandParams params) async {
    return await profileRepository.sendDemand(
      token: params.token,
      link: params.link,
    );
  }

  Future<Either<Failure, List<UserData>>> getAllDemands(
      GetDemandParams params) async {
    return await profileRepository.getAllDemands(
      token: params.token,
    );
  }
}

class GetDemandParams {
  final String token;

  GetDemandParams({
    required this.token,
  });
}

class DemandParams {
  final String token;
  final String link;

  DemandParams({
    required this.token,
    required this.link,
  });
}

class UserProfileParams {
  final String token;
  final String agant;

  UserProfileParams({
    required this.token,
    required this.agant,
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
