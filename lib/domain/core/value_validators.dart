import 'package:dartz/dartz.dart';
import 'package:kt_dart/kt.dart';

import 'failures.dart';

// auth
Either<ValueFailure<String>, String> validateEmailAddress({required String input}) {
  // Maybe not the most robust way of email validation but it's good enough
  const emailRegex = r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";
  if (RegExp(emailRegex).hasMatch(input)) {
    return right(input);
  } else {
    return left(ValueFailure.invalidEmail(failedValue: input));
  }
}

Either<ValueFailure<String>, String> validatePassword({required String input}) {
  // Maybe not the most robust way of email validation but it's good enough
  if (input.length >= 6) {
    return right(input);
  } else {
    return left(ValueFailure.shortPassword(failedValue: input));
  }
}

// notes
Either<ValueFailure<String>, String> validateMaxStringLength({required String input, required int maxLength}) {
  if (input.length <= maxLength) {
    return right(input);
  } else {
    return left(ValueFailure.exceedingLength(failedValue: input, max: maxLength));
  }
}

Either<ValueFailure<String>, String> validateStringNotEmpty(String input) {
  if (input.isNotEmpty) {
    return right(input);
  } else {
    return left(ValueFailure.empty(failedValue: input));
  }
}

Either<ValueFailure<String>, String> validateSingleLine(String input) {
  if (input.contains('\n')) {
    return left(ValueFailure.multiline(failedValue: input));
  } else {
    return right(input);
  }
}

Either<ValueFailure<KtList<T>>, KtList<T>> validateMaxListLength<T>(
    {required KtList<T> input, required int maxLength}) {
  if (input.size <= maxLength){
    return right(input);
  } else{
    return left(ValueFailure.listTooLong(failedValue: input, max: maxLength));
  }
}
