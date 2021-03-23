import 'package:flutter_to_do_ddd/domain/core/value_objects.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

@freezed
class AppUser with _$AppUser{
  const factory AppUser({
    required UniqueId id
  }) = _AppUser;
}
