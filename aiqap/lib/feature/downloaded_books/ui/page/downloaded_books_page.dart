import 'package:aiqap/feature/downloaded_books/bloc/downloaded_bloc.dart';
import 'package:aiqap/feature/downloaded_books/bloc/downloaded_event.dart';
import 'package:aiqap/feature/downloaded_books/bloc/downloaded_state.dart';
import 'package:aiqap/feature/main_page/model/book.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DownloadedBooksPage extends StatefulWidget {
  DownloadedBooksPage({Key key}) : super(key: key);

  @override
  _DownloadedBooksPageState createState() => _DownloadedBooksPageState();
}

class _DownloadedBooksPageState extends State<DownloadedBooksPage> {
  DownloadsBloc downloadsBloc = DownloadsBloc();

  @override
  void initState() {
    downloadsBloc.add(GetDownloadsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DownloadsBloc>(
      create: (context) => downloadsBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Жүктелген кітаптар",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ),
        body: BlocBuilder<DownloadsBloc, DownloadsState>(
          builder: (context, state) {
            if (state is LoadingDownloadsState) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is ErrorDownloadedState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [Text(state.err, textAlign: TextAlign.center)],
                ),
              );
            }

            if (state is FetchedDownloadsState) {
              return Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: state.books.length > 0
                        ? state.books.map((e) => downloadedBook(e)).toList()
                        : [
                            SizedBox(height: ScreenUtil().setHeight(200)),
                            Center(
                              child: Text(
                                "Сізде әзірге жүктелген кітаптарыңыз жоқ!",
                              ),
                            )
                          ],
                  ),
                ),
              );
            }
            return Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget downloadedBook(Book book) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, "/book_page", arguments: [book]);
      },
      child: Container(
        margin: EdgeInsets.symmetric(
            vertical: ScreenUtil().setHeight(20.0),
            horizontal: ScreenUtil().setHeight(50.0)),
        padding: EdgeInsets.all(ScreenUtil().setHeight(50.0)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20), topRight: Radius.circular(20)),
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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
            Icon(
              Icons.delete,
              color: Colors.redAccent,
            )
          ],
        ),
      ),
    );
  }
}
