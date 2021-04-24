import 'package:booktracer/model/constants.dart';
import 'package:flutter/material.dart';

class BookScreen extends StatelessWidget {
  final int id;

  const BookScreen({Key key, this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Constants.appBarTitle),
      ),
    );
  }
}
