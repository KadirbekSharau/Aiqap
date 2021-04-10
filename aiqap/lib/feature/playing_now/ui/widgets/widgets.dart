import 'package:aiqap/feature/main_page/model/author.dart';
import 'package:aiqap/feature/main_page/model/book.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget authorText(Author author) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        '${author.fullName}',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black38,
          fontSize: ScreenUtil().setSp(45.0),
          fontWeight: FontWeight.w500,
        ),
      ),
    ],
  );
}

Widget titleText(Book book) {
  return Text(
    "${book.title}",
    style: TextStyle(
      fontSize: ScreenUtil().setSp(55.0),
      fontWeight: FontWeight.w700,
    ),
  );
}
