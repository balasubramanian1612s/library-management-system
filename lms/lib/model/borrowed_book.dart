class BorrowedBook {
  String id;
  String name;
  String author;
  bool isSelected;
  DateTime dateIssued;
  DateTime dueDate;
  BorrowedBook({
    required this.id,
    required this.name,
    required this.author,
    required this.isSelected,
    required this.dateIssued,
    required this.dueDate,
  });
}
