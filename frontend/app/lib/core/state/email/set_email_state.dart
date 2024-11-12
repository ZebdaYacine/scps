part of 'set_email_bloc.dart';

@immutable
sealed class SetEmailOTPState {}

final class SetEmailOTPInitial extends SetEmailOTPState {}

final class SetEmailOTPLoading extends SetEmailOTPState {}

final class SetEmailOTPResult extends SetEmailOTPState {
  final bool status;
  SetEmailOTPResult(this.status);
}
