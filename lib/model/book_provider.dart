import 'package:booktracer/database/columns.dart';
import 'package:booktracer/database/database_helper.dart';
import 'package:booktracer/model/book.dart';
import 'package:flutter/material.dart';

class BookProvider extends ChangeNotifier {
  List<Book> _bookList = [];
  final DatabaseHelper dbHelper = DatabaseHelper.instance;

  List<Book> get books => _bookList;
  void addBook({Book book}) async {
    _bookList.add(book);
    await dbHelper.insert(book);
    notifyListeners();
  }

  BookProvider(this._bookList) {
    if (dbHelper != null) fetchAndSetData();
  }

  Future<void> fetchAndSetData() async {
    if (dbHelper != null) {
      // do not execute if db is not instantiate
      final dataList = await dbHelper.queryTable(tableBooks);
      _bookList = dataList.map((item) => Book.fromMap(item)).toList();
      print(dataList.toString());
      notifyListeners();
    }
  }

  void finishBook(int id) {
    print(
        "List ID: " + id.toString() + " DB ID: " + _bookList[id].id.toString());
    _bookList[id].isDone = 1;
    _bookList[id].totalPagesNumber = _bookList[id].totalPagesNumber;
    _bookList[id].pageNumber = _bookList[id].totalPagesNumber;
    _bookList[id].endDate = DateTime.now();
    notifyListeners();
  }

  void increamentPage(int id) {
    if (_bookList[id].pageNumber + 1 > _bookList[id].totalPagesNumber) {
      notifyListeners();
    } else {
      _bookList[id].pageNumber++;
      if (_bookList[id].pageNumber == _bookList[id].totalPagesNumber) {
        finishBook(id);
        notifyListeners();
      }
      notifyListeners();
    }
  }

  void decreamentPage(int id) {
    if (_bookList[id].pageNumber - 1 == 0) {
      notifyListeners();
    } else {
      _bookList[id].pageNumber--;
      _bookList[id].isDone = 0;
      notifyListeners();
    }
  }

  Future<void> deleteAllRows() async {
    _bookList = [];
    await dbHelper.deleteAllRows();
    notifyListeners();
  }
}
