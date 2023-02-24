import 'package:formz/formz.dart';

class Amount extends FormzInput<int, AmountValidationError> {
  const Amount.unvalidated([
    int value = 0,
  ]) : super.pure(value);

  const Amount.validated([
    int value = 0,
  ]) : super.dirty(value);

  @override
  AmountValidationError? validator(int value) {
    if (value < 1) {
      return AmountValidationError.invalid;
    } else {
      return null;
    }
  }
}

enum AmountValidationError { invalid }
