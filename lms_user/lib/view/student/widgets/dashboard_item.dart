import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:lms_student_user/main.dart';
import 'package:lms_student_user/util/responsive.dart';

class DItem {
  final String title;
  final String subtitle;
  final Function onclick;
  final Color color;
  final String image;
  DItem({
    required this.title,
    required this.subtitle,
    required this.onclick,
    required this.image,
    required this.color,
  });
}

class DashboardItem extends StatelessWidget {
  final WidgetResponsive widgetResponsive;
  final DItem item;
  const DashboardItem(
      {Key? key, required this.widgetResponsive, required this.item})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return widgetResponsive == WidgetResponsive.mobile
          ? Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: constraints.maxHeight * 0.05,
                ),
                Container(
                  height: constraints.maxHeight * 0.3,
                  child: Image.asset(
                    item.image,
                    height: 60,
                    width: 60,
                  ),
                ),
                Container(
                    height: constraints.maxHeight * 0.2,
                    child: AutoSizeText(
                      item.title,
                      group: ditemgroup,
                      style: TextStyle(
                          fontSize: 100,
                          color: item.color == Colors.blue
                              ? Colors.white
                              : Colors.orange),
                    )),
                Container(
                    alignment: Alignment.center,
                    height: constraints.maxHeight * 0.2,
                    width: constraints.maxWidth * 0.9,
                    child: AutoSizeText(
                      item.subtitle,
                      textAlign: TextAlign.center,
                      group: ditemsubtitlegroup,
                      maxLines: 2,
                      style: TextStyle(
                        color: item.color == Colors.blue
                            ? Colors.white
                            : Colors.grey,
                        fontSize: 100,
                      ),
                    )),
                Container(
                  height: constraints.maxHeight * 0.05,
                ),
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: constraints.maxHeight * 0.05,
                ),
                Container(
                  height: constraints.maxHeight * 0.3,
                  child: Image.asset(
                    item.image,
                    height: 60,
                    width: 60,
                  ),
                ),
                Container(
                    height: constraints.maxHeight * 0.2,
                    child: AutoSizeText(
                      item.title,
                      group: ditemgroup,
                      style: TextStyle(
                          fontSize: 100,
                          color: item.color == Colors.blue
                              ? Colors.white
                              : Colors.orange),
                    )),
                Container(
                    alignment: Alignment.center,
                    height: constraints.maxHeight * 0.2,
                    width: constraints.maxWidth * 0.9,
                    child: AutoSizeText(
                      item.subtitle,
                      textAlign: TextAlign.center,
                      group: ditemsubtitlegroup,
                      maxLines: 2,
                      style: TextStyle(
                        color: item.color == Colors.blue
                            ? Colors.white
                            : Colors.grey,
                        fontSize: 100,
                      ),
                    )),
                Container(
                  height: constraints.maxHeight * 0.05,
                ),
              ],
            );
    });
  }
}
