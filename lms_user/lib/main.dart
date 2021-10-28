import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lms_student_user/model/hive/book_model.dart';
import 'package:lms_student_user/model/hive/return_model.dart';
import 'package:lms_student_user/model/hive/borrow_model.dart';
import 'package:lms_student_user/view/admin/admin_home_screen.dart';
import 'package:provider/provider.dart';
import 'model/side_bar_menu_model.dart';

var titleGroup = AutoSizeGroup();
AutoSizeGroup ditemgroup = AutoSizeGroup();
AutoSizeGroup ditemsubtitlegroup = AutoSizeGroup();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();

  Hive.registerAdapter<BookModel>(BookModelAdapter());
  Hive.registerAdapter<ReturnBookModel>(ReturnBookModelAdapter());
  Hive.registerAdapter<BorrowedBookModel>(BorrowedBookModelAdapter());

  await Hive.openBox<BookModel>("books");
  await Hive.openBox<BorrowedBookModel>("borrow");
  await Hive.openBox<ReturnBookModel>("return");

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
