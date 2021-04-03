import 'dart:ui';

import 'package:aiqap/feature/main_page/model/book.dart';
import 'package:aiqap/feature/main_page/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:flutter_svg/svg.dart';
import 'package:aiqap/feature/playing_now/ui/page/playing_now_page.dart';

class BookPage extends StatefulWidget {
  final Book book;
  BookPage({Key key, this.book}) : super(key: key);

  @override
  _BookPageState createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  Book book;
  @override
  void initState() {
    book = widget.book;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              imageContainer(),
              SizedBox(height: ScreenUtil().setHeight(100.0)),
              dataContainer(),
            ],
          )
        ],
      ),
    );
  }

  Widget imageContainer() {
    return Column(
      children: [
        SizedBox(height: ScreenUtil().setHeight(50.0)),
        ClipRRect(
          borderRadius: BorderRadius.circular(
            ScreenUtil().setHeight(100.0),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 18.0,
              sigmaY: 18.0,
            ),
            child: Container(
              height: ScreenUtil().setHeight(800.0),
              width: ScreenUtil().setHeight(800.0),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(
                    ScreenUtil().setHeight(30.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: ScreenUtil().setHeight(100.0),
                      spreadRadius: ScreenUtil().setHeight(100.0),
                    ),
                  ]),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  ScreenUtil().setHeight(100.0),
                ),
                child: book.img == null
                    ? placeholderImage()
                    : networkImage(book.img),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget actionsContainer() {
    return Container(
      width: ScreenUtil().setHeight(800),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {},
            child: SvgPicture.asset(
              "assets/icons/download.svg",
              height: ScreenUtil().setHeight(80.0),
              color: Colors.black,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PlayingNowPage()),
              );
            },
            child: SvgPicture.asset(
              "assets/icons/play.svg",
              height: ScreenUtil().setHeight(130.0),
              color: Color.fromRGBO(192, 96, 70, 1),
            ),
          ),
          InkWell(
            onTap: () {},
            child: SvgPicture.asset(
              "assets/icons/share.svg",
              height: ScreenUtil().setHeight(80.0),
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget dataContainer() {
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
            SizedBox(height: ScreenUtil().setHeight(100.0)),
            Text(
              '${book.title}',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: ScreenUtil().setSp(70.0),
              ),
            ),
            SizedBox(height: ScreenUtil().setHeight(30.0)),
            actionsContainer(),
            SizedBox(height: ScreenUtil().setHeight(30.0)),
            descriptionText(),
          ],
        ),
      ),
    );
  }

  Widget descriptionText() {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: ScreenUtil().setHeight(50.0)),
          child: Column(
            children: [
              SelectableText(
                "${book.description}",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: ScreenUtil().setSp(50.0),
                ),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
