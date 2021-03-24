import 'package:flutter/material.dart';
import 'package:aiqap/feature/main_page/model/book.dart';
import 'package:aiqap/feature/book_page/ui/page/book_page.dart';

class DownloadedBooksPage extends StatefulWidget {
  DownloadedBooksPage({Key key}) : super(key: key);

  @override
  _DownloadedBooksPageState createState() => _DownloadedBooksPageState();
}

class _DownloadedBooksPageState extends State<DownloadedBooksPage> {
  List<Book> bookList =booksList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Жүктелген кітаптар",
        style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: bookList.map((book) => downloadedBook()).toList(),
          ),
        ),
      ),
    );
  }
}

Widget downloadedBook () {
  return InkWell(
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), topRight: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          // Icon(
          //   Icons.folder,
          //   color: Colors.white,
          // ),
          SizedBox(
            width: 21,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Қаһар",
                        style: TextStyle(
                            color: Color(0xff333333),
                            fontWeight: FontWeight.bold,
                            fontSize: 21),
                      ),
                    ],
                  ),
                ),
                Text(
                  "Ілияс Есенберлин",
                  style: TextStyle(color: Colors.black),
                  softWrap: false,
                  overflow: TextOverflow.fade,
                )
              ],
            ),
          ),
          IconButton(icon: Icon(Icons.restore_from_trash_outlined),)
        ],
      ),

    ),
    onTap: () {},
  );
}



// Define a corresponding State class.
