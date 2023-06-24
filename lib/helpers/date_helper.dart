import 'package:intl/intl.dart';

const String dateFormatter='MMMM dd, y';

extension DateHelper on DateTime{
  String formatDate(){
    final formatter=DateFormat(dateFormatter); 
    return formatter.format(this);
  }

  bool isSameDate(DateTime other){
    return this.year==other.year && this.month==other.month && this.day==other.day;
  }
}