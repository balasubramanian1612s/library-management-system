import 'package:flutter/material.dart';
import 'package:lms/model/side_bar_menu_model.dart';
import 'package:lms/util/responsive.dart';
import 'package:lms/view/admin/admin_books.dart';
import 'package:lms/view/admin/admin_dashboard.dart';
import 'package:provider/provider.dart';

import 'admin_side_bar.dart';

class AdminHomeScreen extends StatefulWidget {
  @override
  _AdminHomeScreenState createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      drawer: Container(
        width: width * 0.7,
        color: Colors.blue,
        alignment: Alignment.topLeft,
        child: AdminSideBar(),
      ),
      body: SingleChildScrollView(
        child: Consumer<SideBarMenuModel>(
          builder: (context, menu, child) {
            return Container(
              height: height,
              width: width,
              child: Responsive(
                  mobile: Row(
                    children: [
                      Container(
                        width: width * 1,
                        color: Colors.white,
                        child: Stack(
                          children: [
                            menu.isSelectedSidebar == 0
                                ? AdminDashboard()
                                : AdminBooks(),
                            Align(
                              alignment: Alignment.topLeft,
                              child: IconButton(
                                  onPressed: () {
                                    _scaffoldKey.currentState!.openDrawer();
                                  },
                                  icon: Icon(
                                    Icons.menu,
                                    color: Colors.white,
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  tablet: Row(
                    children: [
                      Container(
                        width: width * 0.3,
                        color: Colors.blue,
                        alignment: Alignment.topLeft,
                        child: AdminSideBar(),
                      ),
                      Container(
                        width: width * 0.7,
                        color: Colors.white,
                        child: menu.isSelectedSidebar == 0
                            ? AdminDashboard()
                            : AdminBooks(),
                      ),
                    ],
                  ),
                  desktop: Row(
                    children: [
                      Container(
                        width: width * 0.3,
                        color: Colors.blue,
                        alignment: Alignment.topLeft,
                        child: AdminSideBar(),
                      ),
                      Container(
                        width: width * 0.7,
                        color: Colors.white,
                        child: menu.isSelectedSidebar == 0
                            ? AdminDashboard()
                            : AdminBooks(),
                      ),
                    ],
                  )),
            );
          },
        ),
      ),
    );
  }
}
