import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lms_student_user/model/hive/book_model.dart';
import 'package:lms_student_user/model/hive/return_model.dart';
import 'package:lms_student_user/model/hive/borrow_model.dart';
import 'package:lms_student_user/view/admin/admin_home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataFetchScreen extends StatefulWidget {
  const DataFetchScreen({Key? key}) : super(key: key);

  @override
  _DataFetchScreenState createState() => _DataFetchScreenState();
}

class _DataFetchScreenState extends State<DataFetchScreen> {
  bool isFetching = true;
  String progressText = "Loading";
  Box<BookModel>? bookDB;
  Box<BorrowedBookModel>? borrowDB;
  Box<ReturnBookModel>? returnDB;

  Future fetchData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    if (pref.containsKey('onboarding')) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => AdminHomeScreen()));
    } else {
      bookDB!.clear();
      borrowDB!.clear();
      returnDB!.clear();

      print("data getting fetched");
      CollectionReference booksRef =
          FirebaseFirestore.instance.collection('books');
      QuerySnapshot<Map<String, dynamic>> booksQuerySnapshot =
          await booksRef.get() as QuerySnapshot<Map<String, dynamic>>;
      booksQuerySnapshot.docs.forEach((document) {
        Map<String, dynamic> doc = document.data();
        bookDB!.put(
          doc['SNO'],
          BookModel(
              edition: doc['EDITION'],
              bookName: doc['TITLE'],
              serialNumber: doc['SNO'],
              publisherName: doc['PUBLISHERNAME'],
              author: doc['AUTHOR']),
        );
      });
      print('fetched books');

      CollectionReference borrowedRef =
          FirebaseFirestore.instance.collection('Borrow');
      QuerySnapshot<Map<String, dynamic>> borrowedQuerySnapshot =
          await borrowedRef.get() as QuerySnapshot<Map<String, dynamic>>;
      borrowedQuerySnapshot.docs.forEach((document) {
        Map<String, dynamic> doc = document.data();
        borrowDB!.put(
          doc['BOOK_ID'].toString() + doc['ROLL_NO'].toString(),
          BorrowedBookModel(
              serialNumber: doc['BOOK_ID'],
              dueDate: (doc['DUE_DATE'] as Timestamp).toDate(),
              edition: doc['EDITION'],
              issueDate: (doc['ISSUE_DATE'] as Timestamp).toDate(),
              rollNumber: doc['ROLL_NO'],
              bookName: doc['TITLE'],
              author: doc['AUTHOR']),
        );
      });
      print('fetched borrowed');

      CollectionReference returnRef =
          FirebaseFirestore.instance.collection('Return');
      QuerySnapshot<Map<String, dynamic>> returnQuerySnapshot =
          await returnRef.get() as QuerySnapshot<Map<String, dynamic>>;
      returnQuerySnapshot.docs.forEach((document) {
        Map<String, dynamic> doc = document.data();
        returnDB!.put(
          doc['BOOK_ID'].toString() +
              doc['ROLL_NO'].toString() +
              (doc['ISSUE_DATE'] as Timestamp).toDate().toIso8601String(),
          ReturnBookModel(
              dueFee: doc['DUE_FEE'],
              serialNumber: doc['BOOK_ID'],
              dueDate: (doc['DUE_DATE'] as Timestamp).toDate(),
              edition: doc['EDITION'],
              issueDate: (doc['ISSUE_DATE'] as Timestamp).toDate(),
              rollNumber: doc['ROLL_NO'],
              bookName: doc['TITLE'],
              author: doc['AUTHOR']),
        );
      });
      print('fetched returned');

      print('added to db');
      print(bookDB!.values.length);
      print(borrowDB!.values.length);
      print(returnDB!.values.length);

      print(borrowDB!.values.toList()[0].dueDate!.toIso8601String());

      await pref.setBool('onboarding', false);

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => AdminHomeScreen()));
    }
  }

  @override
  void initState() {
    bookDB = Hive.box<BookModel>('books');
    borrowDB = Hive.box<BorrowedBookModel>('borrow');
    returnDB = Hive.box<ReturnBookModel>('return');

    fetchData().then((value) {
      setState(() {
        progressText = "Loaded data";
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(child: Text(progressText)),
      ),
    );
  }
}
