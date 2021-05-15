import 'package:booktracer/model/book_provider.dart';
import 'package:booktracer/widget/header_with_book_title.dart';
import 'package:booktracer/widget/title_with_add_buttom.dart';
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
            TitleWithAddBtn(title: "Add", onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
