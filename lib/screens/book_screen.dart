import 'package:booktracer/model/book_provider.dart';
import 'package:booktracer/model/notes.dart';
import 'package:booktracer/widget/header_with_book_title.dart';
import 'package:booktracer/widget/note_card.dart';
import 'package:booktracer/widget/note_dialog.dart';
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
        scrollDirection: Axis.vertical,
        physics: ScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            HeaderWithBookTitle(size: screensize, id: id),
            TitleWithAddBtn(
                title: "Add",
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return NoteDialog(
                          id: id + 1,
                        );
                      });

/*
                  Provider.of<BookProvider>(context, listen: false).addNote(
                      note: Notes(bookID: id + 1, note: "LOL", pageNumber: 1));
                  print("HERE:");
                  print(Provider.of<BookProvider>(context, listen: false)
                      .getNotes(id + 1));
                      */
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
                        if (bookProvider.getNotes(id + 1).length != 0) {
                          return NoteCard(
                              note: bookProvider.getNotes(id + 1)[index].note,
                              pageNumber: bookProvider
                                  .getNotes(id + 1)[index]
                                  .pageNumber,
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
