import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hive/hive.dart';
import 'package:lms/model/hive/book_model.dart';
import 'package:lms/view/admin/widgets/text_dialog_widget.dart';

class DataPage extends StatefulWidget {
  const DataPage({Key? key}) : super(key: key);

  @override
  _DataPageState createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  bool edit = false;
  bool haveContent = false;

  Box<BookModel>? dataBox;
  TextEditingController controller = TextEditingController();
  String _searchResult = '';
  List<BookModel>? booksList;
  List<BookModel>? filteredBooks;
  String updatedText = '';
  String selectedOption = "ID";

  @override
  void initState() {
    dataBox = Hive.box<BookModel>("books");
    booksList = dataBox!.values.toList();
    filteredBooks = booksList!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double containerHeight = height * 0.06;
    double containerWidth = width * 0.2;

    return Scaffold(
      backgroundColor: Colors.black54,
      body: Container(
        color: Colors.white,
        height: height,
        width: width,
        child: Container(
          height: height * 0.15,
          width: width,
          color: Colors.black54,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: width * 0.06,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          edit = true;
                        });
                      },
                      child: Text('Edit'),
                    ),
                  ),
                  Container(
                    width: width * 0.14,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Sort by',
                          style: TextStyle(color: Colors.white),
                        ),
                        Container(
                          width: width * 0.06,
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              canvasColor: Colors.blue.shade400,
                            ),
                            child: DropdownButton(
                                value: selectedOption,
                                icon: Padding(
                                  padding: EdgeInsets.only(left: width * 0.007),
                                  child: Icon(
                                    Icons.arrow_circle_down_sharp,
                                    color: Colors.white,
                                  ),
                                ),
                                underline: Container(
                                  height: 0,
                                ),
                                onChanged: (String? newValue) {
                                  if (newValue == "Title") {
                                    filteredBooks!.sort((a, b) =>
                                        a.bookName!.compareTo(b.bookName!));
                                  } else if (newValue == "Author") {
                                    filteredBooks!.sort((a, b) =>
                                        a.author!.compareTo(b.author!));
                                  } else {
                                    filteredBooks!.sort((a, b) => a
                                        .serialNumber!
                                        .compareTo(b.serialNumber!));
                                  }
                                  setState(() {
                                    selectedOption = newValue!;
                                  });
                                },
                                iconEnabledColor: Colors.blue[900],
                                items: ["Title", "Author", "ID"]
                                    .map(
                                      (option) => DropdownMenuItem(
                                        child: Text(
                                          option,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        value: option,
                                      ),
                                    )
                                    .toList()),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.005, vertical: 0),
                    width: containerWidth,
                    height: containerHeight,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(29.5)),
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        border: InputBorder.none,
                        hintText: "Search..",
                        // suffix: haveContent
                        //     ? Padding(
                        //         padding: const EdgeInsets.all(8.0),
                        //         child: IconButton(
                        //           icon: Icon(
                        //             Icons.clear_rounded,
                        //             color: Colors.grey,
                        //           ),
                        //           onPressed: () {
                        //             setState(() {
                        //               filteredBooks = booksList;
                        //               _searchResult = '';
                        //               controller.clear();
                        //               haveContent = false;
                        //             });
                        //           },
                        //         ),
                        //       )
                        // : null,
                      ),
                      onChanged: (value) {
                        setState(() {
                          _searchResult = value.toLowerCase();
                          haveContent = true;
                        });
                        filteredBooks = booksList!
                            .where((element) =>
                                element.bookName!
                                    .toLowerCase()
                                    .contains(_searchResult) ||
                                element.author!
                                    .toLowerCase()
                                    .contains(_searchResult))
                            .toList();
                      },
                    ),
                  ),
                ],
              ),
              Container(
                height: height * 0.85,
                width: width,
                color: Colors.white,
                child: SingleChildScrollView(
                  child: DataTable(
                    columns: const <DataColumn>[
                      DataColumn(
                        label: Text(
                          'ID',
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Title',
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Author',
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Edition',
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Publisher',
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                    rows: filteredBooks!.map((book) {
                      return DataRow(cells: [
                        DataCell(Text(
                          book.serialNumber.toString(),
                          overflow: TextOverflow.visible,
                          softWrap: true,
                        )),
                        DataCell(
                            Text(
                              book.bookName.toString(),
                            ),
                            showEditIcon: edit, onTap: () async {
                          updatedText = await showTextDialog(context,
                              title: 'Title', value: book.bookName.toString());
                          int foundIndex = booksList!.indexOf(book);
                          booksList![foundIndex].bookName = updatedText;
                          setState(() {});
                        }),
                        DataCell(Text(
                          book.author.toString(),
                        )),
                        DataCell(Text(
                          book.edition.toString(),
                        )),
                        DataCell(
                            Text(
                              book.publisherName.toString(),
                            ),
                            showEditIcon: edit),
                      ]);
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget buildDataTable() {
//   final columns = ['ID','Title','Total Books','Available'];

//   return DataTable(columns: getColumns(columns), rows: getRows(books))
// }



// List<DataColumn> getColumns(List<String> columns) => columns.map((String column) => DataColumn(label: Text(column))).toList();



// const <DataRow>[
//             DataRow(
//               cells: <DataCell>[
//                 DataCell(Text('12345')),
//                 DataCell(Text('wings of fire')),
//                 DataCell(Text('Kalam')),
//                 DataCell(Text('100')),
//                 DataCell(
//                   Text('10'),
//                 )
//               ],
//             ),
//             DataRow(
//               cells: <DataCell>[
//                 DataCell(Text('12345')),
//                 DataCell(Text('wings of fire')),
//                 DataCell(Text('Kalam')),
//                 DataCell(Text('100')),
//                 DataCell(Text('10'))
//               ],
//             ),
//             DataRow(
//               cells: <DataCell>[
//                 DataCell(Text('12345')),
//                 DataCell(Text('wings of fire')),
//                 DataCell(Text('Kalam')),
//                 DataCell(Text('100')),
//                 DataCell(Text('10'))
//               ],
//             ),
//             DataRow(
//               cells: <DataCell>[
//                 DataCell(Text('12345')),
//                 DataCell(Text('wings of fire')),
//                 DataCell(Text('Kalam')),
//                 DataCell(Text('100')),
//                 DataCell(Text('10'))
//               ],
//             ),
//             DataRow(
//               cells: <DataCell>[
//                 DataCell(Text('12345')),
//                 DataCell(Text('wings of fire')),
//                 DataCell(Text('Kalam')),
//                 DataCell(Text('100')),
//                 DataCell(Text('10'))
//               ],
//             ),
//           ],


// IconButton(
//                             alignment: Alignment.centerRight,
//                             icon: Icon(Icons.search),
//                             color: Colors.blue,
//                             onPressed: () {},
//                           ),