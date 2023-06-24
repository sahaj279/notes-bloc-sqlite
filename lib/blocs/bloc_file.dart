import 'package:bloc_and_notes/blocs/bloc_events.dart';
import 'package:bloc_and_notes/blocs/bloc_states.dart';
import 'package:bloc_and_notes/db/notes_database.dart';
import 'package:bloc_and_notes/pages/add_note_page.dart';
import 'package:bloc_and_notes/pages/calender_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/note_model.dart';

class NoteBloc extends Bloc<NoteEvents, NoteAppStates> {
  NoteBloc() : super(LoadingState()) {
    on<GetAllNotesEvent>((event, emit) async {
      List<Note> notes = await NotesDatabase.instance.readAllNotes();
      if (notes.isEmpty) return emit(EmptyNoteState());
      return emit(ShowAllNoteState(notes));
    });

    on<ClickAddNoteEvent>((event, emit) {
      Navigator.push(event.context,
          MaterialPageRoute(builder: (context) => const AddNotes()));
    });

    on<ClickCalenderEvent>((event, emit) async {
      List<String> dates = await NotesDatabase.instance.getDistinctDates();
      emit(InitialCalendarState());
      Navigator.push(event.context,
          MaterialPageRoute(builder: (context) =>  CalenderPage(dates: dates,)));
    });

    on<SaveNoteEvent>((event, emit) async {
      Note note = event.note;
      note = await NotesDatabase.instance.create(note);
      // print(note.toMap());
      emit(SuccessfullySavedState());
      // add((GetSelectedDateNotesEvent(date: DateTime.now().toIso8601String().substring(0,10))));
      return emit(LoadingState());
      // List<Note> notes = await NotesDatabase.instance.readAllNotes();
      // return emit(ShowAllNoteState(notes));
    });
    on<GetSelectedDateNotesEvent>((event, emit) async {
      List<Note> notes =
          await NotesDatabase.instance.readNoteForDate(event.date);
      if (notes.isEmpty) return emit(EmptyNoteState());
      return emit(ShowSelectedDateNoteStates(notes));
    });

    on<ViewNoteEvent>((event, emit) {
      emit(NoteViewingState());
      Navigator.push(event.context,
          MaterialPageRoute(builder: (context) => AddNotes(note: event.note)));
    });

    on<BackPressedEvent>(
      (event, emit) => emit(LoadingState()),
    );
  }
}
