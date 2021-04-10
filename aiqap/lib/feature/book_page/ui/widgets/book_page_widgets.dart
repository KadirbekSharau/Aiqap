import 'dart:ui';

import 'package:aiqap/feature/audioProvider/audio_provider.dart';
import 'package:aiqap/feature/main_page/model/book.dart';
import 'package:aiqap/feature/main_page/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

Widget imageContainer(Book book) {
  return Container(
    decoration: BoxDecoration(boxShadow: [
      BoxShadow(
        color: Colors.black26,
        blurRadius: ScreenUtil().setHeight(30.0),
      ),
    ]),
    child: ClipRRect(
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
            child:
                book.img == null ? placeholderImage() : networkImage(book.img),
          ),
        ),
      ),
    ),
  );
}

Widget actionsContainer(Book book, Function onDownload) {
  return Consumer<AudioProvider>(
    builder: (context, value, child) {
      return Container(
        width: ScreenUtil().setHeight(800),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                onDownload(book);
              },
              child: SvgPicture.asset(
                "assets/icons/download.svg",
                height: ScreenUtil().setHeight(80.0),
                color: Colors.black,
              ),
            ),
            InkWell(
              onTap: () {
                value.initBook(book);
                Navigator.pushNamed(context, "/playing_now");
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
    },
  );
}

Widget descriptionText(Book book) {
  return Expanded(
    child: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setHeight(50.0)),
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
