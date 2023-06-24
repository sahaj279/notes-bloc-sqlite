import 'package:bloc_and_notes/blocs/bloc_events.dart';
import 'package:bloc_and_notes/components/calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/bloc_file.dart';
import '../blocs/bloc_states.dart';
import '../components/note_tile.dart';

class CalenderPage extends StatelessWidget {
 final List<String> dates;
  const CalenderPage({super.key,required this.dates});

  @override
  Widget build(BuildContext context) {
    final NoteBloc noteBloc = BlocProvider.of<NoteBloc>(context);
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        noteBloc.add(BackPressedEvent());
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Calendar'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(5),
            child: Column(children: [
              CalenderWidget(
                notebloc: noteBloc,
                dates: dates,
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: BlocBuilder<NoteBloc, NoteAppStates>(
                  builder: (context, state) {
                    if (state is InitialCalendarState) {
                      // dates = state.dates;
                      return const Text('Click a date to view notes!');
                    } else if (state is ShowSelectedDateNoteStates) {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.notes.length,
                          itemBuilder: (context, index) {
                            return NoteTile(
                              note: state.notes[index],
                              noteBloc: noteBloc,
                            );
                          }
                          // Text(state.notes[index].toMap().toString())
                          );
                    }
                    //EmptyNoteState
                    return const Text('No note on this date');
                  },
                ),
                //when date is selected, list view would be shown here
              )
            ]),
          )),
    );
  }
}
