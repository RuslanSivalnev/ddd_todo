import 'package:flutter/material.dart';
import 'package:flutter_to_do_ddd/domain/notes/note_failure.dart';

class CriticalFailureDisplayWidget extends StatelessWidget {
  final NoteFailure failure;

  const CriticalFailureDisplayWidget({Key? key, required this.failure}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('😱', style: TextStyle(fontSize: 100)),
          Text(
            failure.maybeMap(
              insufficientPermissions: (_) => 'Insufficient permissions',
              orElse: () => 'Unexpected error. \nPlease, contact support.',
            ),
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 24),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.mail),
                const SizedBox(width: 4,),
                Text('I need help')
              ],
            ),
          )
        ],
      ),
    );
  }
}
