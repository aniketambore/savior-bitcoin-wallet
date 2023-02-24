part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInProgress extends HomeState {
  const HomeInProgress();

  @override
  List<Object?> get props => [];
}

class HomeSuccess extends HomeState {
  const HomeSuccess({
    required this.balance,
    this.syncStatus = SyncStatus.success,
  });

  final Balance balance;
  final SyncStatus syncStatus;

  @override
  List<Object?> get props => [
        balance,
        syncStatus,
      ];
}

class HomeFailure extends HomeState {
  const HomeFailure();

  @override
  List<Object?> get props => [];
}

enum SyncStatus {
  idle,
  inProgress,
  success,
  error,
}
