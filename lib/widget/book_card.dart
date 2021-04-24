import 'package:booktracer/model/book_provider.dart';
import 'package:booktracer/model/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'delete_all_dialog.dart';

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
            caption: Constants.bookCardDeleteBook,
            color: Colors.red,
            icon: Icons.delete,
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => DeleteDialog(
                    title: Constants.deleteBookTitle,
                    content:
                        "Are you sure you want to delete ${Provider.of<BookProvider>(context, listen: false).books[id].title}",
                    deleteAll: false,
                    id: id),
                barrierDismissible: true,
              );
            },
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
}
