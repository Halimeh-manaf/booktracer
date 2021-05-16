import 'package:booktracer/database/columns.dart';
import 'package:booktracer/database/database_helper.dart';
import 'package:booktracer/model/book.dart';
import 'package:booktracer/model/notes.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BookProvider extends ChangeNotifier {
  List<Book> _bookList = [];
  final DatabaseHelper dbHelper = DatabaseHelper.instance;
  List<Notes> _notesList = [];
  List<Notes> _noteOneBookList = [];

  BookProvider(this._bookList) {
    if (dbHelper != null) fetchAndSetData();
  }

  List<Book> get books => _bookList;
  List<Notes> get notes => _notesList;

  List<Notes> getNotes(int id) {
    _noteOneBookList = [];
    for (Notes item in _notesList) {
      if (item.bookID == id) {
        _noteOneBookList.add(item);
      }
    }
    return _noteOneBookList;
  }

  void addBook({Book book}) async {
    _bookList.add(book);
    await dbHelper.insert(book);
    notifyListeners();
  }

  void addNote({Notes note}) async {
    _notesList.add(note);
    await dbHelper.insertNote(note);
    getNotes(note.bookID);
    notifyListeners();
  }

  Future<void> fetchAndSetData() async {
    if (dbHelper != null) {
      // do not execute if db is not instantiate
      final dataList = await dbHelper.queryTable(tableBooks);
      _bookList = dataList.map((item) => Book.fromMap(item)).toList();
      print("Books: " + _bookList.toString());

      final notesList = await dbHelper.queryTable(tableNotes);
      _notesList = notesList.map((item) => Notes.fromMap(item)).toList();
      print("Notes: " + _notesList.toString());
      notifyListeners();
    }
  }

  void finishBook(int id) async {
    print(
        "List ID: " + id.toString() + " DB ID: " + _bookList[id].id.toString());
    Fluttertoast.showToast(
        msg: "Congrats 🎉 You can find the book in Archive",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blueAccent,
        textColor: Colors.white,
        fontSize: 16.0);
    _bookList[id].isDone = 1;
    _bookList[id].totalPagesNumber = _bookList[id].totalPagesNumber;
    _bookList[id].pageNumber = _bookList[id].totalPagesNumber;
    _bookList[id].endDate = DateTime.now();
    await dbHelper.updateBook(_bookList[id]);

    notifyListeners();
  }

  void definishBook(int id) async {
    _bookList[id].pageNumber--;
    if (_bookList[id].isDone == 1) {
      _bookList[id].isDone = 0;
      Fluttertoast.showToast(
          msg: "You can find the book in Home",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blueAccent,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    dbHelper.updateBook(_bookList[id]);
    notifyListeners();
  }

  void increamentPage(int id) {
    if (_bookList[id].pageNumber + 1 > _bookList[id].totalPagesNumber) {
      notifyListeners();
    } else {
      _bookList[id].pageNumber++;
      dbHelper.updateBook(_bookList[id]);
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
      definishBook(id);
    }
  }

  Future<void> deleteAllRows() async {
    _bookList = [];
    await dbHelper.deleteAllRows();
    notifyListeners();
  }

  Future<void> deleteBook(int id) async {
    int dbID = _bookList[id].id;
    await dbHelper.deleteById(dbID);
    _bookList.removeAt(id);
    print(_bookList.toString());
    notifyListeners();
  }
}
