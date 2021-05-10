import 'package:flutter/material.dart';
import 'package:flutter_to_do_ddd/domain/notes/note.dart';

class ErrorNoteCardWidget extends StatelessWidget {
  final Note note;

  const ErrorNoteCardWidget({Key? key, required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Theme.of(context).errorColor,
        child: Padding(
          padding: const EdgeInsets.all(4.00),
          child: Column(
            children: [
              Text('Invalid note, please contact support',
                  style: Theme.of(context).primaryTextTheme.bodyText2?.copyWith(fontSize: 18)),
              const SizedBox(height: 2),
              Text('Details for nerds:', style: Theme.of(context).primaryTextTheme.bodyText2),
              Text(note.failureOption.fold(() => '', (f) => f.toString()),
                  style: Theme.of(context).primaryTextTheme.bodyText2),
            ],
          ),
        ));
  }
}
