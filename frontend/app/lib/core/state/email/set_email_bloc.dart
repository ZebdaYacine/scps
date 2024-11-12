import 'package:app/feature/auth/domain/usecase/auth_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'set_email_event.dart';
part 'set_email_state.dart';

class SetEmailOTPBloc extends Bloc<SetEmailEvent, SetEmailOTPState> {
  final AuthUsecase _authUsecase;
  SetEmailOTPBloc({required AuthUsecase authUsecase})
      : _authUsecase = authUsecase,
        super(SetEmailOTPInitial()) {
    on<SendEmail>(_onSendEmail);
    on<SendOTP>(_onSendOTP);
  }

  void _onSendEmail(SendEmail event, Emitter<SetEmailOTPState> emit) async {
    emit(SetEmailOTPLoading());
    final result = await _authUsecase.sendEmailOTP(
        EmailOTPParams(value: event.email), "email");
    result.fold(
      (l) async {
        emit(SetEmailOTPResult(false));
      },
      (r) async {
        emit(SetEmailOTPResult(r));
      },
    );
  }

  void _onSendOTP(SendOTP event, Emitter<SetEmailOTPState> emit) async {
    emit(SetEmailOTPLoading());
    final result = await _authUsecase.sendEmailOTP(
        EmailOTPParams(value: event.otpCode), "otp");
    result.fold(
      (l) async {
        emit(SetEmailOTPResult(false));
      },
      (r) async {
        emit(SetEmailOTPResult(r));
      },
    );
  }
}
