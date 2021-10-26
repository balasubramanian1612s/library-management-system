import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:lms/main.dart';
import 'package:lms/model/side_bar_menu_model.dart';
import 'package:lms/util/responsive.dart';
import 'package:lms/view/admin/widgets/dashboard_item.dart';
import 'package:provider/provider.dart';

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
                  color: Colors.white,
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                      ),
                      Container(
                        height: 50,
                        width: constraints.maxWidth * 0.5,
                        alignment: Alignment.centerLeft,
                        child: AutoSizeText(
                          'Dashboard',
                          group: ditemsubtitlegroup,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 100,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 150,
                  padding: EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Provider.of<SideBarMenuModel>(context, listen: false)
                              .change(3);
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          height: 150,
                          width: constraints.maxWidth / 2 - 15,
                          child: Column(
                            children: [
                              Container(
                                  height: 60,
                                  child: AutoSizeText(
                                    'Borrow',
                                    style: TextStyle(
                                        fontSize: 100, color: Colors.white),
                                  )),
                              Container(
                                height: 10,
                              ),
                              Container(
                                  alignment: Alignment.center,
                                  height: 50,
                                  child: AutoSizeText(
                                    'Click here for borrow entry',
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 100,
                                    ),
                                  )),
                            ],
                          ),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                Color(0xff00B4DB),
                                Color(0xff0083B0)
                              ])),
                        ),
                      ),
                      Expanded(child: Container()),
                      InkWell(
                        onTap: () {
                          Provider.of<SideBarMenuModel>(context, listen: false)
                              .change(3);
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          height: 150,
                          width: constraints.maxWidth / 2 - 15,
                          child: Column(
                            children: [
                              Container(
                                  height: 60,
                                  child: AutoSizeText(
                                    'Return',
                                    style: TextStyle(
                                        fontSize: 100, color: Colors.white),
                                  )),
                              Container(
                                height: 10,
                              ),
                              Container(
                                  alignment: Alignment.center,
                                  height: 50,
                                  child: AutoSizeText(
                                    'Click here for return entry',
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 100,
                                    ),
                                  )),
                            ],
                          ),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                Color(0xff00B4DB),
                                Color(0xff0083B0)
                              ])),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: constraints.maxHeight - 200,
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
                      color: Colors.white,
                      height: 50,
                      child: Row(
                        children: [
                          Container(
                            height: 30,
                            width: constraints.maxWidth * 0.5,
                            alignment: Alignment.centerLeft,
                            child: AutoSizeText(
                              '   Dashboard',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 100,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 150,
                      padding: EdgeInsets.only(
                        left: 10,
                        right: 10,
                      ),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Provider.of<SideBarMenuModel>(context,
                                      listen: false)
                                  .change(3);
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              height: 150,
                              width: constraints.maxWidth / 2 - 15,
                              child: Column(
                                children: [
                                  Container(
                                      height: 60,
                                      child: AutoSizeText(
                                        'Borrow',
                                        style: TextStyle(
                                            fontSize: 100, color: Colors.white),
                                      )),
                                  Container(
                                    height: 10,
                                  ),
                                  Container(
                                      alignment: Alignment.center,
                                      height: 50,
                                      child: AutoSizeText(
                                        'Click here for borrow entry',
                                        group: ditemsubtitlegroup,
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 100,
                                        ),
                                      )),
                                ],
                              ),
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                    Color(0xff00B4DB),
                                    Color(0xff0083B0)
                                  ])),
                            ),
                          ),
                          Expanded(child: Container()),
                          InkWell(
                            onTap: () {
                              Provider.of<SideBarMenuModel>(context,
                                      listen: false)
                                  .change(4);
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              height: 150,
                              width: constraints.maxWidth / 2 - 15,
                              child: Column(
                                children: [
                                  Container(
                                      height: 60,
                                      child: AutoSizeText(
                                        'Return',
                                        style: TextStyle(
                                            fontSize: 100, color: Colors.white),
                                      )),
                                  Container(
                                    height: 10,
                                  ),
                                  Container(
                                      alignment: Alignment.center,
                                      height: 50,
                                      child: AutoSizeText(
                                        'Click here for return entry',
                                        group: ditemsubtitlegroup,
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 100,
                                        ),
                                      )),
                                ],
                              ),
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                    Color(0xff00B4DB),
                                    Color(0xff0083B0)
                                  ])),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: constraints.maxHeight - 200,
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
                      color: Colors.white,
                      height: 50,
                      child: Row(
                        children: [
                          Container(
                            height: 30,
                            width: constraints.maxWidth * 0.5,
                            alignment: Alignment.centerLeft,
                            child: AutoSizeText(
                              '   Dashboard',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 100,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 100,
                      padding: EdgeInsets.only(
                        left: 10,
                        right: 10,
                      ),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Provider.of<SideBarMenuModel>(context,
                                      listen: false)
                                  .change(3);
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              height: 100,
                              width: constraints.maxWidth / 2 - 15,
                              child: Column(
                                children: [
                                  Container(
                                      height: 40,
                                      child: AutoSizeText(
                                        'Borrow',
                                        style: TextStyle(
                                            fontSize: 100, color: Colors.white),
                                      )),
                                  Container(
                                    height: 10,
                                  ),
                                  Container(
                                      alignment: Alignment.center,
                                      height: 30,
                                      child: AutoSizeText(
                                        'Click here for borrow entry',
                                        textAlign: TextAlign.center,
                                        group: ditemsubtitlegroup,
                                        maxLines: 2,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 100,
                                        ),
                                      )),
                                ],
                              ),
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                    Color(0xff00B4DB),
                                    Color(0xff0083B0)
                                  ])),
                            ),
                          ),
                          Expanded(child: Container()),
                          InkWell(
                            onTap: () {
                              Provider.of<SideBarMenuModel>(context,
                                      listen: false)
                                  .change(4);
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              height: 100,
                              width: constraints.maxWidth / 2 - 15,
                              child: Column(
                                children: [
                                  Container(
                                      height: 40,
                                      child: AutoSizeText(
                                        'Return',
                                        style: TextStyle(
                                            fontSize: 100, color: Colors.white),
                                      )),
                                  Container(
                                    height: 10,
                                  ),
                                  Container(
                                      alignment: Alignment.center,
                                      height: 30,
                                      child: AutoSizeText(
                                        'Click here for return entry',
                                        group: ditemsubtitlegroup,
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 100,
                                        ),
                                      )),
                                ],
                              ),
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                    Color(0xff00B4DB),
                                    Color(0xff0083B0)
                                  ])),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: constraints.maxHeight - 200,
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
