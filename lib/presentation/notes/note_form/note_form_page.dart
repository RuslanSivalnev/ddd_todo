import 'package:another_flushbar/flushbar_helper.dart';
import 'package:auto_route/auto_route.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_to_do_ddd/application/notes/note_form/note_form_bloc.dart';
import 'package:flutter_to_do_ddd/domain/notes/note.dart';
import 'package:flutter_to_do_ddd/presentation/notes/note_form/widgets/add_todo_tile_widgets.dart';
import 'package:flutter_to_do_ddd/presentation/notes/note_form/widgets/body_field_widget.dart';
import 'package:flutter_to_do_ddd/presentation/notes/note_form/widgets/color_field_widget.dart';

import '../../../injection.dart';

class NoteFormPage extends StatelessWidget {
  final Note? editedNote;

  const NoteFormPage({Key? key, this.editedNote}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<NoteFormBloc>()..add(NoteFormEvent.initialized(optionOf(editedNote))),
      child: BlocConsumer<NoteFormBloc, NoteFormState>(
        listenWhen: (p, c) => p.saveFailureOrSuccessOption != c.saveFailureOrSuccessOption,
        listener: (context, state) {
          state.saveFailureOrSuccessOption.fold(
            () => null,
            (either) {
              return either.fold(
                (failure) {
                  FlushbarHelper.createError(
                    message: failure.map(
                      insufficientPermissions: (_) => 'Insufficient permissions ❌',
                      unexpected: (_) => "Couldn't update the note. Was it deleted from another device?",
                      unableToUpdate: (_) => 'Unexpected error occured, please contact support.',
                    ),
                  ).show(context);
                },
                (_) {
                  AutoRouter.of(context).pop();
                },
              );
            },
          );
        },
        buildWhen: (p, c) => p.isSaving != c.isSaving,
        builder: (context, state) {
          return Stack(
            children: [
              NoteFormPageScaffold(),
              SavingInProgressOverlay(isSaving: state.isSaving),
            ],
          );
        },
      ),
    );
  }
}

class SavingInProgressOverlay extends StatelessWidget {
  final bool isSaving;

  const SavingInProgressOverlay({Key? key, required this.isSaving}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !isSaving,
      child: AnimatedContainer(
        // full screen size
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,

        duration: const Duration(milliseconds: 150),
        color: isSaving ? Colors.black.withOpacity(0.8) : Colors.transparent,
        child: Visibility(
          visible: isSaving,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 10),
              Text(
                'Saving',
                style: Theme.of(context).primaryTextTheme.bodyText2?.copyWith(
                      color: Colors.white,
                      fontSize: 20,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NoteFormPageScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<NoteFormBloc, NoteFormState>(
          buildWhen: (p, c) => p.isEditing != c.isEditing,
          builder: (BuildContext context, state) {
            return Text(state.isEditing ? 'Edit a note' : 'Create a note');
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              BlocProvider.of<NoteFormBloc>(context).add(const NoteFormEvent.saved());
            },
          )
        ],
      ),
      body: BlocBuilder<NoteFormBloc, NoteFormState>(
        buildWhen: (p, c) => p.showErrorMessages != c.showErrorMessages,
        builder: (context, state) {
          return Form(
            autovalidate: state.showErrorMessages,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const BodyField(),
                  const ColorFieldWidget(),
                  const AddTodoTileWidgets(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
