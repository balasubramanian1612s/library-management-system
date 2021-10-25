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
  final sidebarDecoration = BoxDecoration(
      gradient: LinearGradient(
          colors: [Color(0xff00B4DB), Color(0xff0083B0)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter));
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xffced9de),
      key: _scaffoldKey,
      drawer: Container(
        width: width * 0.7,
        decoration: sidebarDecoration,
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
                        child: Stack(
                          children: [
                            menu.isSelectedSidebar == 0
                                ? AdminDashboard(
                                    widgetResponsive: WidgetResponsive.mobile,
                                  )
                                : AdminBooks(),
                            Align(
                              alignment: Alignment.topLeft,
                              child: FloatingActionButton(
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                                onPressed: () {
                                  _scaffoldKey.currentState!.openDrawer();
                                },
                                child: Icon(
                                  Icons.menu,
                                  color: Color(0xff00B4DB),
                                ),
                              ),
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
                        decoration: sidebarDecoration,
                        alignment: Alignment.topLeft,
                        child: AdminSideBar(),
                      ),
                      Container(
                        width: width * 0.7,
                        child: menu.isSelectedSidebar == 0
                            ? AdminDashboard(
                                widgetResponsive: WidgetResponsive.tablet,
                              )
                            : AdminBooks(),
                      ),
                    ],
                  ),
                  desktop: Row(
                    children: [
                      Container(
                        width: width * 0.3,
                        decoration: sidebarDecoration,
                        alignment: Alignment.topLeft,
                        child: AdminSideBar(),
                      ),
                      Container(
                        width: width * 0.7,
                        child: menu.isSelectedSidebar == 0
                            ? AdminDashboard(
                                widgetResponsive: WidgetResponsive.desktop,
                              )
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
