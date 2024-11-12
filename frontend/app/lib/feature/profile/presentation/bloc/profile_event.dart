part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

final class GetProfileEvent extends ProfileEvent {
  final String token;

  GetProfileEvent({
    required this.token,
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