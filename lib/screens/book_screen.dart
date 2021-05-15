import 'package:booktracer/model/book_provider.dart';
import 'package:booktracer/widget/book_card.dart';
import 'package:booktracer/widget/header_with_book_title.dart';
import 'package:booktracer/widget/title_with_add_buttom.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookScreen extends StatelessWidget {
  final int id;

  BookScreen({this.id});
  @override
  Widget build(BuildContext context) {
    Size screensize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
            Provider.of<BookProvider>(context, listen: false).books[id].title),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: ScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            HeaderWithBookTitle(size: screensize, id: id),
            TitleWithAddBtn(
                title: "Add",
                onPressed: () {
                  //Provider.of<BookProvider>(context, listen: false).addNote(Notes(bookID: id,note: " "));
                  Provider.of<BookProvider>(context, listen: false)
                      .getNotes(id + 1);
                }),
            Flexible(
              fit: FlexFit.loose,
              child: Consumer<BookProvider>(
                builder: (context, bookProvider, child) {
                  return ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: bookProvider.getNotes(id + 1).length,
                      itemBuilder: (context, index) {
                        if (bookProvider.getNotes(id + 1).length == 0) {
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
            ),
          ],
        ),
      ),
    );
  }
}
