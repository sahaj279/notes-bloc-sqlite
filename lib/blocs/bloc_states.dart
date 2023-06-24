import '../models/note_model.dart';

abstract class NoteAppStates {}

class LoadingState extends NoteAppStates {}

class InitialCalendarState extends NoteAppStates {
  // List<String> dates;
  // InitialCalendarState(this.dates);
}

class ShowAllNoteState extends NoteAppStates {
  List<Note> notes;
  ShowAllNoteState(this.notes);
}

class EmptyNoteState extends NoteAppStates {}

class SuccessfullySavedState extends NoteAppStates {}

class ShowSelectedDateNoteStates extends NoteAppStates {
  List<Note> notes;
  ShowSelectedDateNoteStates(this.notes);
}

class NoteViewingState extends NoteAppStates {}
