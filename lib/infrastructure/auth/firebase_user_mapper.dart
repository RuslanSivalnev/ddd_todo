import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_to_do_ddd/domain/auth/user.dart';
import 'package:flutter_to_do_ddd/domain/core/value_objects.dart';

extension FirebaseUserDomainX on User {
  AppUser toDomain() {
    return AppUser(id: UniqueId.fromUniqueString(uid));
  }
}
