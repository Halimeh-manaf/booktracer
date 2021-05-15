import 'package:booktracer/database/columns.dart';

class Notes {
  int bookID;
  String note;
  int id;

  Notes({this.bookID, this.note});

  Notes.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    note = map[columnNote];
    bookID = map[columnBookID];
  }
  // convenience method to create a Map from this Word object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{columnBookID: bookID, columnNote: note};
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }
}
