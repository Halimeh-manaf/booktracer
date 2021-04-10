import 'package:booktracer/model/book.dart';
import 'package:flutter/material.dart';

class BookProvider extends ChangeNotifier {
  List<Book> _bookList = [];

  List<Book> get books => _bookList;
  void addBook({Book book}) {
    _bookList.add(book);
    notifyListeners();
  }

  void finishBook(int id) {
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
        _bookList[id].isDone = 1;
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
}
