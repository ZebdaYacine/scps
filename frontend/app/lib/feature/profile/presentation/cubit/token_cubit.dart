import 'package:flutter_bloc/flutter_bloc.dart';

class TokenCubit extends Cubit<String> {
  TokenCubit() : super("");

  String getToken() {
    return state;
  }

  void setToken(String token) {
    if (token.isNotEmpty) {
      emit(token);
    }
  }
}
