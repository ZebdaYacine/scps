part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileSuccess extends ProfileState {
  final UserData userData;
  ProfileSuccess(this.userData);
}

final class ProfileFailure extends ProfileState {
  final String error;
  ProfileFailure(this.error);
}

final class InformationCardSuccess extends ProfileState {
  final UserData userData;
  InformationCardSuccess(this.userData);
}

final class InformationCardFailure extends ProfileState {
  final String error;
  InformationCardFailure(this.error);
}
