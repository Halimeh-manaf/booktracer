import 'package:booktracer/model/book_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class BookCard extends StatelessWidget {
  final String bookTitle;
  final DateTime date;
  final pageNumber;
  final int id;
  final int totalPagesNumber;

  const BookCard({
    Key key,
    this.bookTitle,
    this.date,
    this.pageNumber,
    this.totalPagesNumber,
    this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(7.0),
      child: Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.25,
        secondaryActions: [
          IconSlideAction(
            caption: 'Archive',
            color: Colors.blue,
            icon: Icons.archive,
            onTap: () => _showSnackBar('Archive'),
          ),
          IconSlideAction(
            caption: 'Share',
            color: Colors.indigo,
            icon: Icons.share,
            onTap: () => _showSnackBar('Share'),
          ),
        ],
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            ListTile(
              trailing: Provider.of<BookProvider>(context, listen: false)
                          .books[id]
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
                            .finishBook(id);
                      },
                      child: Icon(
                        Icons.menu_book,
                        size: 30.0,
                      ),
                    ),
              title: Text('$bookTitle'),
              subtitle:
                  Text("Since " + date.toLocal().toString().split(' ')[0]),
            ),
            ButtonBar(children: [
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: () {
                  Provider.of<BookProvider>(context, listen: false)
                      .decreamentPage(id);
                },
              ),
              Row(
                children: [
                  Text("$pageNumber"),
                  Text("/",
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold)),
                  Text("$totalPagesNumber"),
                ],
              ),
              IconButton(
                onPressed: () {
                  Provider.of<BookProvider>(context, listen: false)
                      .increamentPage(id);
                },
                icon: Icon(Icons.add),
              )
            ]),
          ]),
        ),
      ),
    );
  }

  _showSnackBar(String s) {
    Fluttertoast.showToast(
        msg: "$s",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blueAccent,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
