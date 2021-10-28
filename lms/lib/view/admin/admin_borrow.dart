import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lms/model/hive/book_model.dart';
import 'package:lms/model/hive/borrow_model.dart';
import 'package:lms/model/side_bar_menu_model.dart';
import 'package:provider/provider.dart';

class AdminBorrow extends StatefulWidget {
  const AdminBorrow({Key? key}) : super(key: key);

  @override
  _AdminBorrowState createState() => _AdminBorrowState();
}

class _AdminBorrowState extends State<AdminBorrow> {
  TextEditingController rollnoController = new TextEditingController();
  TextEditingController bookidController = new TextEditingController();
  Box<BorrowedBookModel>? dataBox;

  @override
  void initState() {
    dataBox = Hive.box<BorrowedBookModel>('borrow');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
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
                    '   Borrow Form',
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
            height: height * 0.02,
          ),
          Container(
            height: height * 0.05,
            width: constraints.maxWidth * 0.8,
            alignment: Alignment.centerLeft,
            // color: Colors.green,
            child: AutoSizeText(
              'Enter Book ID Number',
              maxFontSize: 30,
              minFontSize: 20,
            ),
          ),
          Container(
              height: height * 0.05,
              width: constraints.maxWidth * 0.8,
              alignment: Alignment.centerLeft,
              child: TextField(
                controller: bookidController,
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
                        colors: [Color(0xff00B4DB), Color(0xff0083B0)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter)),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.transparent,
                      fixedSize: Size(150, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                      )),
                  onPressed: () async {
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return Dialog(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                "Fetching Book Data, Please wait...",
                                style: TextStyle(fontSize: 19),
                              ),
                            ),
                          );
                        });
                    QuerySnapshot<Map<String, dynamic>> qs =
                        await FirebaseFirestore
                            .instance
                            .collection("books")
                            .where('SNO',
                                isEqualTo: int.parse(bookidController.text))
                            .get();
                    if (qs.docs.length == 0) {
                      Navigator.pop(context);
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Book Not Available"),
                              actions: <Widget>[
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Close'))
                              ],
                            );
                          });
                    } else {
                      Map<String, dynamic> ds = qs.docs[0].data();
                      Navigator.pop(context);
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Check and Confirm Book"),
                              content: Container(
                                height: 500,
                                width: double.maxFinite,
                                child: SingleChildScrollView(
                                  child: Table(
                                    border:
                                        TableBorder.all(color: Colors.black),
                                    children: [
                                      TableRow(children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text('Title'),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text('Content'),
                                        ),
                                      ]),
                                      ...ds.entries
                                          .map<TableRow>(
                                            (e) => TableRow(children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(e.key.toString()),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(e.value.toString()),
                                              ),
                                            ]),
                                          )
                                          .toList()
                                    ],
                                  ),
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                    onPressed: () async {
                                      uploadToDatabase(ds);
                                    },
                                    child: Text(
                                      'Confirm',
                                      style: TextStyle(fontSize: 20),
                                    ))
                              ],
                            );
                          });
                    }
                  },
                  child: Text('Add Entry'),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }

  uploadToDatabase(Map<String, dynamic> ds) async {
    Navigator.pop(context);
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Adding to Ledger, Please Wait...",
                style: TextStyle(fontSize: 19),
              ),
            ),
          );
        });
    await FirebaseFirestore.instance.collection("Borrow").add({
      "ROLL_NO": rollnoController.text,
      "BOOK_ID": int.parse(bookidController.text),
      "ISSUE_DATE": DateTime.now(),
      "DUE_DATE": DateTime.now().add(Duration(days: 20)),
      "TITLE": ds['TITLE'],
      "AUTHOR": ds['AUTHOR'],
      "EDITION": ds['EDITION']
    }).then((value) {
      dataBox!.put(
        ds['BOOK_ID'].toString() + ds['ROLL_NO'].toString(),
        BorrowedBookModel(
            serialNumber: int.parse(bookidController.text),
            dueDate: DateTime.now().add(Duration(days: 20)),
            edition: ds['EDITION'],
            issueDate: DateTime.now(),
            rollNumber: rollnoController.text,
            bookName: ds['TITLE'],
            author: ds['AUTHOR']),
      );
      Navigator.pop(context);
      bookidController.clear();
      rollnoController.clear();
    });

    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(
          'Ledger has been updated successfully. You can check in Borrow Ledger.'),
      backgroundColor: Colors.green,
    ));
    Provider.of<SideBarMenuModel>(context, listen: false).change(0);
  }
}
