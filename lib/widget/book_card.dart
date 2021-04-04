import 'package:booktracer/model/book_provider.dart';
import 'package:flutter/material.dart';
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
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Provider.of<BookProvider>(context, listen: false)
                    .books[id]
                    .isDone
                ? Icon(
                    Icons.check,
                    color: Colors.green,
                    size: 30.0,
                  )
                : Icon(
                    Icons.menu_book,
                    size: 30.0,
                  ),
            title: Text('$bookTitle'),
            subtitle: Text("Since " + date.toLocal().toString().split(' ')[0]),
          ),
          ButtonBar(
            children: [
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: () {
                  Provider.of<BookProvider>(context, listen: false)
                      .decreamentPage(id);
                },
              ),
              Text("$pageNumber" + "/$totalPagesNumber"),
              IconButton(
                onPressed: () {
                  Provider.of<BookProvider>(context, listen: false)
                      .increamentPage(id);
                },
                icon: Icon(Icons.add),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
