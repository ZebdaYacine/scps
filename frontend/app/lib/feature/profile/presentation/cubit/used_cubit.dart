import 'package:bloc/bloc.dart';

class UsedCubit extends Cubit<bool> {
  UsedCubit() : super(true);
  void ayantDroitUsed() => emit(false);
  void meUsed() => emit(true);
}
