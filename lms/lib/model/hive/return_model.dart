import 'package:hive/hive.dart';

part 'return_model.g.dart';

@HiveType(typeId: 2)
class ReturnBookModel extends HiveObject {
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

  @HiveField(7)
  int? dueFee;

  ReturnBookModel(
      {required this.bookName,
      required this.dueDate,
      required this.edition,
      required this.issueDate,
      required this.rollNumber,
      required this.serialNumber,
      required this.author,
      required this.dueFee});
}
