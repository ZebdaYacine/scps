part of 'demand_bloc_bloc.dart';

@immutable
sealed class DemandState {}

final class DemandInitial extends DemandState {}

final class DemandLoading extends DemandInitial {}

final class GetDemendsSuccess extends DemandState {
  final List<UserData> userData;
  GetDemendsSuccess(this.userData);
}

final class GetDemendsFailure extends DemandState {
  final String error;
  GetDemendsFailure(this.error);
}
