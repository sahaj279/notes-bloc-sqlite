import 'package:bloc_and_notes/blocs/bloc_events.dart';
import 'package:bloc_and_notes/blocs/bloc_file.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderWidget extends StatefulWidget {
  final NoteBloc notebloc;
  final List<String>dates;
  const CalenderWidget({super.key,required this.notebloc,required this.dates});

  @override
  State<CalenderWidget> createState() => _CalenderWidgetState();
}

  DateTime _selectedDate = DateTime.now();
class _CalenderWidgetState extends State<CalenderWidget> {

  @override
  Widget build(BuildContext context) {
    // print(_selectedDate);
    return TableCalendar(
      firstDay: DateTime.utc(2020, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      focusedDay: _selectedDate,
      currentDay: DateTime.now(),
      selectedDayPredicate: (day) =>isSameDay(day, _selectedDate),
      onDaySelected: ((selectedDay, focusedDay) {
        _selectedDate = focusedDay;
        widget.notebloc.add(GetSelectedDateNotesEvent(date: _selectedDate.toIso8601String().substring(0,10)));
        setState(() {});
      }),
      calendarBuilders: CalendarBuilders(
              prioritizedBuilder: (context, day, focusedDay) {
                for (String  date in widget.dates) {
                  print(date);
                  print(day.toIso8601String().substring(0,10));
                  if(day.toIso8601String().substring(0,10)==date){
                    return Container(
                      // width: 40,
                      // height: 40,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        
                        borderRadius: BorderRadius.all(
                          Radius.circular(30.0),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '${day.day}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  }
                }
                return null;
              },
            ),
    );
  }
}
