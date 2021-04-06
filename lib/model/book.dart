import 'package:booktracer/database/columns.dart';

class Book {
  String title;
  DateTime startDate;
  DateTime endDate;
  int pageNumber;
  int totalPagesNumber;
  bool isDone;
  int id = 0;

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
}
