part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class CheckStorge extends AuthEvent {}

final class Authlogin extends AuthEvent {
  final String usernme;
  final String password;

  Authlogin({
    required this.usernme,
    required this.password,
  });
}

final class Authlogout extends AuthEvent {
  Authlogout();
}

final class AuthForgetPwd extends AuthEvent {
  final String pwd1;
  final String pwd2;

  AuthForgetPwd({
    required this.pwd1,
    required this.pwd2,
  });
}
