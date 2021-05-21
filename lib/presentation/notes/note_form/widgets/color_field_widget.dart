import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_to_do_ddd/application/notes/note_form/note_form_bloc.dart';
import 'package:flutter_to_do_ddd/domain/notes/value_object.dart';

class ColorFieldWidget extends StatelessWidget {
  const ColorFieldWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteFormBloc, NoteFormState>(
      buildWhen: (p, c) => p.note.color != c.note.color,
      builder: (context, state) {
        return Container(
          height: 80,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: NoteColor.predefinedColors.length,
            itemBuilder: (context, index) {
              final itemColor = NoteColor.predefinedColors[index];
              return GestureDetector(
                onTap: () {
                  BlocProvider.of<NoteFormBloc>(context).add(NoteFormEvent.colorChanged(itemColor));
                },
                child: Material(
                  elevation: 4,
                  shape: CircleBorder(
                    side: state.note.color.value.fold(
                          (_) => BorderSide.none,
                          (color) => itemColor == color ? const BorderSide(width: 1.5) : BorderSide.none,
                    ),
                  ),
                  color: itemColor,
                  child: Container(
                    height: 50,
                    width: 50,
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(width: 12);
            },
          ),
        );
      },
    );
  }
}
