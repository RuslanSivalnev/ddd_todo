import 'package:dartz/dartz.dart';
import 'package:flutter_to_do_ddd/domain/core/failures.dart';
import 'package:flutter_to_do_ddd/domain/core/value_objects.dart';
import 'package:flutter_to_do_ddd/domain/core/value_validators.dart';

class EmailAddress extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory EmailAddress({required String input}) {
    return EmailAddress._(validateEmailAddress(input: input));
  }

  const EmailAddress._(this.value);
}

class Password extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory Password({required String input}) {
    return Password._(validatePassword(input: input));
  }

  const Password._(this.value);

}
