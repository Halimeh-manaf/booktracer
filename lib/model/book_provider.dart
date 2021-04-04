import 'package:booktracer/model/book.dart';
import 'package:flutter/material.dart';

class BookProvider extends ChangeNotifier {
  List<Book> _bookList = [];

  List<Book> get books => _bookList;
  void addBook({Book book}) {
    _bookList.add(book);
    notifyListeners();
  }

  void increamentPage(int id) {
    if (_bookList[id].pageNumber + 1 > _bookList[id].totalPagesNumber) {
      notifyListeners();
    } else {
      _bookList[id].pageNumber++;
      if (_bookList[id].pageNumber == _bookList[id].totalPagesNumber) {
        _bookList[id].isDone = true;
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
      _bookList[id].isDone = false;

      notifyListeners();
    }
  }
}
