import 'package:bloc/bloc.dart';

class StateRequestCubit extends Cubit<bool> {
  StateRequestCubit() : super(true);

  bool getSateReq() {
    return state;
  }

  void setSateReq(bool state) {
    emit(state);
  }
}
