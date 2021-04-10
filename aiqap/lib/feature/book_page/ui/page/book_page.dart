import 'dart:io';
import 'dart:ui';
import 'package:aiqap/feature/book_page/ui/widgets/book_page_widgets.dart';
import 'package:aiqap/feature/downloaded_books/resources/downloads_repository.dart';
import 'package:aiqap/feature/main_page/model/book.dart';
import 'package:aiqap/feature/main_page/ui/widgets/widgets.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class BookPage extends StatefulWidget {
  final Book book;
  BookPage({Key key, this.book}) : super(key: key);

  @override
  _BookPageState createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final Dio dio = Dio();
  Book book;
  bool loading = false;
  double progress = 0;
  @override
  void initState() {
    book = widget.book;
    super.initState();
  }

  Future<bool> saveFile(Book book) async {
    if (book == null || book.audio == null || book.audio == "") return false;
    Directory directory;
    try {
      if (Platform.isAndroid) {
        if (await getPermission(Permission.storage)) {
          //
          directory = await getExternalStorageDirectory();
          String newPath = "";
          List<String> folders = directory.path.split("/");
          for (int i = 1; i < folders.length; i++) {
            String folder = folders[i];
            if (folder != "Android") {
              newPath += "/" + folder;
            } else {
              break;
            }
          }

          newPath += "/aiqap";
          directory = Directory(newPath);
        } else {
          return false;
        }
      } else {
        //not implemented
      }

      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }

      if (await directory.exists()) {
        File savedFile = File(directory.path + "/${book.title}_${book.id}.mp3");
        if (await savedFile.exists()) return true;
        await dio.download(
          book.audio,
          savedFile.path,
          onReceiveProgress: (downloaded, totalSize) {
            if (mounted) {
              setState(
                () {
                  progress = downloaded / totalSize;
                },
              );
            }
          },
        );
        return true;
      }
    } catch (e) {
      //
      print(e);
    }
  }

  Future<bool> getPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var res = await permission.request();
      if (res == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }

  downloadBook(Book book) async {
    if (loading) return;
    setState(() {
      loading = true;
    });

    if (!await saveFile(book)) {
      ScaffoldMessenger.of(_scaffoldKey.currentContext).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Container(
            child: Text(
              "Қателік орын алды!",
              style: TextStyle(
                  color: Colors.white, fontSize: ScreenUtil().setHeight(40.0)),
            ),
          ),
        ),
      );
    } else {
      DownloadsRepository repository = DownloadsRepository();
      repository.saveBookDetails(book);
      ScaffoldMessenger.of(_scaffoldKey.currentContext).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Container(
            child: Text(
              "Сәтті жүктелді!",
              style: TextStyle(
                  color: Colors.white, fontSize: ScreenUtil().setHeight(40.0)),
            ),
          ),
        ),
      );
    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          book.img == null ? placeholderImage() : networkImage(book.img),
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 15.0,
              sigmaY: 15.0,
            ),
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(height: ScreenUtil().setHeight(100.0)),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setHeight(50.0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Icon(
                        Icons.arrow_back_ios_rounded,
                        size: ScreenUtil().setHeight(100.0),
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              imageContainer(book),
              SizedBox(height: ScreenUtil().setHeight(100.0)),
              dataContainer(book),
            ],
          )
        ],
      ),
    );
  }

  Widget dataContainer(Book book) {
    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: ScreenUtil().setHeight(100.0),
              spreadRadius: ScreenUtil().setHeight(100.0),
            ),
          ],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
              ScreenUtil().setHeight(50.0),
            ),
            topRight: Radius.circular(
              ScreenUtil().setHeight(50.0),
            ),
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: ScreenUtil().setHeight(50.0)),
            loading
                ? Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setHeight(50.0)),
                    child: LinearProgressIndicator(
                      minHeight: ScreenUtil().setHeight(15),
                      value: progress,
                    ),
                  )
                : Container(
                    height: ScreenUtil().setHeight(15.0),
                  ),
            SizedBox(height: ScreenUtil().setHeight(50.0)),
            Text(
              '${book.title}',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: ScreenUtil().setSp(70.0),
              ),
            ),
            SizedBox(height: ScreenUtil().setHeight(30.0)),
            actionsContainer(book, downloadBook),
            SizedBox(height: ScreenUtil().setHeight(30.0)),
            descriptionText(book),
          ],
        ),
      ),
    );
  }
}
