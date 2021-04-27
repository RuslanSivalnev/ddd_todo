import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_to_do_ddd/domain/core/value_objects.dart';
import 'package:flutter_to_do_ddd/domain/notes/note.dart';
import 'package:flutter_to_do_ddd/domain/notes/todo_item.dart';
import 'package:flutter_to_do_ddd/domain/notes/value_object.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kt_dart/kt.dart';

part 'note_dtos.freezed.dart';

part 'note_dtos.g.dart';

@freezed
abstract class NoteDto implements _$NoteDto {
  const NoteDto._();

  const factory NoteDto({
    @JsonKey(ignore: true) String? id,
    required String body,
    required int color,
    required List<TodoItemDto> todos,
    required dynamic serverTimeStamp,
  }) = _NoteDto;


  Note toDomain() {
    return Note(
      id: UniqueId.fromUniqueString(this.id),
      body: NoteBody(body),
      // color: NoteColor(colors)
      color: NoteColor(NoteColor.predefinedColors[0]),
      todos: List3(todos.map((dto) => dto.toDomain()).toImmutableList()),
    );
  }

  factory NoteDto.fromDomain(Note note) {
    return NoteDto(
      id: note.id.getOrCrash(),
      body: note.body.getOrCrash(),
      color: note.color
          .getOrCrash()
          .value,
      todos: note.todos.getOrCrash().map((todoItem) => TodoItemDto.fromDomain(todoItem)).asList(),
      serverTimeStamp: FieldValue.serverTimestamp() ?? DateTime.now(),
    );
  }

  factory NoteDto.fromJson(Map<String, dynamic> json) => _$NoteDtoFromJson(json);

  factory NoteDto.fromFirestore(DocumentSnapshot doc){
    return NoteDto.fromJson(doc.data()!).copyWith(id: doc.id);
  }
}


@freezed
abstract class TodoItemDto implements _$TodoItemDto {
  const TodoItemDto._();

  const factory TodoItemDto({
    required String id,
    required String name,
    required bool done,
  }) = _TodoItemDto;

  factory TodoItemDto.fromDomain(TodoItem todoItem) {
    return TodoItemDto(
      id: todoItem.id.getOrCrash(),
      name: todoItem.name.getOrCrash(),
      done: todoItem.done,
    );
  }

  TodoItem toDomain() {
    return TodoItem(
      id: UniqueId.fromUniqueString(this.id),
      name: TodoName(name),
      done: done,
    );
  }

  factory TodoItemDto.fromJson(Map<String, dynamic> json) => _$TodoItemDtoFromJson(json);
}
