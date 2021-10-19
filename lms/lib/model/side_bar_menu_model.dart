import 'package:flutter/material.dart';

class SideBarMenuModel extends ChangeNotifier {
  int isSelectedSidebar = 0;

  void change(int x) {
    isSelectedSidebar = x;
    notifyListeners();
  }
}
