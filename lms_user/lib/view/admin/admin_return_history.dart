import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lms_student_user/model/hive/return_model.dart';

class AdminReturnHistory extends StatefulWidget {
  const AdminReturnHistory({Key? key}) : super(key: key);

  @override
  _AdminReturnHistoryState createState() => _AdminReturnHistoryState();
}

class _AdminReturnHistoryState extends State<AdminReturnHistory> {
  bool edit = false;
  TextEditingController controller = TextEditingController();
  String _searchResult = '';
  List<ReturnBookModel> booksList = [];
  List<ReturnBookModel> filteredBooks = [];
  String updatedText = '';
  bool isLoading = true;

  @override
  void initState() {
    getBooksFromDB();
    super.initState();
  }

  Future getBooksFromDB() async {
    QuerySnapshot<Map<String, dynamic>> qs = await FirebaseFirestore.instance
        .collection("Return")
        .where('ROLL_NO', isEqualTo: "19Z237")
        .get();
    qs.docs.forEach((element) {
      Timestamp issue = element.data()['ISSUE_DATE'];
      Timestamp due = element.data()['DUE_DATE'];
      booksList.add(ReturnBookModel(
        serialNumber: element.data()['BOOK_ID'],
        bookName: element.data()['TITLE'],
        author: element.data()['AUTHOR'],
        dueFee: element.data()['DUE_FEE'],
        dueDate: due.toDate(),
        edition: element.data()['EDITION'],
        issueDate: issue.toDate(),
        rollNumber: element.data()['ROLL_NO'],
      ));
    });

    setState(() {
      filteredBooks = booksList;
      filteredBooks = filteredBooks +
          filteredBooks +
          filteredBooks +
          filteredBooks +
          filteredBooks +
          filteredBooks +
          filteredBooks +
          filteredBooks +
          filteredBooks +
          filteredBooks +
          filteredBooks +
          filteredBooks +
          filteredBooks +
          filteredBooks +
          filteredBooks +
          filteredBooks +
          filteredBooks +
          filteredBooks +
          filteredBooks;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black54,
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              color: Colors.white,
              height: height,
              width: width,
              child: Container(
                height: height * 0.15,
                width: width,
                color: Colors.black54,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: height * 0.1,
                      width: width,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 10),
                          child: Expanded(
                              child: TextField(
                            onChanged: (value) {
                              setState(() {
                                _searchResult = value.toLowerCase();
                              });
                              filteredBooks = booksList
                                  .where((element) =>
                                      element.bookName!
                                          .toLowerCase()
                                          .contains(_searchResult) ||
                                      element.author!
                                          .toLowerCase()
                                          .contains(_searchResult))
                                  .toList();
                            },
                            style: const TextStyle(color: Colors.black),
                            decoration: const InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                hintText: 'Search',
                                suffixIcon: Icon(
                                  Icons.search,
                                  color: Colors.black,
                                )),
                          )),
                        ),
                      ),
                    ),
                    Container(
                      height: height * 0.9,
                      width: width,
                      color: Colors.white,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            columns: const <DataColumn>[
                              DataColumn(
                                label: Text(
                                  'ID',
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Title',
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Author',
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Borrow Date',
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Return Date',
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Fine Paid',
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                            rows: filteredBooks.map((book) {
                              return DataRow(cells: [
                                DataCell(Text(
                                  book.serialNumber.toString(),
                                  overflow: TextOverflow.visible,
                                  softWrap: true,
                                )),
                                DataCell(
                                  Text(
                                    book.bookName.toString(),
                                  ),
                                ),
                                DataCell(Text(
                                  book.author.toString(),
                                )),
                                DataCell(Text(
                                  '${book.issueDate!.day}/${book.issueDate!.month}/${book.issueDate!.year}',
                                )),
                                DataCell(
                                  Text(
                                    '${book.dueDate!.day}/${book.dueDate!.month}/${book.dueDate!.year}',
                                  ),
                                ),
                                DataCell(Text(
                                  'Rs. ${book.dueFee.toString()}',
                                )),
                              ]);
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
