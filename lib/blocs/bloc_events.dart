import 'package:flutter/material.dart';

import '../models/note_model.dart';

abstract class NoteEvents {}

class GetAllNotesEvent extends NoteEvents {} //when we want to show all notes

class ClickAddNoteEvent extends NoteEvents {
  final BuildContext context;
  ClickAddNoteEvent(this.context);
} //when add button is clicked

class ClickCalenderEvent extends NoteEvents {
  final BuildContext context;
  ClickCalenderEvent(this.context);
}

class SaveNoteEvent extends NoteEvents {
  //Note is saved
  final Note note;
  SaveNoteEvent({required this.note});
} //rebuild home screen and show snack bar when this happens

class BackPressedEvent extends NoteEvents {}

class ViewNoteEvent extends NoteEvents {
  //Note is saved
  final Note note;
  final BuildContext context;
  ViewNoteEvent({required this.note, required this.context});
}

class GetSelectedDateNotesEvent extends NoteEvents {
  final String date;
  GetSelectedDateNotesEvent({required this.date});
}//rebuilds calender screen when a date is selected

