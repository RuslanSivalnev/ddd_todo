import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import 'errors.dart';
import 'failures.dart';

@immutable
abstract class ValueObject<T> {
  const ValueObject();

  T getOrCrash() {
    // is the same value.fold((f) => throw UnexpectedValueError(f), (r) => r);
    // id return current value
    return value.fold((f) => throw UnexpectedValueError(f), id);
  }

  bool isValid() => value.isRight();

  Either<ValueFailure<T>, T> get value;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ValueObject<T> && runtimeType == other.runtimeType && value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return 'ValueObject {value: $value}';
  }
}
