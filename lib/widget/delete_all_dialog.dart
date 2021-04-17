import 'package:booktracer/model/book_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeleteDialog extends StatelessWidget {
  final String title;
  final String content;
  final bool deleteAll;
  final int id;
  DeleteDialog(
      {@required this.title,
      @required this.content,
      @required this.deleteAll,
      this.id});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("No")),
        TextButton(
            onPressed: () async {
              if (deleteAll) {
                await Provider.of<BookProvider>(context, listen: false)
                    .deleteAllRows();
                Navigator.of(context).pop();
              } else {
                await Provider.of<BookProvider>(context, listen: false)
                    .deleteBook(id);
                Navigator.of(context).pop();
              }
            },
            child: Text("Yes"))
      ],
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
    );
  }
}
