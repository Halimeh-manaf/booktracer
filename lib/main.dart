import 'package:booktracer/model/book_provider.dart';
import 'package:booktracer/model/bottom_navigation_bar_provider.dart';
import 'package:booktracer/model/date_time_provider.dart';
import 'package:booktracer/widget/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/book.dart';

void main() {
  runApp(MainPage());
}

class MainPage extends StatelessWidget {
  final List<Book> bookList = [];
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BookProvider(bookList)),
        ChangeNotifierProvider(create: (context) => DateTimeProvider()),
        ChangeNotifierProvider(
            create: (context) => BottomNavigationBarProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BottomNavigationBarWidget(),
      ),
    );
  }
}
