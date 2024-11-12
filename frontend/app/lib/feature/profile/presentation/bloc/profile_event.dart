part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

final class GetProfileEvent extends ProfileEvent {
  final String token;
  final String agant;

  GetProfileEvent({
    required this.token,
    required this.agant,
  });
}

final class GetInformationCardEvent extends ProfileEvent {
  final String token;
  final String idsecurity;

  GetInformationCardEvent({
    required this.token,
    required this.idsecurity,
  });
}
