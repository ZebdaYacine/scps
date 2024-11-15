part of 'demand_bloc_bloc.dart';

@immutable
sealed class DemandBlocEvent {}

final class GetAllPendingDemandsEvent extends DemandBlocEvent {
  final String token;
  GetAllPendingDemandsEvent({
    required this.token,
  });
}

final class UpdateDemandsEvent extends DemandBlocEvent {
  final String token;
  final UserData user;
  UpdateDemandsEvent({
    required this.token,
    required this.user,
  });
}
