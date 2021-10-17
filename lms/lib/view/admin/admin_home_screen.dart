import 'package:flutter/material.dart';

import 'admin_side_bar.dart';

class AdminHomeScreen extends StatefulWidget {
  @override
  _AdminHomeScreenState createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: height,
          width: width,
          child: Row(
            children: [
              Container(
                width: width * 0.3,
                color: Color(0xff03003d),
                alignment: Alignment.topLeft,
                child: AdminSideBar(),
              ),
              Container(
                width: width * 0.7,
                color: Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
