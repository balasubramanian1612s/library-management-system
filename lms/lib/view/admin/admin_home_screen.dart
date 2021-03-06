import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lms/model/hive/book_model.dart';
import 'package:lms/model/side_bar_menu_model.dart';
import 'package:lms/util/responsive.dart';
import 'package:lms/view/admin/admin_borrow.dart';
import 'package:lms/view/admin/admin_dashboard.dart';
import 'package:lms/view/admin/admin_return.dart';
import 'package:lms/view/admin/data_borrowers.dart';
import 'package:lms/view/admin/data_page.dart';
import 'package:lms/view/admin/data_returners.dart';
import 'package:provider/provider.dart';

import 'admin_side_bar.dart';

class AdminHomeScreen extends StatefulWidget {
  @override
  _AdminHomeScreenState createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  Box<BookModel>? dataBox;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final sidebarDecoration = BoxDecoration(
      gradient: LinearGradient(
          colors: [Color(0xff00B4DB), Color(0xff0083B0)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter));

  @override
  void initState() {
    dataBox = Hive.box<BookModel>('books');
    print('opened at admin');
    super.initState();
  }

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
      body: Builder(builder: (context) {
        return SingleChildScrollView(
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
                              getSelectedWidget(menu.isSelectedSidebar,
                                  WidgetResponsive.mobile),
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
                          width: width * 0.2,
                          decoration: sidebarDecoration,
                          alignment: Alignment.topLeft,
                          child: AdminSideBar(),
                        ),
                        Container(
                          width: width * 0.8,
                          child: getSelectedWidget(
                              menu.isSelectedSidebar, WidgetResponsive.tablet),
                        ),
                      ],
                    ),
                    desktop: Row(
                      children: [
                        Container(
                          width: width * 0.2,
                          decoration: sidebarDecoration,
                          alignment: Alignment.topLeft,
                          child: AdminSideBar(),
                        ),
                        Container(
                          width: width * 0.8,
                          child: getSelectedWidget(
                              menu.isSelectedSidebar, WidgetResponsive.desktop),
                        ),
                      ],
                    )),
              );
            },
          ),
        );
      }),
    );
  }

  Widget getSelectedWidget(int val, WidgetResponsive responsive) {
    switch (val) {
      case 0:
        return AdminDashboard(
          widgetResponsive: responsive,
        );
      case 1:
        return DataPage();
      case 3:
        return AdminBorrow();
      case 4:
        return AdminReturn();
      case 2:
        return DataBorrowers();
      case 5:
        return DataReturners();
      default:
        AdminDashboard(
          widgetResponsive: WidgetResponsive.desktop,
        );
    }
    return Container();
  }
}
