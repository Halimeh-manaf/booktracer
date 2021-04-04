import 'package:flutter/material.dart';

class DateTimeProvider extends ChangeNotifier {
  DateTime date;

  DateTime get dates => date;

  void changeTime(DateTime dateTime) {
    this.date = dateTime;
    notifyListeners();
  }
}
