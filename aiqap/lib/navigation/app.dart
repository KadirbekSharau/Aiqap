import 'package:aiqap/feature/audioProvider/audio_provider.dart';
import 'package:aiqap/feature/book_page/ui/page/book_page.dart';
import 'package:aiqap/feature/downloaded_books/ui/page/downloaded_books_page.dart';
import 'package:aiqap/feature/main_page/ui/page/main_page.dart';
import 'package:aiqap/feature/playing_now/ui/page/playing_now_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class App extends StatefulWidget {
  App({Key key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ScreenUtilInit(
        designSize: Size(1080, 2340),
        allowFontScaling: true,
        builder: () => ChangeNotifierProvider(
          create: (context) => AudioProvider(),
          child: MaterialApp(
            navigatorKey: navigatorKey,
            onGenerateRoute: (settings) {
              if (settings.name == "/book_page") {
                List args = settings.arguments;
                return MaterialPageRoute(
                  builder: (context) => BookPage(
                    book: args[0],
                  ),
                );
              }

              if (settings.name == '/playing_now') {
                return MaterialPageRoute(
                  builder: (context) => PlayingNowPage(),
                );
              }
              return MaterialPageRoute(builder: (context) => Scaffold());
            },
            home: Scaffold(
              resizeToAvoidBottomInset: true,
              floatingActionButton: Consumer<AudioProvider>(
                builder: (context, value, child) {
                  return value.playerState == "STOP"
                      ? Container()
                      : controlBtn();
                },
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              bottomNavigationBar: bottomNavigationBar(),
              body: buildBody(),
            ),
          ),
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
    return BottomAppBar(
      child: BottomNavigationBar(
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
      ),
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

  Widget controlBtn() {
    return Consumer<AudioProvider>(
      builder: (context, value, child) {
        return InkWell(
          onTap: () {
            navigatorKey.currentState.pushNamed("/playing_now");
          },
          child: Container(
            margin: EdgeInsets.all(0),
            height: ScreenUtil().setHeight(200.0),
            width: ScreenUtil().setHeight(200.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                  ScreenUtil().setHeight(100.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    blurRadius: ScreenUtil().setHeight(100.0),
                  ),
                ]),
            child: Center(
              child: SvgPicture.asset(
                value.playerState != "PAUSE"
                    ? "assets/icons/pause.svg"
                    : "assets/icons/play.svg",
                color: Color.fromRGBO(192, 96, 70, 1),
              ),
            ),
          ),
        );
      },
    );
  }
}
