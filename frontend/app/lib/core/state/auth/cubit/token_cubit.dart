import 'package:app/core/const/common.dart';
import 'package:app/core/const/secure_storge.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TokenCubit extends Cubit<String?> {
  TokenCubit()
      : super(null); 

  Future<String?> getToken() async {
    try {
      String? token = await SecureStorage.readStrogeByKey(keyAuth);
      if (token == null || token.isEmpty) {
        emit(null); 
      } else {
        emit(token); 
      }
      return state; 
    } catch (e) {
      emit(null); 
      return null;
    }
  }
}
