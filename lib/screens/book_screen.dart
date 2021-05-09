import 'package:booktracer/model/book_provider.dart';
import 'package:booktracer/widget/header_with_book_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookScreen extends StatelessWidget {
  final int id;

  const BookScreen({this.id});
  @override
  Widget build(BuildContext context) {
    Size screensize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
            Provider.of<BookProvider>(context, listen: false).books[id].title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderWithBookTitle(size: screensize, id: id),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 5.0),
              padding: EdgeInsets.symmetric(vertical: 20.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 50.0,
                        color: Colors.black.withOpacity(0.23))
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
