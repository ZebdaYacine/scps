part of 'set_email_bloc.dart';

@immutable
sealed class SetEmailEvent {}

final class SendEmail extends SetEmailEvent {
  final String email;

  SendEmail({
    required this.email,
  });
}

final class SendOTP extends SetEmailEvent {
  final String otpCode;

  SendOTP({
    required this.otpCode,
  });
}
