import 'package:aiqap/feature/main_page/bloc/main_page_bloc.dart';
import 'package:aiqap/feature/main_page/bloc/main_page_event.dart';
import 'package:aiqap/feature/main_page/bloc/main_page_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aiqap/feature/main_page/model/book.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  MainPageBloc mainPageBloc = MainPageBloc();

  @override
  void initState() {
    mainPageBloc.add(FetchGanresEvent());
    super.initState();
  }

  @override
  void dispose() {
    mainPageBloc.close();
    super.dispose();
  }

  void navigateToBook(Book book) {
    Navigator.pushNamed(context, "/book_page", arguments: [book.id]);
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => mainPageBloc,
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.only(top: 50),
          child: Column(
            children: [
              searchBar(),
              Expanded(
                child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: BlocConsumer<MainPageBloc, MainPageState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        if (state is ErrorMainPageState) {
                          return Center(
                            child: Text(
                              "${state.error}",
                              textAlign: TextAlign.center,
                            ),
                          );
                        }
                        if (state is LoadingMainPageState) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (state is FetchedBooksByGanreState) {
                          return SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                    SizedBox(
                                        height: ScreenUtil().setHeight(100.0)),
                                    Container()
                                  ] +
                                  state.ganres
                                      .map(
                                        (e) => bookSection(
                                          heading: e.janre,
                                          bookList: e.books,
                                        ),
                                      )
                                      .toList(),
                            ),
                          );
                        }
                        return Container();
                      },
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget searchBar() {
    return Container(
      height: ScreenUtil().setHeight(130.0),
      width: double.infinity,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.only(right: ScreenUtil().setHeight(30.0)),
            width: ScreenUtil().setHeight(1000.0),
            decoration: BoxDecoration(
              color: Color.fromRGBO(242, 242, 242, 1),
              border: Border.all(
                  width: ScreenUtil().setHeight(3), color: Colors.grey[400]),
              borderRadius: BorderRadius.circular(
                ScreenUtil().setHeight(40.0),
              ),
            ),
            child: TextField(
              autofocus: false,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "іздеу",
                hintStyle: TextStyle(
                  color: Colors.grey[500],
                ),
                prefixIcon: Icon(Icons.search_rounded),
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bookSection(
      {@required String heading, @required List<Book> bookList}) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            heading,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 5,
            ),
            height: MediaQuery.of(context).size.height * 0.25,
            child: ListView.builder(
              itemBuilder: (ctx, i) => GestureDetector(
                child: Row(
                  children: [
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            navigateToBook(bookList[i]);
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.21,
                            width: MediaQuery.of(context).size.width * 0.63,
                            child: Stack(
                              children: [
                                Container(
                                  width: double.infinity,
                                  child: Stack(
                                    children: <Widget>[
                                      Container(
                                        alignment: Alignment.center,
                                        child: Image.asset(
                                          'assets/abay_path.png',
                                          height: 250,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(20.0),
                                                topRight: Radius.circular(20))),
                                      ),
                                      Container(
                                        alignment: Alignment.bottomLeft,
                                        child: Text(
                                          'Абай жолы',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22.0),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 30,
                    ),
                  ],
                ),
              ),
              itemCount: bookList.length,
              scrollDirection: Axis.horizontal,
            ),
          )
        ],
      ),
    );
  }
}
