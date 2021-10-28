import 'package:flutter/material.dart';

class SideBarMenuModel extends ChangeNotifier {
  int isSelectedSidebar = 1;

  void change(int x) {
    isSelectedSidebar = x;
    notifyListeners();
  }
}
