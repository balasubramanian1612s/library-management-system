import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lms/main.dart';
import 'package:lms/model/hive/book_model.dart';
import 'package:lms/model/hive/return_model.dart';
import 'package:lms/model/hive/borrow_model.dart';
import 'package:lms/model/side_bar_menu_model.dart';
import 'package:lms/util/responsive.dart';
import 'package:lms/view/admin/widgets/dashboard_item.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class AdminDashboard extends StatefulWidget {
  final WidgetResponsive widgetResponsive;
  const AdminDashboard({Key? key, required this.widgetResponsive})
      : super(key: key);

  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  Box<BookModel>? booksDB;
  Box<BorrowedBookModel>? borrowDB;
  Box<ReturnBookModel>? returnDB;

  List<DItem> items = [];

  @override
  void initState() {
    booksDB = Hive.box<BookModel>('books');
    borrowDB = Hive.box<BorrowedBookModel>('borrow');
    returnDB = Hive.box<ReturnBookModel>('return');
    super.initState();
  }

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

    int dueCount = 0;

    borrowDB!.values.forEach((brwBook) {
      if (DateTime.now().isAfter(brwBook.dueDate!)) {
        dueCount++;
      }
    });

    items = [
      DItem(
          title: booksDB!.length.toString(),
          subtitle: 'BOOKS',
          onclick: () {},
          image: 'assets/book.png',
          color: Colors.white),
      DItem(
          title: borrowDB!.length.toString(),
          subtitle: 'BOOKS BORROWED',
          onclick: () {},
          image: 'assets/borrow.png',
          color: Colors.white),
      DItem(
          title: dueCount.toString(),
          subtitle: 'RETURNS PAST DUE',
          onclick: () {},
          image: 'assets/book.png',
          color: Colors.white),
    ];

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
                                    borderRadius: BorderRadius.circular(20.0),
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
                    height < 650
                        ? Container(
                            height: 0,
                          )
                        : Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "COMPUTER SCIENCE DEPARTMENT",
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  0, 175, 214, 1),
                                              fontSize: width * 0.025,
                                              overflow: TextOverflow.clip,
                                              fontWeight: FontWeight.w900),
                                        ),
                                        SizedBox(height: height * 0.025),
                                        Text(
                                          "Library Management System",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: width * 0.0165,
                                              overflow: TextOverflow.clip,
                                              fontStyle: FontStyle.italic,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    ),
                                    LottieBuilder.asset('library.json'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 100,
                      padding: EdgeInsets.only(
                        left: 10,
                        right: 10,
                      ),
                      child: Row(
                        children: [
                          Expanded(child: Container()),
                          InkWell(
                            onTap: () {
                              Provider.of<SideBarMenuModel>(context,
                                      listen: false)
                                  .change(3);
                            },
                            child: Container(
                              height: 100,
                              width: constraints.maxWidth / 2 - 30,
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
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
                              height: 100,
                              width: constraints.maxWidth / 2 - 30,
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
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
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 280,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
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
                                    borderRadius: BorderRadius.circular(20.0),
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
