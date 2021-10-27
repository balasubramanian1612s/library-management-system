import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lms/model/book.dart';
import 'package:lms/view/admin/admin_home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataFetchScreen extends StatefulWidget {
  const DataFetchScreen({Key? key}) : super(key: key);

  @override
  _DataFetchScreenState createState() => _DataFetchScreenState();
}

class _DataFetchScreenState extends State<DataFetchScreen> {
  bool isFetching = true;
  int loadingProgress = 0;
  String progressText = "Loading";
  Box? dataBox;

  Future fetchData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    if (pref.containsKey('onboarding')) {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => AdminHomeScreen()));
    }

    // CollectionReference ref = FirebaseFirestore.instance.collection('books');
    // QuerySnapshot<Map<String, dynamic>> querySnapshot =
    //     await ref.get() as QuerySnapshot<Map<String, dynamic>>;
    // var doc = querySnapshot.docs[0].data();
    // dataBox.put(
    //   doc['SNO'],
    //   Book(
    //       id: doc['SNO'].toString(),
    //       name: doc['TITLE'],
    //       totalQty: 1,
    //       author: doc['AUTHOR']),
    // );
  }

  @override
  void initState() {
    print(Hive.isBoxOpen('books'));
    dataBox = Hive.box('books');
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
