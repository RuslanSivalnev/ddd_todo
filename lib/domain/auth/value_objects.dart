import 'package:dartz/dartz.dart';
import 'package:flutter_to_do_ddd/domain/core/failures.dart';
import 'package:flutter_to_do_ddd/domain/core/value_objects.dart';
import 'package:flutter_to_do_ddd/domain/core/value_validators.dart';

class EmailAddress extends ValueObject<String> {
  final Either<ValueFailure<String>, String> value;

  const EmailAddress._(this.value);

  factory EmailAddress({required String input}) {
    return EmailAddress._(validateEmailAddress(input: input));
  }
}

class Password extends ValueObject<String> {
  final Either<ValueFailure<String>, String> value;

  const Password._(this.value);

  factory Password({required String input}) {
    return Password._(validatePassword(input: input));
  }
}
