import 'package:formz/formz.dart';

class Fee extends FormzInput<double, FeeValidationError> {
  const Fee.unvalidated([
    double value = 0,
  ]) : super.pure(value);

  const Fee.validated([
    double value = 0,
  ]) : super.dirty(value);

  @override
  FeeValidationError? validator(double value) {
    if (value < 1) {
      return FeeValidationError.invalid;
    } else {
      return null;
    }
  }
}

enum FeeValidationError { invalid }
