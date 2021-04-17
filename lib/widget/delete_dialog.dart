import 'package:booktracer/model/book_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeleteDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Remove All Books"),
      content: Text("Are you sure you want to delete all books?"),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("No")),
        TextButton(
            onPressed: () async {
              await Provider.of<BookProvider>(context, listen: false)
                  .deleteAllRows();
              Navigator.of(context).pop();
            },
            child: Text("Yes"))
      ],
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
    );
  }
}
