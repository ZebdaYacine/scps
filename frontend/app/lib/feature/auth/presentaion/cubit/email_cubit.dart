import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

class EmailCubit extends Cubit<String> {
  EmailCubit() : super("");
  String getEmail() {
    return state;
  }

  void setEmail(String email) {
    if (email.isNotEmpty) {
      emit(email);
    }
  }
}
