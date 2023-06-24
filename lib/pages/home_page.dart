import 'package:bloc_and_notes/blocs/bloc_events.dart';
import 'package:bloc_and_notes/blocs/bloc_file.dart';
import 'package:bloc_and_notes/blocs/bloc_states.dart';
import 'package:bloc_and_notes/helpers/date_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/note_tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _openAddNotePage(NoteBloc noteBloc, BuildContext context) {
    noteBloc.add(ClickAddNoteEvent(context));
    // Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddNotes()));
  }
    void _openCalenderPage(NoteBloc noteBloc, BuildContext context) {
    noteBloc.add(ClickCalenderEvent(context));
  }

  @override
  Widget build(BuildContext context) {
    final noteBloc = BlocProvider.of<NoteBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes App'),
        actions: [IconButton(icon:Icon(Icons.refresh) ,onPressed: (){noteBloc.add(GetAllNotesEvent());},),],
      ),
      body: Column(
        // mainAxisSize: MainAxisSize.min, 
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: BlocConsumer<NoteBloc, NoteAppStates>(
              listener: (context, state) {
                if (state is SuccessfullySavedState) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Note Saved Successfully'),
                    backgroundColor: Colors.green,
                  ));
                }
              },
              builder: (context, state) {
                print((state.runtimeType) );
                if (state is LoadingState) {
                  // BlocProvider.of<NoteBloc>(context).add(GetNotesEvent());
                  BlocProvider.of<NoteBloc>(context).add(GetSelectedDateNotesEvent(date: DateTime.now().toIso8601String().substring(0,10)));
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ShowAllNoteState) {
                  return ListView.builder(
                    // physics: NeverScrollableScrollPhysics(),
                    
                      shrinkWrap: true,
                      itemCount: state.notes.length,
                      itemBuilder: (context, index) {
                        
                        final item=state.notes;
                        bool isSameDate=true;
                        if(index==0){
                          isSameDate=false;
                        }else{
                          final DateTime prevDate=item[index-1].dateadded!;
                          isSameDate=prevDate.isSameDate(item[index].dateadded!) ;
                        }
                        if(!isSameDate){
                          return Column(mainAxisSize: MainAxisSize.min, 
                          children: [
                            Text(item[index].dateadded!.formatDate()), 
                            NoteTile(note:item[index], noteBloc: noteBloc,)
            
                          ],);
                        }
                        return NoteTile(note:item[index],noteBloc: noteBloc, );
                      }
                      // Text(state.notes[index].toMap().toString())
                      );
                }else if(state is ShowSelectedDateNoteStates){
                   return ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.notes.length,
                    itemBuilder: (context, index) {
                      if(index==0){
                        return Column(mainAxisSize: MainAxisSize.min, 
                          children: [
                            Text(state.notes[index].dateadded!.formatDate()), 
                            NoteTile(note:state.notes[index],noteBloc: noteBloc,)
            
                          ],);
                      }
                      return NoteTile(note: state.notes[index],noteBloc: noteBloc,);
                    }
                    // Text(state.notes[index].toMap().toString())
                    );
                }
                //EmptyNoteState
                return const Center(
                  child: Text('Add a new note'),
                );
              },
            ),
          ),
          SizedBox(
            height: 60,
            // alignment: Alignment.bottomLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: (){_openCalenderPage(noteBloc, context);},
                  // onTap:(){Navigator.push(context,MaterialPageRoute(builder: (context)=>const CalenderPage()));},
                  
                  child:const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Icon(Icons.calendar_month,color: Colors.deepPurple,),
                )),
                InkWell(onTap:(){_openAddNotePage(noteBloc, context);},child:const Padding(
                  padding:  EdgeInsets.all(10),
                  child: Icon(Icons.add,color: Colors.deepPurple,),
                )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
