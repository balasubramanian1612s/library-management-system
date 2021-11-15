import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lms_student_user/view/student/student_home_screen.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Student Portal',
          style: GoogleFonts.aBeeZee(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Card(
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 10,
            child: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xff00B4DB), Color(0xff0083B0)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              height: 500,
              width: 400,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Login.',
                    style: GoogleFonts.aBeeZee(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Theme(
                      data: ThemeData(primaryColor: Colors.white),
                      child: TextField(
                        cursorColor: Colors.white,
                        controller: nameController,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          enabledBorder: OutlineInputBorder(),
                          focusColor: Colors.white,
                          border: OutlineInputBorder(),
                          labelText: 'College ID',
                          floatingLabelStyle: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 20.0),
                    child: Theme(
                      data: ThemeData(primaryColor: Colors.white),
                      child: TextField(
                        controller: passController,
                        style: const TextStyle(color: Colors.white),
                        cursorColor: Colors.white,
                        obscureText: true,
                        decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          enabledBorder: OutlineInputBorder(),
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                          floatingLabelStyle: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    width: 200,
                    child: RaisedButton.icon(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        onPressed: () {
                          if (passController.text.toUpperCase().compareTo(
                                  nameController.text.toUpperCase()) ==
                              0) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AdminHomeScreen(
                                        nameController.text.toUpperCase())));
                          } else {
                            _scaffoldKey.currentState!
                                .showSnackBar(const SnackBar(
                              content: Text(
                                'Please check the ID and Password.',
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.red,
                            ));
                          }
                        },
                        icon: const Icon(
                          Icons.done,
                          color: Colors.black,
                        ),
                        color: Colors.white,
                        label: Text(
                          'Submit',
                          style: GoogleFonts.aBeeZee(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        )),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
