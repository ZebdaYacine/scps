import 'package:app/core/entities/user_data.dart';
import 'package:app/feature/profile/domain/usecase/profile_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';

part 'profile_event.dart';
part 'profile_state.dart';

final logger = Logger();

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileUsecase _profileUsecase;
  ProfileBloc({required ProfileUsecase profileUsecase})
      : _profileUsecase = profileUsecase,
        super(ProfileInitial()) {
    on<GetProfileEvent>(_onGetProfile);
    on<SendDemandEvent>(_sendDemandEvent);
    on<GetAllPendingDemandsEvent>(_getDemandsEvent);
    on<GetInformationCardEvent>(_onGetInformationCardEvent);
  }

  void _getDemandsEvent(
      GetAllPendingDemandsEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    final result = await _profileUsecase.getAllDemands(
      GetDemandParams(
        token: event.token,
      ),
    );
    result.fold(
      (l) async {
        emit(ProfileFailure(l.message));
      },
      (r) async {
        emit(GetDemendsSuccess(r));
      },
    );
  }

  void _sendDemandEvent(
      SendDemandEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    final result = await _profileUsecase.sendDemand(
      DemandParams(
        token: event.token,
        link: event.link,
      ),
    );
    result.fold(
      (l) async {
        emit(ProfileFailure(l.message));
      },
      (r) async {
        emit(ProfileSuccess(r));
      },
    );
  }

  void _onGetProfile(GetProfileEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    final result = await _profileUsecase.getProfile(
      UserProfileParams(
        token: event.token,
        agant: event.agant,
      ),
    );
    result.fold(
      (l) async {
        emit(ProfileFailure(l.message));
      },
      (r) async {
        emit(ProfileSuccess(r));
      },
    );
  }

  void _onGetInformationCardEvent(
      GetInformationCardEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    final result = await _profileUsecase.getInformationsCard(
      InformationCardParams(token: event.token, idsecurity: event.idsecurity),
    );
    result.fold(
      (l) async {
        emit(InformationCardFailure(l.message));
      },
      (r) async {
        emit(InformationCardSuccess(r));
      },
    );
  }
}
