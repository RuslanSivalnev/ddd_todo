part of 'note_form_bloc.dart';

@freezed
class NoteFormState with _$NoteFormState {
  const factory NoteFormState(
      { //
      required Note note,
      required bool showErrorMessages,
      required bool isSaving,
      required bool isEditing,
      required Option<Either<NoteFailure, Unit>> saveFailureOrSuccessOption //
      }) = _NoteFormState;

  factory NoteFormState.initial() => NoteFormState(
        note: Note.empty(),
        showErrorMessages: false,
        isSaving: false,
        isEditing: false,
        saveFailureOrSuccessOption: none(),

        //error example call to note form page need to change listener
        // saveFailureOrSuccessOption: some(left(const NoteFailure.insufficientPermissions())),

      );
}
