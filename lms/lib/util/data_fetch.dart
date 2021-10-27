import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lms/model/hive/book_model.dart';
import 'package:lms/view/admin/admin_home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataFetchScreen extends StatefulWidget {
  const DataFetchScreen({Key? key}) : super(key: key);

  @override
  _DataFetchScreenState createState() => _DataFetchScreenState();
}

class _DataFetchScreenState extends State<DataFetchScreen> {
  bool isFetching = true;
  String progressText = "Loading";
  Box<BookModel>? dataBox;

  Future fetchData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    if (pref.containsKey('onboarding')) {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => AdminHomeScreen()));
    } else {
      print("data getting fetched");
      CollectionReference ref = FirebaseFirestore.instance.collection('books');
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await ref.get() as QuerySnapshot<Map<String, dynamic>>;
      querySnapshot.docs.forEach((document) {
        Map<String, dynamic> doc = document.data();
        dataBox!.put(
          doc['SNO'],
          BookModel(
              edition: doc['EDITION'],
              bookName: doc['TITLE'],
              serialNumber: doc['SNO'],
              publisherName: doc['PUBLISHERNAME'],
              author: doc['AUTHOR']),
        );
      });

      List<BookModel> recievedBooks = dataBox!.values.toList();
      print(recievedBooks.length);

      await pref.setBool('onboarding', false);
    }
  }

  @override
  void initState() {
    dataBox = Hive.box<BookModel>('books');
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
