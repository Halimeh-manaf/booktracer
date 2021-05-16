import 'package:booktracer/database/columns.dart';

class Notes {
  int bookID;
  String note;
  int id;
  int pageNumber;

  Notes({this.bookID, this.note, this.pageNumber, this.id});

  Notes.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    bookID = map[columnBookID];
    note = map[columnNote];
    pageNumber = map[columnNotePageNumber];
  }
  // convenience method to create a Map from this Word object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnBookID: bookID,
      columnNote: note,
      columnNotePageNumber: pageNumber
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  String toString() {
    return "ID: " +
        id.toString() +
        " bookID: " +
        bookID.toString() +
        " Page Number: " +
        pageNumber.toString() +
        " Notes: " +
        note;
  }
}
