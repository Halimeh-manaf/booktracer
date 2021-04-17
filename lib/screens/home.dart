import 'package:booktracer/model/book_provider.dart';
import 'package:booktracer/model/constants.dart';
import 'package:booktracer/widget/book_card.dart';
import 'package:booktracer/widget/book_dialog.dart';
import 'package:booktracer/widget/delete_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Constants.appBarTitle),
        actions: [
          IconButton(
            icon: Icon(
              Icons.delete,
              size: 28,
            ),
            onPressed: () async {
              showDialog(
                context: context,
                builder: (_) => DeleteDialog(),
                barrierDismissible: true,
              );
            },
          )
        ],
      ),
      body: Consumer<BookProvider>(
        builder: (context, bookProvider, child) {
          return ListView.builder(
              itemCount: bookProvider.books.length,
              itemBuilder: (context, index) {
                if (bookProvider.books[index].isDone == 0) {
                  return BookCard(
                      bookTitle: bookProvider.books[index].title,
                      date: bookProvider.books[index].startDate,
                      pageNumber: bookProvider.books[index].pageNumber,
                      totalPagesNumber:
                          bookProvider.books[index].totalPagesNumber,
                      id: index);
                } else {
                  return SizedBox.shrink();
                }
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return BookDialog();
                });
          }),
    );
  }
}
