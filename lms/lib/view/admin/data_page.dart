import 'dart:html';
import 'dart:js';

import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    TextEditingController controller = TextEditingController();
    String _searchResult = '';
    Box<BookModel> dataBox = Hive.box<BookModel>("books");

    final List<BookModel> booksList = dataBox.values.toList();

    List<BookModel> filteredBooks = booksList;

    Future updateTableItems() async {
      filteredBooks = booksList
          .where((element) =>
              element.bookName!.toLowerCase().contains(_searchResult) ||
              element.author!.toLowerCase().contains(_searchResult))
          .toList();
    }

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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        edit = true;
                      });
                    },
                    child: Text('Edit'),
                  ),
                  Container(
                    height: height * 0.06,
                    width: width * 0.2,
                    child: Card(
                      child: ListTile(
                        leading: Icon(Icons.search),
                        title: TextField(
                          decoration: InputDecoration(
                              hintText: 'Search', border: InputBorder.none),
                          onChanged: (value) {
                            setState(() {
                              _searchResult = value.toLowerCase();
                            });
                            updateTableItems().then((value) {
                              setState(() {});
                            });
                          },
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.cancel),
                          onPressed: () {
                            setState(() {
                              controller.clear();
                              _searchResult = '';
                              filteredBooks = booksList;
                            });
                          },
                        ),
                      ),
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
                          overflow: TextOverflow.fade,
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Title',
                          overflow: TextOverflow.visible,
                          softWrap: true,
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Author',
                          overflow: TextOverflow.visible,
                          softWrap: true,
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Edition',
                          overflow: TextOverflow.visible,
                          softWrap: true,
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Publisher',
                          overflow: TextOverflow.visible,
                          softWrap: true,
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                    rows: filteredBooks.map((book) {
                      return DataRow(cells: [
                        DataCell(Text(
                          book.serialNumber.toString(),
                          overflow: TextOverflow.visible,
                          softWrap: true,
                        )),
                        DataCell(
                            Text(
                              book.bookName.toString(),
                              overflow: TextOverflow.visible,
                              softWrap: true,
                            ),
                            showEditIcon: edit, onTap: () {
                          setState(() {
                            showTextDialog(context,
                                title: 'Title',
                                value: book.bookName.toString());
                          });
                        }),
                        DataCell(Text(
                          book.author.toString(),
                          overflow: TextOverflow.visible,
                          softWrap: true,
                        )),
                        DataCell(Text(
                          book.edition.toString(),
                          overflow: TextOverflow.visible,
                          softWrap: true,
                        )),
                        DataCell(
                            Text(
                              book.publisherName.toString(),
                              overflow: TextOverflow.visible,
                              softWrap: true,
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