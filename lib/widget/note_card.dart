import 'dart:async';
import 'package:booktracer/model/constants.dart';
import 'package:booktracer/model/notes.dart';
import 'package:booktracer/widget/delete_note.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class NoteCard extends StatefulWidget {
  final Notes notes;
  final int id;

  const NoteCard({
    Key key,
    this.id,
    this.notes,
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
                builder: (_) => DeleteNoteDialog(
                    title: "Delete Note",
                    content: "Are you sure you want to delete this note?",
                    deleteAll: false,
                    notes: widget.notes,
                    id: widget.id + 1),
                barrierDismissible: true,
              );
            },
          ),
        ],
        child: GestureDetector(
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              ListTile(
                title: Text('${widget.notes.note}'),
              ),
              Row(
                children: [
                  Spacer(),
                  Padding(
                      padding: EdgeInsets.only(right: 20.0, bottom: 5.0),
                      child: Text(
                        "Page: " + "${widget.notes.pageNumber}",
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
