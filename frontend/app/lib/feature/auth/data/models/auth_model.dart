import 'package:app/core/entities/auth.dart';
import 'package:app/core/entities/user_data.dart';

class AuthModel extends Auth {
  AuthModel({
    required super.token,
    required super.userData,
  });

  factory AuthModel.fromJson(Map<String, dynamic> map) {
    return AuthModel(
      token: map['token'] ?? '',
      userData: UserData.fromJson(map['userdata'] ?? {}),
    );
  }

  AuthModel copyWith({
    String? token,
    UserData? userData,
  }) {
    return AuthModel(
      token: token ?? this.token,
      userData: userData ?? this.userData,
    );
  }
}

class EmailOTPModel {
  bool status;

  EmailOTPModel({
    required this.status,
  });

  factory EmailOTPModel.fromJson(Map<String, dynamic> map) {
    return EmailOTPModel(
      status: map['data'] ?? '',
    );
  }

  EmailOTPModel copyWith({
    bool? status,
  }) {
    return EmailOTPModel(
      status: status ?? this.status,
    );
  }
}

class SetPwdModel {
  bool status;

  SetPwdModel({
    required this.status,
  });

  factory SetPwdModel.fromJson(Map<String, dynamic> map) {
    return SetPwdModel(
      status: map['data'] ?? '',
    );
  }

  SetPwdModel copyWith({
    bool? status,
  }) {
    return SetPwdModel(
      status: status ?? this.status,
    );
  }
}
