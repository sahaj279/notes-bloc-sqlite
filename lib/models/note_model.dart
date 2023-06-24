const String tableNotes = 'notes';

class NoteFiels {
  static final List<String> values = [id, title, desc, datetime,date];
  static const String id = '_id';
  static const String title = 'title';
  static const String desc = 'description';
  static const String datetime = 'dateTime';
  static const String date = 'date';
}

class Note {
  int? id;
  String? title;
  String? desc;
  DateTime? dateadded;

  Note({this.id, this.title, this.desc, this.dateadded});

  Note copy(
          {int? id,
          String? title,
          String? desc,
          DateTime? dateadded}) =>
      Note(
          id: id ?? this.id,
          title: title ?? this.title,
          desc: desc ?? this.desc,
          dateadded: dateadded ?? this.dateadded);

  Map<String, Object?> toMap() => {
        NoteFiels.id: id,
        NoteFiels.title: title,
        NoteFiels.desc: desc,
        NoteFiels.datetime: dateadded?.toIso8601String(),
        NoteFiels.date:dateadded?.toIso8601String().substring(0,10)
      };

  static Note fromJson(Map<String, Object?> map) => Note(
      id: map[NoteFiels.id] as int?,
      title: map[NoteFiels.title] as String?,
      desc: map[NoteFiels.desc] as String?,
      dateadded: DateTime.parse(map[NoteFiels.datetime] as String));
}
