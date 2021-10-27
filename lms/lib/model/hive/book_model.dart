import 'package:hive/hive.dart';

part 'book_model.g.dart';

@HiveType(typeId: 0)
class BookModel extends HiveObject {
  @HiveField(0)
  String? bookName;

  @HiveField(1)
  String? author;

  @HiveField(2)
  int? serialNumber;

  @HiveField(3)
  String? publisherName;

  @HiveField(4)
  int? edition;

  BookModel(
      {required this.edition,
      required this.bookName,
      required this.serialNumber,
      required this.publisherName,
      required this.author});
}
