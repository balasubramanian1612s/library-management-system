import 'package:flutter/material.dart';
import 'package:lms/util/responsive.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  Widget build(BuildContext context) {
    var _crossAxisSpacing = 50;
    var _screenWidth = MediaQuery.of(context).size.width;
    var _crossAxisCount = 2;
    var _width = (_screenWidth - ((_crossAxisCount - 1) * _crossAxisSpacing)) /
        _crossAxisCount;
    var cellHeight = 200;
    var _aspectRatio = _width / cellHeight;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Responsive(
        mobile: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView.separated(
              itemCount: 10,
              separatorBuilder: (context, i) {
                return SizedBox(
                  height: 10,
                );
              },
              itemBuilder: (context, i) {
                return Container(
                  color: Colors.blue,
                  height: width * 0.5,
                  width: width * 0.3,
                );
              }),
        ),
        tablet: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: _aspectRatio,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10),
              itemCount: 10,
              itemBuilder: (context, i) {
                return Container(
                  color: Colors.blue,
                );
              }),
        ),
        desktop: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: _aspectRatio,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10),
              itemCount: 10,
              itemBuilder: (context, i) {
                return Container(
                  color: Colors.blue,
                );
              }),
        ));
  }
}
