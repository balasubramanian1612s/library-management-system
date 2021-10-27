import 'package:hive/hive.dart';

part 'borrow_model.g.dart';

@HiveType(typeId: 1)
class BorrowedBookModel extends HiveObject {
  @HiveField(0)
  String? author;

  @HiveField(1)
  int? serialNumber;

  @HiveField(2)
  DateTime? dueDate;

  @HiveField(3)
  int? edition;

  @HiveField(4)
  DateTime? issueDate;

  @HiveField(5)
  String? rollNumber;

  @HiveField(6)
  String? bookName;

  BorrowedBookModel(
      {required this.serialNumber,
      required this.dueDate,
      required this.edition,
      required this.issueDate,
      required this.rollNumber,
      required this.bookName,
      required this.author});
}
