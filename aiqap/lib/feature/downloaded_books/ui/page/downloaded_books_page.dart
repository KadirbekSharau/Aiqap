import 'package:flutter/material.dart';

class DownloadedBooksPage extends StatefulWidget {
  DownloadedBooksPage({Key key}) : super(key: key);

  @override
  _DownloadedBooksPageState createState() => _DownloadedBooksPageState();
}

class _DownloadedBooksPageState extends State<DownloadedBooksPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("downloaded books page"),
      ),
    );
  }
}
