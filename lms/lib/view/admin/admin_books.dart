import 'package:flutter/material.dart';
import 'package:lms/model/book.dart';

class AdminBooks extends StatefulWidget {
  const AdminBooks({Key? key}) : super(key: key);

  @override
  _AdminBooksState createState() => _AdminBooksState();
}

class _AdminBooksState extends State<AdminBooks> {
  List<Book> books = [
    Book(
        id: "123",
        name: "Computer Science and Engg",
        totalQty: 3,
        author: "Robin"),
    Book(
        id: "123",
        name: "Computer Science and Engg",
        totalQty: 3,
        author: "Robin"),
    Book(
        id: "123",
        name: "Computer Science and Engg",
        totalQty: 3,
        author: "Robin"),
    Book(
        id: "123",
        name: "Computer Science and Engg",
        totalQty: 3,
        author: "Robin"),
    Book(
        id: "123",
        name: "Computer Science and Engg",
        totalQty: 3,
        author: "Robin"),
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Table(
          border: TableBorder.all(
              color: Colors.black, style: BorderStyle.solid, width: 2),
          children: [
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(children: [Text('ID', style: TextStyle(fontSize: 20.0))]),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(children: [Text('Name', style: TextStyle(fontSize: 20.0))]),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                    children: [Text('Quantity', style: TextStyle(fontSize: 20.0))]),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(children: [Text('Author', style: TextStyle(fontSize: 20.0))]),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(children: [Text('Edit', style: TextStyle(fontSize: 20.0))]),
              ),
            ]),
            ...books.map<TableRow>((Book b) {
              return TableRow(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: Text(b.id)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: Text(b.name)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: Text(b.totalQty.toString())),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: Text(b.author)),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(child: Text("Soon"))),
              ]);
            }),
          ],
        ),
      ],
    );
  }
}
