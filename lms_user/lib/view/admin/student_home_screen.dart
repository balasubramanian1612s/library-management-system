import 'package:flutter/material.dart';
import 'package:lms_student_user/model/side_bar_menu_model.dart';
import 'package:lms_student_user/util/responsive.dart';
import 'package:lms_student_user/view/admin/student_return_history.dart';
import 'package:provider/provider.dart';

import 'student_borrow_history.dart';
import 'student_side_bar.dart';

class AdminHomeScreen extends StatefulWidget {
  String rollnumber;
  AdminHomeScreen(this.rollnumber);
  @override
  _AdminHomeScreenState createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final sidebarDecoration = const BoxDecoration(
      gradient: LinearGradient(
          colors: [Color(0xff00B4DB), Color(0xff0083B0)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter));

  @override
  void initState() {
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
                                  child: const Icon(
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
                        SizedBox(
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
      case 1:
        return AdminBorrowHistory(widget.rollnumber);
      case 2:
        return AdminReturnHistory(widget.rollnumber);
      default:
        AdminBorrowHistory(widget.rollnumber);
    }
    return Container();
  }
}
