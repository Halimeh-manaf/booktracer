import 'package:booktracer/database/database_helper.dart';
import 'package:booktracer/model/book.dart';
import 'package:booktracer/model/book_provider.dart';
import 'package:booktracer/model/constants.dart';
import 'package:booktracer/model/date_time_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class BookDialog extends StatefulWidget {
  final String bookTitle;
  final DateTime date;
  final int pageNumber;

  BookDialog({
    Key key,
    this.bookTitle,
    this.date,
    this.pageNumber,
  }) : super(key: key);

  @override
  _BookDialogState createState() => _BookDialogState();
}

class _BookDialogState extends State<BookDialog> {
  final booktitleController = TextEditingController();

  final totalPageNumberController = TextEditingController();

  final pageNumberController = TextEditingController();

  bool isVisible = false;

  final dbHelper = DatabaseHelper.instance;

  @override
  Widget build(BuildContext context) {
    pageNumberController.text = "1";
    return SingleChildScrollView(
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Constants.padding),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: contentBox(context),
      ),
    );
  }

  contentBox(context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(
              left: Constants.padding,
              top: Constants.avatarRadius + Constants.padding,
              right: Constants.padding,
              bottom: Constants.padding),
          margin: EdgeInsets.only(top: Constants.avatarRadius),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(Constants.padding),
              boxShadow: [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 1), blurRadius: 1),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Add a book :)",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: booktitleController,
                decoration: InputDecoration(labelText: "Book Title"),
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 22,
              ),
              TextField(
                controller: totalPageNumberController,
                decoration: InputDecoration(labelText: "Total pages number"),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 22,
              ),
              TextField(
                controller: pageNumberController,
                decoration: InputDecoration(labelText: "Start from page"),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 22,
              ),
              DatePicker(selectedDate: widget.date),
              SizedBox(
                height: 22,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: () async {
                    if (Provider.of<DateTimeProvider>(context, listen: false)
                            .dates ==
                        null) {
                      Provider.of<DateTimeProvider>(context, listen: false)
                          .changeTime(DateTime.now());
                    }
                    print("Title: " + booktitleController.text);
                    print("Total pages number: " +
                        totalPageNumberController.text);
                    print(
                        "Start page: " + pageNumberController.text.toString());
                    print("date: " +
                        Provider.of<DateTimeProvider>(context, listen: false)
                            .dates
                            .toString());
                    if (booktitleController.text.isEmpty ||
                        totalPageNumberController.text.isEmpty ||
                        pageNumberController.text.isEmpty) {
                      setState(() {
                        isVisible = true;
                      });
                    } else {
                      Provider.of<BookProvider>(context, listen: false).addBook(
                        book: Book(
                          title: booktitleController.text,
                          startDate: Provider.of<DateTimeProvider>(context,
                                  listen: false)
                              .dates,
                          pageNumber: int.parse(pageNumberController.text),
                          totalPagesNumber:
                              int.parse(totalPageNumberController.text),
                          endDate: DateTime(0),
                          isDone: 0,
                        ),
                      );
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text(
                    "Add",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              Visibility(
                visible: isVisible,
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "Please fill all mandatory fields ;)",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DatePicker extends StatefulWidget {
  final DateTime selectedDate;
  DatePicker({this.selectedDate, Key key}) : super(key: key);

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime selectedDate = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        Provider.of<DateTimeProvider>(context, listen: false)
            .changeTime(picked);
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text("${selectedDate.toLocal()}".split(' ')[0]),
          SizedBox(
            height: 10.0,
            width: 20.0,
          ),
          ElevatedButton(
            onPressed: () => _selectDate(context),
            child: Text('Select start date'),
          ),
        ],
      ),
    );
  }
}
