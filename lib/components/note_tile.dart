import 'package:bloc_and_notes/blocs/bloc_events.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../blocs/bloc_file.dart';
import '../models/note_model.dart';

class NoteTile extends StatelessWidget {
  final Note note;
  final NoteBloc noteBloc;
  const NoteTile({super.key, required this.note,required this.noteBloc});

  @override
  Widget build(BuildContext context) {
    return InkWell( 
      onTap: (){
        noteBloc.add(ViewNoteEvent(note: note, context: context));
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            // color: Colors.yellow.shade100,
            border: Border.all(color: Colors.black12, width: 1),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              note.title!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            // const SizedBox(
            //   height: 2,
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  note.desc!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text( DateFormat.jm().format(note.dateadded!))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
