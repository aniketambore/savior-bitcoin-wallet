import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_repository/wallet_repository.dart';

part 'receive_address_state.dart';

class ReceiveAddressCubit extends Cubit<ReceiveAddressState> {
  ReceiveAddressCubit({
    required this.walletRepository,
  }) : super(
          const ReceiveAddressInProgress(),
        ) {
    _getAddress();
  }

  final WalletRepository walletRepository;

  Future<void> _getAddress() async {
    try {
      final address = await walletRepository.getAddress();
      emit(
        ReceiveAddressSuccess(receiveAddress: address),
      );
    } catch (error) {
      emit(
        const ReceiveAddressFailure(),
      );
    }
  }

  Future<void> refetch() async {
    emit(
      const ReceiveAddressInProgress(),
    );
    _getAddress();
  }
}
