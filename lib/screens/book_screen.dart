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
            child: Stack(
              children: [
                Container(
                  height: size.height * 0.2 - 27,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(36),
                        bottomRight: Radius.circular(36.0)),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.0),
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    height: 54,
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
