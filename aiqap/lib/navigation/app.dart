import 'package:aiqap/feature/book_page/ui/page/book_page.dart';
import 'package:aiqap/feature/downloaded_books/ui/page/downloaded_books_page.dart';
import 'package:aiqap/feature/main_page/ui/page/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class App extends StatefulWidget {
  App({Key key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (settings) {
        if (settings.name == "/book_page") {
          List args = settings.arguments;
          return MaterialPageRoute(
            builder: (context) => BookPage(
              bookId: args[0],
            ),
          );
        }
        return MaterialPageRoute(builder: (context) => Scaffold());
      },
      home: ScreenUtilInit(
        designSize: Size(1080, 2340),
        allowFontScaling: true,
        builder: () => Scaffold(
          resizeToAvoidBottomPadding: true,
          floatingActionButton: audioPlayer(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          bottomNavigationBar: bottomNavigationBar(),
          body: buildBody(),
        ),
      ),
    );
  }

  Widget buildBody() {
    if (_currentPage == 0) {
      return MainPage();
    } else {
      return DownloadedBooksPage();
    }
  }

  Widget bottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _currentPage,
      backgroundColor: Colors.white,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: Colors.amber,
      onTap: (index) {
        setState(() {
          _currentPage = index;
        });
      },
      items: navigations(),
    );
  }

  List<BottomNavigationBarItem> navigations() {
    return [
      BottomNavigationBarItem(
        icon: Icon(Icons.library_books),
        label: "Main Page",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.file_download),
        label: "Downloads Page",
      )
    ];
  }

  Widget audioPlayer() {
    return Container(
      margin: EdgeInsets.all(0),
      height: ScreenUtil().setHeight(200.0),
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: double.infinity,
            width: ScreenUtil().setWidth(400.0),
            decoration: BoxDecoration(
              border: Border.all(
                width: ScreenUtil().setHeight(3),
                color: Colors.grey[300],
              ),
            ),
            child: Center(
              child: Text("Абай жолы"),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SvgPicture.asset(
                      "assets/icons/prev.svg",
                      color: Colors.black,
                    ),
                    SvgPicture.asset(
                      "assets/icons/pause.svg",
                      color: Colors.black,
                    ),
                    SvgPicture.asset(
                      "assets/icons/next.svg",
                      color: Colors.black,
                    ),
                  ],
                ),
                Stack(
                  children: [
                    Container(
                      width: ScreenUtil().setHeight(600),
                      height: ScreenUtil().setHeight(15),
                      color: Colors.grey[300],
                    ),
                    Container(
                      width: ScreenUtil().setHeight(300),
                      height: ScreenUtil().setHeight(15),
                      color: Colors.green,
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
