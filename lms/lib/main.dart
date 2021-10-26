import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lms/view/admin/admin_books.dart';
import 'package:lms/view/admin/admin_home_screen.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';
import 'model/side_bar_menu_model.dart';

var titleGroup = AutoSizeGroup();
AutoSizeGroup ditemgroup = AutoSizeGroup();
AutoSizeGroup ditemsubtitlegroup = AutoSizeGroup();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SideBarMenuModel())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: GoogleFonts.latoTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        home: AdminHomeScreen(),
      ),
    );
  }
}
