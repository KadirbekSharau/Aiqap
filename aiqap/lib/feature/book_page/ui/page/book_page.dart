import 'package:flutter/material.dart';

class BookPage extends StatefulWidget {
  final int bookId;
  BookPage({Key key, this.bookId}) : super(key: key);

  @override
  _BookPageState createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book page"),
      ),
    );
  }
}
