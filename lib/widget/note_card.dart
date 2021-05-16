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
                trailing: Provider.of<BookProvider>(context, listen: false)
                            .books[widget.id]
                            .isDone ==
                        1
                    ? GestureDetector(
                        onTap: () {},
                        child: Icon(
                          Icons.check,
                          color: Colors.green,
                          size: 30.0,
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          Provider.of<BookProvider>(context, listen: false)
                              .finishBook(widget.id);
                        },
                        child: Icon(
                          Icons.menu_book,
                          size: 30.0,
                        ),
                      ),
                title: Text('${widget.note}'),
              ),
              ButtonBar(children: [
                GestureDetector(
                  onTapDown: (TapDownDetails details) {
                    timer = Timer.periodic(Duration(milliseconds: 500), (t) {
                      Provider.of<BookProvider>(context, listen: false)
                          .decreamentPage(widget.id);
                    });
                  },
                  onTapUp: (TapUpDetails details) {
                    timer.cancel();
                  },
                  onTapCancel: () {
                    timer.cancel();
                  },
                  child: IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      Provider.of<BookProvider>(context, listen: false)
                          .decreamentPage(widget.id);
                    },
                  ),
                ),
                Row(
                  children: [
                    Text("${widget.pageNumber}"),
                    Text("/",
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                GestureDetector(
                  onTapDown: (TapDownDetails details) {
                    timer = Timer.periodic(Duration(milliseconds: 200), (t) {
                      Provider.of<BookProvider>(context, listen: false)
                          .increamentPage(widget.id);
                    });
                  },
                  onTapUp: (TapUpDetails details) {
                    timer.cancel();
                  },
                  onTapCancel: () {
                    timer.cancel();
                  },
                  child: IconButton(
                    onPressed: () {
                      Provider.of<BookProvider>(context, listen: false)
                          .increamentPage(widget.id);
                    },
                    icon: Icon(Icons.add),
                  ),
                )
              ]),
            ]),
          ),
        ),
      ),
    );
  }
}
