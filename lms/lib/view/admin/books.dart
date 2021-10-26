import 'package:meta/meta.dart';

class Book {
  final String id;
  final String title;
  final String author;
  final int totalBooks;
  final int available;

  Book(
      {required this.id,
      required this.title,
      required this.author,
      required this.totalBooks,
      required this.available});
}
