import 'package:booktracer/database/columns.dart';
import 'package:booktracer/model/notes.dart';

class Book {
  String title;
  DateTime startDate;
  DateTime endDate;
  int pageNumber;
  int totalPagesNumber;
  int isDone;
  int id;
  List<Notes> notes = [];

  Book(
      {this.title,
      this.startDate,
      this.pageNumber,
      this.totalPagesNumber,
      this.isDone,
      this.endDate,
      this.id});

  // convenience constructor to create a Word object
  Book.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    title = map[columnTitle];
    pageNumber = map[columnPageNumber];
    startDate = DateTime.fromMicrosecondsSinceEpoch(map[columnStartDate]);
    endDate = DateTime.fromMicrosecondsSinceEpoch(map[columnEndDate]);
    totalPagesNumber = map[columnTotalPageNumber];
    isDone = map[columnIsDone];
  }

  // convenience method to create a Map from this Word object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnTitle: title,
      columnPageNumber: pageNumber,
      columnStartDate: startDate.microsecondsSinceEpoch,
      columnEndDate: endDate.microsecondsSinceEpoch,
      columnTotalPageNumber: totalPagesNumber,
      columnIsDone: isDone
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  String toString() {
    return "ID: " +
        id.toString() +
        " title: " +
        title +
        " Current Page number: " +
        pageNumber.toString() +
        " Total pages number: " +
        totalPagesNumber.toString() +
        " Start date: " +
        startDate.toString() +
        " end date: " +
        endDate.toString() +
        " isDone " +
        isDone.toString();
  }
}
