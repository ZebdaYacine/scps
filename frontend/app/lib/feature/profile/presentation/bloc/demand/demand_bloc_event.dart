part of 'demand_bloc_bloc.dart';

@immutable
sealed class DemandBlocEvent {}

final class GetAllPendingDemandsEvent extends DemandBlocEvent {
  final String token;

  GetAllPendingDemandsEvent({
    required this.token,
  });
}
