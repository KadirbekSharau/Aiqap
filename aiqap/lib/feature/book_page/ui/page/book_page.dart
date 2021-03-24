import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:flutter_svg/svg.dart';

class BookPage extends StatefulWidget {
  final int bookId;
  BookPage({Key key, this.bookId}) : super(key: key);

  @override
  _BookPageState createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/abay_path.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
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
                  ScreenUtil().setHeight(30.0),
                ),
                child: Image.asset(
                  "assets/abay_path.png",
                  fit: BoxFit.cover,
                ),
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
            onTap: () {},
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
            actionsContainer(),
            SizedBox(height: ScreenUtil().setHeight(60.0)),
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
                "'Қаһар' романы – 'Көшпенділер' трилогиясының үшінші кітабы. Роман – қазақ тарихи романистикасының үздік табысы, шоқтығы биік туынды. Қазақ әдебиеті тарихында құбылыс болған ел тағдырын шыншылдықпен бейнелеген халықтық көркем шығарма. Роман авторы – Ілияс Есенберлин.",
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
