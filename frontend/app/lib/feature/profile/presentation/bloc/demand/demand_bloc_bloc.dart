import 'package:app/core/entities/user_data.dart';
import 'package:app/feature/profile/domain/usecase/profile_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'demand_bloc_event.dart';
part 'demand_bloc_state.dart';

class DemandBloc extends Bloc<DemandBlocEvent, DemandState> {
  final ProfileUsecase _profileUsecase;
  DemandBloc({required ProfileUsecase profileUsecase})
      : _profileUsecase = profileUsecase,
        super(DemandInitial()) {
    on<GetAllPendingDemandsEvent>(_getDemandsEvent);
    on<UpdateDemandsEvent>(_updateDemandsEvent);
  }
  void _getDemandsEvent(
      GetAllPendingDemandsEvent event, Emitter<DemandState> emit) async {
    emit(DemandLoading());
    final result = await _profileUsecase.getAllDemands(
      GetDemandParams(
        token: event.token,
      ),
    );
    result.fold(
      (l) async {
        emit(GetDemendsFailure(l.message));
      },
      (r) async {
        emit(GetDemendsSuccess(r));
      },
    );
  }

  void _updateDemandsEvent(
      UpdateDemandsEvent event, Emitter<DemandState> emit) async {
    emit(DemandLoading());
    final result = await _profileUsecase.updateDemand(
      UpdateDemandParams(token: event.token, userData: event.user),
    );
    result.fold(
      (l) async {
        emit(UpdateDemendsFailure(l.message));
      },
      (r) async {
        emit(UpdateDemendsSuccess(r));
      },
    );

    emit(DemandLoading());
    final result1 = await _profileUsecase.getAllDemands(
      GetDemandParams(
        token: event.token,
      ),
    );
    result1.fold(
      (l) async {
        emit(GetDemendsFailure(l.message));
      },
      (r) async {
        emit(GetDemendsSuccess(r));
      },
    );
  }
}
