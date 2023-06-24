import 'package:bloc_and_notes/blocs/bloc_events.dart';
import 'package:bloc_and_notes/blocs/bloc_file.dart';
import 'package:bloc_and_notes/blocs/bloc_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/note_model.dart';

class AddNotes extends StatefulWidget {
  final Note? note;
  const AddNotes({super.key, this.note});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  FocusNode nodeFocus = FocusNode();

@override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    super.dispose();
  }
  @override
  void initState() {
    super.initState();

    // if(widget.isUpdate){
    //   titleController.text=widget.n!.title!;
    //   descController.text=widget.n!.desc!;
    // }
  }

  void addNote(NoteBloc noteBloc) {
    Note newNote = Note(
      title: titleController.text,
      desc: descController.text,
      dateadded: DateTime.now(),
    );

    // save note to database and update the state using bloc
    noteBloc.add(SaveNoteEvent(note: newNote));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final NoteBloc notebloc = BlocProvider.of<NoteBloc>(context);
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        notebloc.add(BackPressedEvent());
        return false;
      },
      child: BlocBuilder<NoteBloc, NoteAppStates>(
        builder: (context, state) {
          bool enabled = true;
          if (state is NoteViewingState) {
            enabled = false;
            titleController.text = widget.note!.title!;
            descController.text = widget.note!.desc!;
          }
          return Scaffold(
              appBar: AppBar(
                actions: [
                  enabled?
                  IconButton(
                    
                      onPressed: () {
                        addNote(notebloc);
                      },
                      icon: const Icon(Icons.check)):Container()
                ],
              ),
              body: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: ListView(
                  children: [
                    TextField(
                      enabled: enabled,
                      controller: titleController,
                      onSubmitted: (value) {
                        if (value.isNotEmpty) {
                          nodeFocus
                              .requestFocus(); //now when we press enter, we directly move to next textfield which has the focus node
                        }
                      },
                      autofocus: true,
                      style: const TextStyle(
                          fontSize: 35, fontWeight: FontWeight.w500),
                      decoration: const InputDecoration(
                          hintText: 'Title', border: InputBorder.none),
                    ),
                    Expanded(
                      child: TextField(
                        enabled: enabled,
                        scrollPhysics: const NeverScrollableScrollPhysics(),
                        controller: descController,
                        focusNode: nodeFocus,
                        maxLines: null,
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Content',
                        ),
                      ),
                    )
                  ],
                ),
              ));
        },
      ),
    );
  }
}
