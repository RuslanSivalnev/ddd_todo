import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

@freezed
class ValueFailure<T> with _$ValueFailure<T> {
  // auth
  const factory ValueFailure.invalidEmail({required T failedValue}) = FirstValueFailure<T>;

  const factory ValueFailure.shortPassword({required T failedValue}) = ShortPassword<T>;

  // notes
  const factory ValueFailure.exceedingLength({required T failedValue, required int max}) = ExceedingLength<T>;

  const factory ValueFailure.empty({required T failedValue}) = Empty<T>;

  const factory ValueFailure.multiline({required T failedValue}) = Multiline<T>;

  const factory ValueFailure.listTooLong({required T failedValue, required int max}) = ListTooLong<T>;
}

//! way for scale
// @freezed
// class ValueFailure<T> with _$ValueFailure<T> {
//   const factory ValueFailure.auth(AuthValueFailure<T> f) = _Auth<T>;
//   const factory ValueFailure.notes(NotesValueFailure<T> f) = _Notes<T>;
// }
//
// @freezed
// class AuthValueFailure<T> with _$AuthValueFailure<T> {
//   const factory AuthValueFailure.invalidEmail({required String failedValue}) = InvalidEmail<T>;
//
//   const factory AuthValueFailure.shortPassword({required String failedValue}) = ShortPassword<T>;
// }
//
// @freezed
// class NotesValueFailure<T> with _$NotesValueFailure<T> {
//   const factory NotesValueFailure.exceedingLength({required String failedValue}) = ExceedingLength<T>;
// }
