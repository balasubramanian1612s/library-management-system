import 'dart:html';
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

    return Scaffold(
      backgroundColor: Colors.white30,
      body: Container(
        color: Colors.white,
        height: height,
        width: width,
        child: Container(
          height: height * 0.2,
          width: width,
          color: Colors.white38,
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
                    padding: EdgeInsets.symmetric(horizontal: width * 0.02),
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
                        SizedBox(
                          width: width * 0.005,
                        ),
                        Theme(
                          data: Theme.of(context).copyWith(
                            canvasColor: Colors.blue.shade400,
                          ),
                          child: DropdownButton(
                              value: selectedOption,
                              icon: Icon(
                                Icons.arrow_circle_down_sharp,
                                color: Colors.white,
                              ),
                              underline: Container(
                                height: 0,
                              ),
                              onChanged: (String? newValue) {
                                if (newValue == "Title") {
                                  filteredBooks!.sort((a, b) =>
                                      a.bookName!.compareTo(b.bookName!));
                                } else if (newValue == "Author") {
                                  filteredBooks!.sort(
                                      (a, b) => a.author!.compareTo(b.author!));
                                } else {
                                  filteredBooks!.sort((a, b) => a.serialNumber!
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
                        )
                      ],
                    ),
                  ),
                  Container(
                      height: height * 0.08,
                      width: width * 0.5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: TextField(
                                controller: controller,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  hintText: 'Search',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30))),
                                  suffixIcon: IconButton(
                                    icon: Icon(Icons.clear),
                                    onPressed: () {
                                      controller.clear();
                                      setState(() {
                                        filteredBooks = booksList!;
                                        _searchResult = '';
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.blue[800],
                                  borderRadius: BorderRadius.circular(30)),
                              child: IconButton(
                                icon: Icon(
                                  Icons.search,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  _searchResult = controller.text.toLowerCase();
                                  setState(() {
                                    filteredBooks = booksList!
                                        .where((element) =>
                                            element.bookName!
                                                .toLowerCase()
                                                .contains(_searchResult) ||
                                            element.author!
                                                .toLowerCase()
                                                .contains(_searchResult))
                                        .toList();
                                  });
                                },
                              ),
                            )
                          ],
                        ),
                      )),
                ],
              ),
              Container(
                height: height * 0.8,
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