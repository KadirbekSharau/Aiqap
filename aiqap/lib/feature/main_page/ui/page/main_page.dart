import 'package:aiqap/feature/main_page/bloc/main_page_bloc.dart';
import 'package:aiqap/feature/main_page/bloc/main_page_event.dart';
import 'package:aiqap/feature/main_page/bloc/main_page_state.dart';
import 'package:aiqap/feature/main_page/ui/widgets/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aiqap/feature/main_page/model/book.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
    Navigator.pushNamed(context, "/book_page", arguments: [book]);
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
                      return ListView.builder(
                        itemCount: state.books.length,
                        itemBuilder: (BuildContext context, int index) {
                          return bookCard(state.books[index]);
                        },
                      );
                    }
                    return Container();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget searchBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setHeight(40.0)),
      child: Container(
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
      ),
    );
  }

  Widget bookCard(Book book) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setHeight(40.0),
          vertical: ScreenUtil().setHeight(20.0)),
      child: GestureDetector(
        onTap: () => navigateToBook(book),
        child: Container(
          height: ScreenUtil().setHeight(500.0),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(ScreenUtil().setHeight(30.0)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black38,
                  blurRadius: ScreenUtil().setHeight(5.0))
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: ScreenUtil().setHeight(400.0),
                height: double.infinity,
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(ScreenUtil().setHeight(30.0)),
                  child: book.img != null
                      ? networkImage(book.img)
                      : placeholderImage(),
                ),
              ),
              SizedBox(width: ScreenUtil().setHeight(50.0)),
              Container(
                padding: EdgeInsets.only(right: ScreenUtil().setHeight(30.0)),
                width: ScreenUtil().setHeight(550.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${book.title}',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: ScreenUtil().setSp(45.0),
                      ),
                    ),
                    Text(
                      book.description.length > 60
                          ? '${book.description.substring(0, 50)}...'
                          : '${book.description}',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: ScreenUtil().setSp(40.0),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Авторы:",
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text("${book.author.fullName}")
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
