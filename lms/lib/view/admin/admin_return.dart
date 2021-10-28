import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lms/model/book.dart';
import 'package:lms/model/borrowed_book.dart';
import 'package:lms/model/side_bar_menu_model.dart';
import 'package:provider/provider.dart';

class AdminReturn extends StatefulWidget {
  const AdminReturn({Key? key}) : super(key: key);

  @override
  _AdminReturnState createState() => _AdminReturnState();
}

class _AdminReturnState extends State<AdminReturn> {
  TextEditingController rollnoController = new TextEditingController();
  bool isLoading = false;
  bool searchCompleted = false;
  bool isCheckingForFine = false;
  int noOfBooksSelected = 0;
  int totalFineAmount = 0;
  List<BorrowedBook> books = [];
  QuerySnapshot<Map<String, dynamic>>? qs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        double height = constraints.maxHeight - 50;
        return Column(
          children: [
            Container(
              height: 50,
              color: Colors.white,
              child: Row(
                children: [
                  Container(
                    width: 50,
                  ),
                  Container(
                    height: 30,
                    width: constraints.maxWidth * 0.5,
                    alignment: Alignment.centerLeft,
                    child: AutoSizeText(
                      '   Return Form',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 100,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: height,
              color: Color(0xffced9de),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: height * 0.1,
                    ),
                    Container(
                      height: height * 0.05,
                      width: constraints.maxWidth * 0.8,
                      alignment: Alignment.centerLeft,
                      child: AutoSizeText(
                        'Enter Roll Number',
                        maxFontSize: 30,
                        minFontSize: 20,
                      ),
                    ),
                    Container(
                        height: height * 0.05,
                        width: constraints.maxWidth * 0.8,
                        alignment: Alignment.centerLeft,
                        child: TextField(
                          controller: rollnoController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              filled: true,
                              fillColor: Colors.white70),
                        )),
                    Container(
                      height: height * 0.04,
                    ),
                    Container(
                      width: constraints.maxWidth * 0.8,
                      alignment: Alignment.centerLeft,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                Color(0xff00B4DB),
                                Color(0xff0083B0)
                              ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter)),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.transparent,
                                fixedSize: Size(200, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(10.0),
                                )),
                            onPressed: () async {
                              setState(() {
                                isCheckingForFine = false;
                                isLoading = true;
                                searchCompleted = false;
                                books = [];
                              });
                              qs = await FirebaseFirestore.instance
                                  .collection("Borrow")
                                  .where('ROLL_NO',
                                      isEqualTo: rollnoController.text)
                                  .get();
                              qs!.docs.forEach((element) {
                                Timestamp issue = element.data()['ISSUE_DATE'];
                                Timestamp due = element.data()['DUE_DATE'];
                                books.add(BorrowedBook(
                                    id: element.data()['BOOK_ID'].toString(),
                                    name: element.data()['TITLE'],
                                    author: element.data()['AUTHOR'],
                                    isSelected: false,
                                    dateIssued: issue.toDate(),
                                    dueDate: due.toDate()));
                              });
                              setState(() {
                                searchCompleted = true;
                                isLoading = false;
                              });
                            },
                            child: Text('Search for Books Borrowed'),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: height * 0.04,
                    ),
                    isLoading
                        ? Container(
                            height: height * 0.05,
                            width: constraints.maxWidth * 0.8,
                            alignment: Alignment.centerLeft,
                            child: AutoSizeText(
                              'Searching for borrowed books...',
                              maxFontSize: 30,
                              minFontSize: 20,
                            ),
                          )
                        : Container(),
                    searchCompleted
                        ? books.isNotEmpty
                            ? Container(
                                height: height * 0.05,
                                width: constraints.maxWidth * 0.8,
                                alignment: Alignment.centerLeft,
                                child: AutoSizeText(
                                  'Select the Books for Return',
                                  maxFontSize: 30,
                                  minFontSize: 20,
                                ),
                              )
                            : Container(
                                height: height * 0.05,
                                width: constraints.maxWidth * 0.8,
                                alignment: Alignment.centerLeft,
                                child: AutoSizeText(
                                  'No Records',
                                  maxFontSize: 30,
                                  minFontSize: 20,
                                ),
                              )
                        : Container(
                            height: 0,
                          ),
                    searchCompleted && books.isNotEmpty
                        ? Container(
                            width: constraints.maxWidth * 0.8,
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: books.length,
                                itemBuilder: (context, index) {
                                  return CheckboxListTile(
                                      value: books[index].isSelected,
                                      title: Text(books[index].name),
                                      onChanged: (v) {
                                        if (v == true) {
                                          noOfBooksSelected += 1;
                                        } else {
                                          noOfBooksSelected -= 1;
                                        }
                                        setState(() {
                                          books[index].isSelected = v!;
                                        });
                                        totalFineAmount = 0;
                                        books.forEach((emp) {
                                          if (emp.isSelected) {
                                            int days = emp.dueDate
                                                .difference(DateTime.now())
                                                .inDays;
                                            int multiplier = 5;
                                            days = days > 0 ? 0 : days;
                                            if (days < 0) {
                                              days = days.abs();
                                              setState(() {
                                                totalFineAmount +=
                                                    days * multiplier;
                                              });
                                            }
                                          }
                                        });
                                      });
                                }),
                          )
                        : Container(
                            height: 20,
                          ),
                    searchCompleted && books.isNotEmpty
                        ? Container(
                            height: height * 0.04,
                          )
                        : Container(
                            height: 0,
                          ),
                    searchCompleted && books.isNotEmpty
                        ? Container(
                            height: 50,
                            width: constraints.maxWidth * 0.8,
                            alignment: Alignment.centerLeft,
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        colors: [
                                      Color(0xff00B4DB),
                                      Color(0xff0083B0)
                                    ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter)),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.transparent,
                                      fixedSize: Size(200, 50),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(10.0),
                                      )),
                                  onPressed: () async {
                                    if (noOfBooksSelected > 0) {
                                      totalFineAmount = 0;
                                      books.forEach((emp) {
                                        if (emp.isSelected) {
                                          int days = emp.dueDate
                                              .difference(DateTime.now())
                                              .inDays;
                                          int multiplier = 5;
                                          days = days > 0 ? 0 : days;
                                          if (days < 0) {
                                            days = days.abs();
                                            totalFineAmount +=
                                                days * multiplier;
                                          }
                                        }
                                      });
                                      setState(() {
                                        isCheckingForFine = true;
                                      });
                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text(
                                                  "Select Atleast one Book to Check Fine."),
                                              actions: <Widget>[
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text('Okay'))
                                              ],
                                            );
                                          });
                                    }
                                  },
                                  child: Text('Check For Fine'),
                                ),
                              ),
                            ),
                          )
                        : Container(
                            height: 0,
                          ),
                    searchCompleted && books.isNotEmpty
                        ? Container(
                            height: height * 0.04,
                          )
                        : Container(
                            height: 0,
                          ),
                    !isCheckingForFine
                        ? Container(
                            height: 0,
                          )
                        : Container(
                            width: constraints.maxWidth * 0.8,
                            child: tableBody(
                                context,
                                books
                                    .where((element) => element.isSelected)
                                    .toList(),
                                constraints.maxWidth)),
                    isCheckingForFine
                        ? Container(
                            height: height * 0.01,
                          )
                        : Container(
                            height: 0,
                          ),
                    isCheckingForFine
                        ? Container(
                            height: height * 0.03,
                            width: constraints.maxWidth * 0.8,
                            alignment: Alignment.centerLeft,
                            child: AutoSizeText(
                              '   Total Amount: Rs. $totalFineAmount',
                              maxFontSize: 30,
                              minFontSize: 20,
                              style: TextStyle(fontWeight: FontWeight.w800),
                            ),
                          )
                        : Container(),
                    isCheckingForFine
                        ? Container(
                            height: height * 0.04,
                          )
                        : Container(
                            height: 0,
                          ),
                    !isCheckingForFine
                        ? Container(
                            height: 0,
                          )
                        : Container(
                            width: constraints.maxWidth * 0.8,
                            alignment: Alignment.centerLeft,
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        colors: [
                                      Color(0xff00B4DB),
                                      Color(0xff0083B0)
                                    ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter)),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.transparent,
                                      fixedSize: Size(200, 50),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(10.0),
                                      )),
                                  onPressed: () async {
                                    showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (BuildContext context) {
                                          return Dialog(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(20.0),
                                              child: Text(
                                                "Adding to Ledger, Please Wait...",
                                                style: TextStyle(fontSize: 19),
                                              ),
                                            ),
                                          );
                                        });
                                    await Future.forEach(books,
                                        (BorrowedBook book) async {
                                      if (book.isSelected) {
                                        int days = book.dueDate
                                            .difference(DateTime.now())
                                            .inDays;
                                        int fineAmount = 0;
                                        int multiplier = 5;
                                        days = days > 0 ? 0 : days;
                                        if (days < 0) {
                                          days = days.abs();
                                          fineAmount = days * multiplier;
                                        }
                                        QueryDocumentSnapshot<
                                                Map<String, dynamic>> qds =
                                            qs!.docs.firstWhere((element) =>
                                                element.data()['TITLE'] ==
                                                book.name);

                                        await FirebaseFirestore.instance
                                            .collection("Return")
                                            .doc(qds.id)
                                            .set(qds.data());
                                        await FirebaseFirestore.instance
                                            .collection("Return")
                                            .doc(qds.id)
                                            .update({'DUE_FEE': fineAmount});
                                        await FirebaseFirestore.instance
                                            .collection("Borrow")
                                            .doc(qds.id)
                                            .delete();
                                      }
                                    });
                                    Navigator.pop(context);
                                    setState(() {
                                      isLoading = false;
                                      isCheckingForFine = false;
                                      noOfBooksSelected = 0;
                                      searchCompleted = false;
                                      rollnoController.clear();
                                      qs = null;
                                      totalFineAmount = 0;
                                      books = [];
                                    });
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text(
                                          'Return successful. Ledger updated.'),
                                      backgroundColor: Colors.green,
                                    ));
                                    Provider.of<SideBarMenuModel>(context,
                                            listen: false)
                                        .change(0);
                                  },
                                  child: Text('Return'),
                                ),
                              ),
                            ),
                          ),
                    isCheckingForFine
                        ? Container(
                            height: height * 0.04,
                          )
                        : Container(
                            height: 0,
                          ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  SingleChildScrollView tableBody(
      BuildContext ctx, List<BorrowedBook> books, double width) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        dataRowHeight: 50,
        dividerThickness: 5,
        columns: [
          DataColumn(
            label: Text(
              "Book ID",
              style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 19),
              overflow: TextOverflow.ellipsis,
            ),
            numeric: false,
          ),
          DataColumn(
            label: Text(
              "Title",
              style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 19),
              overflow: TextOverflow.ellipsis,
            ),
            numeric: false,
          ),
          DataColumn(
            label: Text(
              "Date Issued",
              style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 19),
              overflow: TextOverflow.ellipsis,
            ),
            numeric: true,
          ),
          DataColumn(
            label: Text(
              "Due Date",
              maxLines: 1,
              style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 19),
              overflow: TextOverflow.ellipsis,
            ),
            numeric: false,
          ),
          DataColumn(
            label: Text(
              "Late Fee",
              maxLines: 1,
              style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 19),
              overflow: TextOverflow.ellipsis,
            ),
            numeric: false,
          ),
        ],
        rows: books.map((emp) {
          int days = emp.dueDate.difference(DateTime.now()).inDays;
          int fineAmount = 0;
          int multiplier = 5;
          days = days > 0 ? 0 : days;
          if (days < 0) {
            days = days.abs();
            fineAmount = days * multiplier;
          }
          return DataRow(cells: [
            DataCell(
              Text(emp.id),
            ),
            DataCell(
              Container(
                width: width * 0.3,
                child: Text(
                  emp.name,
                  style: TextStyle(),
                ),
              ),
            ),
            DataCell(
              Text(
                  '${emp.dateIssued.day}/${emp.dateIssued.month}/${emp.dateIssued.year}'),
            ),
            DataCell(
              Text(
                  '${emp.dueDate.day}/${emp.dueDate.month}/${emp.dueDate.year}'),
            ),
            DataCell(
              Text(
                  '${days == 0 ? "No Due" : '$days Days X Rs. $multiplier = Rs. $fineAmount'}'),
            ),
          ]);
        }).toList(),
      ),
    );
  }
}
