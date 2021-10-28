import 'package:flutter/material.dart';

class DashBoardGraphItem extends StatefulWidget {
  const DashBoardGraphItem({Key? key}) : super(key: key);

  @override
  _DashBoardGraphItemState createState() => _DashBoardGraphItemState();
}

class _DashBoardGraphItemState extends State<DashBoardGraphItem> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      return Center(
        child: Container(
          color: Colors.red,
          child: null,
        ),
      );
    });
  }
}
