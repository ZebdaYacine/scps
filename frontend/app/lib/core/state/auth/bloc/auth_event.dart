part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class CheckStorge extends AuthEvent {}

final class AuthRegister extends AuthEvent {
  final String name;
  final String email;
  final String password;

  AuthRegister({
    required this.name,
    required this.email,
    required this.password,
  });
}

final class Authlogin extends AuthEvent {
  final String agant;
  final String usernme;
  final String password;

  Authlogin({
    required this.agant,
    required this.usernme,
    required this.password,
  });
}

final class Authlogout extends AuthEvent {
  Authlogout();
}

final class AuthForgetPwd extends AuthEvent {
  final String email;
  final String pwd1;
  final String pwd2;

  AuthForgetPwd({
    required this.email,
    required this.pwd1,
    required this.pwd2,
  });
}
