import 'package:booktracer/model/book_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookScreen extends StatelessWidget {
  final int id;

  const BookScreen({this.id});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
            Provider.of<BookProvider>(context, listen: false).books[id].title),
      ),
      body: Column(
        children: [
          Container(
            height: size.height * 0.2,
            decoration: BoxDecoration(color: Colors.blueAccent),
          ),
        ],
      ),
    );
  }
}
