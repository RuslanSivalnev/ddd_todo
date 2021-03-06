import 'package:dartz/dartz.dart';
import 'package:flutter_to_do_ddd/domain/notes/note_failure.dart';
import 'package:kt_dart/collection.dart';

import 'note.dart';

abstract class INoteRepository {
  Stream<Either<NoteFailure, KtList<Note>>> watchAll();
  Stream<Either<NoteFailure, KtList<Note>>> watchAllUncompleted();
  Future<Either<NoteFailure, Unit>> create(Note note);
  Future<Either<NoteFailure, Unit>> update(Note note);
  Future<Either<NoteFailure, Unit>> delete(Note note);
}
