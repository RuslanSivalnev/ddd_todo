import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_to_do_ddd/application/notes/note_form/note_form_bloc.dart';
import 'package:flutter_to_do_ddd/domain/notes/value_object.dart';
import 'package:flutter_to_do_ddd/presentation/notes/note_form/misc/todo_item_presentation_classes.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:kt_dart/kt.dart';
import 'package:provider/provider.dart';
import 'package:flutter_to_do_ddd/presentation/notes/note_form/misc/build_context_x.dart';

class TodoListWidget extends StatelessWidget {
  const TodoListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<NoteFormBloc, NoteFormState>(
      listenWhen: (p, c) => p.note.todos.isFull != c.note.todos.isFull,
      listener: (context, state) {
        if (state.note.todos.isFull) {
          FlushbarHelper.createAction(
            message: 'Want longer list? Active premium',
            button: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(primary: Colors.lightBlue),
              child: const Text(
                'BUY NOW',
                style: TextStyle(color: Colors.yellow),
              ),
            ),
            duration: const Duration(seconds: 5),
          ).show(context);
        }
      },
      child: Consumer<FormTodos>(
        builder: (context, formTodos, child) {
          return ImplicitlyAnimatedReorderableList<TodoItemPrimitive>(
            shrinkWrap: true,
            items: formTodos.value.asList(),
            removeDuration: const Duration(milliseconds: 0),
            areItemsTheSame: (oldItem, newItem) => oldItem.id == newItem.id,
            onReorderFinished: (item, from, to, List<TodoItemPrimitive> newItems) {
              context.formTodos = newItems.toImmutableList();

              BlocProvider.of<NoteFormBloc>(context).add(NoteFormEvent.todosChanged(context.formTodos));
            },
            itemBuilder: (context, itemAnimation, item, index) {
              return Reorderable(
                key: ValueKey(item.id),
                builder: (context, dragAnimation, isDrag) {
                  return ScaleTransition(
                    scale: Tween<double>(begin: 1, end: 0.95).animate(dragAnimation),
                    child: TodoTile(
                      index: index,
                      elevation: dragAnimation.value * 4,
                    ),
                  );
                },
              );
            },
          );

          // return ListView.builder(
          //   shrinkWrap: true,
          //   itemCount: formTodos.value.size,
          //   itemBuilder: (context, index) {
          //     return TodoTile(
          //       index: index,
          //     );
          //   },
          // );
        },
      ),
    );
  }
}

class TodoTile extends HookWidget {
  final int index;
  final double elevation;

  const TodoTile({
    Key? key,
    double? elevation,
    required this.index,
  })  : elevation = elevation ?? 0,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final todo = context.formTodos.getOrElse(index, (_) => TodoItemPrimitive.empty());

    final textEditingController = useTextEditingController(text: todo.name);

    return Slidable(
      actionPane: const SlidableDrawerActionPane(),
      actionExtentRatio: .15,
      secondaryActions: [
        IconSlideAction(
          caption: 'Delete',
          icon: Icons.delete,
          color: Colors.red,
          onTap: () {
            context.formTodos = context.formTodos.minusElement(todo);

            BlocProvider.of<NoteFormBloc>(context).add(NoteFormEvent.todosChanged(context.formTodos));
          },
        ),
      ],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        child: Material(
          elevation: elevation,
          animationDuration: const Duration(milliseconds: 50),
          borderRadius: BorderRadius.circular(8),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListTile(
              leading: Checkbox(
                value: todo.done,
                onChanged: (value) {
                  context.formTodos =
                      context.formTodos.map((listTodo) => listTodo == todo ? todo.copyWith(done: value!) : listTodo);

                  BlocProvider.of<NoteFormBloc>(context).add(NoteFormEvent.todosChanged(context.formTodos));
                },
              ),
              trailing: const Handle(
                child: Icon(Icons.list),
              ),
              title: TextFormField(
                controller: textEditingController,
                decoration: const InputDecoration(
                  hintText: 'Todo',
                  counterText: '',
                  border: InputBorder.none,
                ),
                maxLength: TodoName.maxLength,
                onChanged: (value) {
                  context.formTodos =
                      context.formTodos.map((listTodo) => listTodo == todo ? todo.copyWith(name: value) : listTodo);

                  BlocProvider.of<NoteFormBloc>(context).add(NoteFormEvent.todosChanged(context.formTodos));
                },
                validator: (_) {
                  return BlocProvider.of<NoteFormBloc>(context).state.note.todos.value.fold(
                        (f) => null,
                        (todoList) => todoList[index].name.value.fold(
                              (f) => f.maybeMap(
                                empty: (_) => 'Cannot be empty',
                                exceedingLength: (_) => 'Too long',
                                multiline: (_) => 'Has to be in a single line',
                                orElse: () => null,
                              ),
                              (_) => null,
                            ),
                      );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
