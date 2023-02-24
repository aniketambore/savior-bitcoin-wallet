import 'package:formz/formz.dart';

class Word extends FormzInput<String, WordValidationError> {
  const Word.unvalidated([String value = '']) : super.pure(value);

  const Word.validated([String value = '']) : super.dirty(value);

  @override
  WordValidationError? validator(String value) {
    if (value.isEmpty) {
      return WordValidationError.empty;
    } else if (value.length < 3) {
      return WordValidationError.invalid;
    } else {
      return null;
    }
  }
}

enum WordValidationError {
  empty,
  invalid,
}
