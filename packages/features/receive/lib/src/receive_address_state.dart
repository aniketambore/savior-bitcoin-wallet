part of 'receive_address_cubit.dart';

abstract class ReceiveAddressState extends Equatable {
  const ReceiveAddressState();
}

class ReceiveAddressInProgress extends ReceiveAddressState {
  const ReceiveAddressInProgress();

  @override
  List<Object?> get props => [];
}

class ReceiveAddressSuccess extends ReceiveAddressState {
  const ReceiveAddressSuccess({
    required this.receiveAddress,
    this.receiveAddressError,
  });

  final String receiveAddress;
  final dynamic receiveAddressError;

  @override
  List<Object?> get props => [
        receiveAddress,
        receiveAddressError,
      ];
}

class ReceiveAddressFailure extends ReceiveAddressState {
  const ReceiveAddressFailure();

  @override
  List<Object?> get props => [];
}
