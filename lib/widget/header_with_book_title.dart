import 'package:booktracer/model/book_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HeaderWithBookTitle extends StatelessWidget {
  const HeaderWithBookTitle({
    Key key,
    @required this.size,
    @required this.id,
  }) : super(key: key);

  final Size size;
  final int id;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.15,
      child: Stack(
        children: [
          Container(
            height: size.height * 0.15 - 27,
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(36),
                  bottomRight: Radius.circular(36.0)),
            ),
            child: Row(
              children: [
                Text(
                  "Hello World!",
                  style: Theme.of(context).textTheme.headline4,
                )
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
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
              child: Center(
                  child: Text(
                Provider.of<BookProvider>(context, listen: false)
                    .books[id]
                    .title,
                style: TextStyle(fontSize: 17.0),
              )),
            ),
          ),
        ],
      ),
    );
  }
}
