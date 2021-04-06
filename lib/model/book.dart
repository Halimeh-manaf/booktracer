class Book {
  String title;
  DateTime startDate;
  DateTime endDate;
  int pageNumber;
  int totalPagesNumber;
  bool isDone;

  Book(
      {this.title,
      this.startDate,
      this.pageNumber,
      this.totalPagesNumber,
      this.isDone,
      this.endDate});
}
