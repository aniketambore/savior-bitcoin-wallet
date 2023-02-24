import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_repository/wallet_repository.dart';
import 'package:domain_models/domain_models.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({
    required WalletRepository walletRepository,
  })  : _walletRepository = walletRepository,
        super(
          const HomeInProgress(),
        ) {
    _fetchWalletBalance(fetchPolicy: WalletSyncFetchPolicy.cacheAndNetwork);
  }

  final WalletRepository _walletRepository;

  Future<void> _fetchWalletBalance({
    required WalletSyncFetchPolicy fetchPolicy,
  }) async {
    final balanceStream =
        _walletRepository.getBalance(fetchPolicy: fetchPolicy);
    try {
      await for (final newBalance in balanceStream) {
        emit(
          HomeSuccess(
            balance: newBalance,
            syncStatus: SyncStatus.success,
          ),
        );
      }
    } catch (error) {
      final lastState = state;
      if (lastState is HomeSuccess) {
        emit(
          HomeSuccess(
            balance: lastState.balance,
            syncStatus: SyncStatus.error,
          ),
        );
      } else {
        emit(const HomeFailure());
      }
    }
  }

  Future<void> refetch() async {
    emit(
      const HomeInProgress(),
    );

    _fetchWalletBalance(
      fetchPolicy: WalletSyncFetchPolicy.cacheAndNetwork,
    );
  }

  Future<void> refresh() async {
    final lastState = state;
    if (lastState is HomeSuccess) {
      emit(
        HomeSuccess(
          balance: lastState.balance,
          syncStatus: SyncStatus.inProgress,
        ),
      );

      _fetchWalletBalance(
        fetchPolicy: WalletSyncFetchPolicy.networkOnly,
      );
    }
  }
}
