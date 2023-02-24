import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

class Address extends FormzInput<String, AddressValidationError>
    with EquatableMixin {
  const Address.unvalidated([
    String value = '',
  ]) : super.pure(value);

  const Address.validated([
    String value = '',
  ]) : super.dirty(value);

  // static final _addressRegex = RegExp(
  //   // r'^(m|n|tb1)[a-km-zA-HJ-NP-Z0-9]{25,}$',
  //   r'^(tb|TB)[a-km-zA-HJ-NP-Z0-9]{26,}$ ',
  // );

  @override
  AddressValidationError? validator(String value) {
    // return value.isEmpty
    //     ? AddressValidationError.empty
    //     : (_addressRegex.hasMatch(value)
    //         ? null
    //         : AddressValidationError.invalid);
    return value.isEmpty ? AddressValidationError.empty : null;
  }

  @override
  List<Object?> get props => [
        value,
        pure,
      ];
}

enum AddressValidationError {
  empty,
  invalid,
}
