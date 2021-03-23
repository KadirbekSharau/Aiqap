import 'package:aiqap/feature/downloaded_books/ui/page/downloaded_books_page.dart';
import 'package:aiqap/feature/main_page/ui/page/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      home: ScreenUtilInit(
        designSize: Size(1080, 2340),
        allowFontScaling: true,
        builder: () => Scaffold(
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
}
