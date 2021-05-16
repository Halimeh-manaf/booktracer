import 'dart:async';
import 'package:booktracer/model/book_provider.dart';
import 'package:booktracer/model/constants.dart';
import 'package:booktracer/screens/book_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'delete_all_dialog.dart';

class NoteCard extends StatefulWidget {
  final String note;
  final pageNumber;
  final int id;

  const NoteCard({
    Key key,
    this.note,
    this.pageNumber,
    this.id,
  }) : super(key: key);

  @override
  _NoteCardState createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
  Timer timer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(7.0),
      child: Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.25,
        secondaryActions: [
          IconSlideAction(
            caption: Constants.bookCardDeleteBook,
            color: Colors.red,
            icon: Icons.delete,
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => DeleteDialog(
                    title: Constants.deleteBookTitle,
                    content:
                        "Are you sure you want to delete ${Provider.of<BookProvider>(context, listen: false).books[widget.id].title}",
                    deleteAll: false,
                    id: widget.id),
                barrierDismissible: true,
              );
            },
          ),
        ],
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookScreen(id: widget.id),
              ),
            );
          },
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              ListTile(
                title: Text('${widget.note}'),
              ),
              Row(
                children: [
                  Spacer(),
                  Padding(
                      padding: EdgeInsets.only(right: 20.0, bottom: 5.0),
                      child: Text(
                        "Page: " + "${widget.pageNumber}",
                        style: TextStyle(
                            fontSize: 11.0, fontWeight: FontWeight.bold),
                      )),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
