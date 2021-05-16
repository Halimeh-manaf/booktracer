import 'package:booktracer/database/database_helper.dart';
import 'package:booktracer/model/book_provider.dart';
import 'package:booktracer/model/constants.dart';
import 'package:booktracer/model/notes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class NoteDialog extends StatefulWidget {
  final String note;
  final int pageNumber;
  final int id;

  NoteDialog({
    Key key,
    this.note,
    this.pageNumber,
    this.id,
  }) : super(key: key);

  @override
  _NoteDialogState createState() => _NoteDialogState();
}

class _NoteDialogState extends State<NoteDialog> {
  final noteController = TextEditingController();
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
                "Add a Note :)",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: noteController,
                decoration: InputDecoration(labelText: "Note"),
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 22,
              ),
              TextField(
                controller: pageNumberController,
                decoration: InputDecoration(labelText: "On Page"),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 22,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: () async {
                    print("note: " + noteController.text);
                    print("page: " + pageNumberController.text.toString());
                    if (noteController.text.isEmpty ||
                        pageNumberController.text.isEmpty) {
                      setState(() {
                        isVisible = true;
                      });
                    } else {
                      Provider.of<BookProvider>(context, listen: false).addNote(
                        note: Notes(
                          bookID: widget.id,
                          note: noteController.text,
                          pageNumber: int.parse(pageNumberController.text),
                        ),
                      );
                      Provider.of<BookProvider>(context, listen: false)
                          .getNotes(widget.id + 1);
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
