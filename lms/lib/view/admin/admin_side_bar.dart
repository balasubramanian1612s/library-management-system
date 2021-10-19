import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:lms/main.dart';
import 'package:lms/util/my_image.dart';

int isSelectedSidebar = 0;

class AdminSideBar extends StatefulWidget {
  @override
  _AdminSideBarState createState() => _AdminSideBarState();
}

class _AdminSideBarState extends State<AdminSideBar> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(left: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: height * 0.05,
          ),
          Image.asset(
            "assets/psg.png",
            height: 60,
            width: 60,
          ),
          Container(
            height: height * 0.01,
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: AutoSizeText(
              'PSG Tech',
              presetFontSizes: [25, 22, 20],
              group: titleGroup,
              maxLines: 4,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: height * 0.075,
          ),
          Container(
            margin: EdgeInsets.only(bottom: 5),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: isSelectedSidebar == 0 ? Colors.white12 : null,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10))),
            child: ListTile(
              leading: Icon(Icons.document_scanner, color: Colors.white),
              onTap: () {
                setState(() {
                  isSelectedSidebar = 0;
                });
              },
              title: Text(
                'Something',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 5),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: isSelectedSidebar == 1 ? Colors.white12 : null,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10))),
            child: ListTile(
              onTap: () {
                setState(() {
                  isSelectedSidebar = 1;
                });
              },
              leading: Icon(Icons.document_scanner, color: Colors.white),
              title: Text(
                'Something',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 5),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: isSelectedSidebar == 2 ? Colors.white12 : null,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10))),
            child: ListTile(
              onTap: () {
                setState(() {
                  isSelectedSidebar = 2;
                });
              },
              leading: Icon(Icons.document_scanner, color: Colors.white),
              title: Text(
                'Something',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 5),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: isSelectedSidebar == 3 ? Colors.white12 : null,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10))),
            child: ListTile(
              onTap: () {
                setState(() {
                  isSelectedSidebar = 3;
                });
              },
              leading: Icon(Icons.document_scanner, color: Colors.white),
              title: Text(
                'Something',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 5),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: isSelectedSidebar == 4 ? Colors.white12 : null,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10))),
            child: ListTile(
              onTap: () {
                setState(() {
                  isSelectedSidebar = 4;
                });
              },
              leading: Icon(Icons.document_scanner, color: Colors.white),
              title: Text(
                'Something',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
