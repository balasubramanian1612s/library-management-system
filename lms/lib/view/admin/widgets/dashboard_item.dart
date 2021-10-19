import 'package:flutter/material.dart';

class DashboardItem extends StatelessWidget {
  const DashboardItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Image.asset(
          "assets/psg.png",
          height: 60,
          width: 60,
        ),
        Text('Total Books Available: 100')
      ],
    );
  }
}
