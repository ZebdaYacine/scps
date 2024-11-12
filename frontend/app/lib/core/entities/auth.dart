import 'package:app/core/entities/user_data.dart';

class Auth {
  final String token;
  final UserData userData;

  Auth({
    required this.token,
    required this.userData,
  });

}
