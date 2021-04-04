import 'package:booktracer/model/book_provider.dart';
import 'package:booktracer/model/date_time_provider.dart';
import 'package:booktracer/widget/book_card.dart';
import 'package:booktracer/widget/book_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MainPage());
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BookProvider()),
        ChangeNotifierProvider(create: (context) => DateTimeProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BodyWidget(),
      ),
    );
  }
}

class BodyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App bar title'),
      ),
      body: Consumer<BookProvider>(
        builder: (context, bookProvider, child) {
          return ListView.builder(
              itemCount: bookProvider.books.length,
              itemBuilder: (
                context,
                index,
              ) {
                return BookCard(
                  bookTitle: bookProvider.books[index].title,
                  date: bookProvider.books[index].date,
                  pageNumber: bookProvider.books[index].pageNumber,
                  totalPagesNumber: bookProvider.books[index].totalPagesNumber,
                  id: index,
                );
              });
        },
        child: BookCard(
            bookTitle: "Book Title", date: DateTime.now(), pageNumber: 12),
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
