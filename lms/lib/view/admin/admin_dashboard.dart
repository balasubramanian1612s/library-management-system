import 'package:flutter/material.dart';
import 'package:lms/util/responsive.dart';
import 'package:lms/view/admin/widgets/dashboard_item.dart';

class AdminDashboard extends StatefulWidget {
  final WidgetResponsive widgetResponsive;
  const AdminDashboard({Key? key, required this.widgetResponsive})
      : super(key: key);

  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  List<DItem> items = [
    DItem(
        title: 'Borrow',
        subtitle: 'Click here for borrow entry',
        onclick: () {},
        image: 'assets/book.png',
        color: Colors.blue),
    DItem(
        title: 'Return',
        subtitle: 'Click here for return entry',
        onclick: () {},
        image: 'assets/book.png',
        color: Colors.blue),
    DItem(
        title: '100',
        subtitle: 'Total Number of Books',
        onclick: () {},
        image: 'assets/book.png',
        color: Colors.white),
    DItem(
        title: '100',
        subtitle: 'Total Number of Borrowers',
        onclick: () {},
        image: 'assets/borrow.png',
        color: Colors.white),
    DItem(
        title: '100',
        subtitle: 'Total Number of Return Expected',
        onclick: () {},
        image: 'assets/return.png',
        color: Colors.white),
    DItem(
        title: '100',
        subtitle: 'Total Number of Due',
        onclick: () {},
        image: 'assets/book.png',
        color: Colors.white),
    DItem(
        title: '100',
        subtitle: 'Total Number of Research Scholar Borrowed',
        onclick: () {},
        image: 'assets/book.png',
        color: Colors.white)
  ];
  @override
  Widget build(BuildContext context) {
    var _crossAxisSpacing = 50;
    var _screenWidth = MediaQuery.of(context).size.width;
    var _crossAxisCount = 2;
    var _width = (_screenWidth - ((_crossAxisCount - 1) * _crossAxisSpacing)) /
        _crossAxisCount;
    var cellHeight = 300;
    var _aspectRatio = _width / cellHeight;

    var _crossAxisCount3 = 3;
    var _width3 =
        (_screenWidth - ((_crossAxisCount3 - 1) * _crossAxisSpacing)) /
            _crossAxisCount3;
    var cellHeight3 = 300;
    var _aspectRatio3 = _width3 / cellHeight3;

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return LayoutBuilder(builder: (context, constraints) {
      return widget.widgetResponsive == WidgetResponsive.mobile
          ? Column(
              children: [
                Container(
                  height: 50,
                  child: Row(
                    children: [],
                  ),
                ),
                Container(
                  height: constraints.maxHeight - 50,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: _aspectRatio,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10),
                        itemCount: items.length,
                        itemBuilder: (context, i) {
                          return Container(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: items[i].color == Colors.white
                                        ? [Colors.white, Colors.white]
                                        : [
                                            Color(0xff00B4DB),
                                            Color(0xff0083B0)
                                          ])),
                            child: DashboardItem(
                              widgetResponsive: WidgetResponsive.mobile,
                              item: items[i],
                            ),
                          );
                        }),
                  ),
                ),
              ],
            )
          : widget.widgetResponsive == WidgetResponsive.tablet
              ? Column(
                  children: [
                    Container(
                      height: 50,
                      child: Row(
                        children: [],
                      ),
                    ),
                    Container(
                      height: constraints.maxHeight - 50,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: _aspectRatio,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10),
                            itemCount: items.length,
                            itemBuilder: (context, i) {
                              return Container(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: items[i].color == Colors.white
                                            ? [Colors.white, Colors.white]
                                            : [
                                                Color(0xff00B4DB),
                                                Color(0xff0083B0)
                                              ])),
                                child: DashboardItem(
                                  widgetResponsive: WidgetResponsive.tablet,
                                  item: items[i],
                                ),
                              );
                            }),
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    Container(
                      height: 50,
                      child: Row(
                        children: [],
                      ),
                    ),
                    Container(
                      height: constraints.maxHeight - 50,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    childAspectRatio: _aspectRatio3,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10),
                            itemCount: items.length,
                            itemBuilder: (context, i) {
                              return Container(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: items[i].color == Colors.white
                                            ? [Colors.white, Colors.white]
                                            : [
                                                Color(0xff00B4DB),
                                                Color(0xff0083B0)
                                              ])),
                                child: DashboardItem(
                                  widgetResponsive: WidgetResponsive.desktop,
                                  item: items[i],
                                ),
                              );
                            }),
                      ),
                    ),
                  ],
                );
    });
  }
}
