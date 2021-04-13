import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:aiqap/feature/main_page/model/book.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DownloadsRepository {
  Future<List<Book>> getDownloadedBooks() async {
    List<Book> books = [];
    Directory directory = await getExternalStorageDirectory();
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
    var files = await directory.list(recursive: true, followLinks: false);
    await for (var f in files) {
      int id = 0;
      try {
        id = int.parse(f.toString().split("_")[1].split(".")[0]);
      } catch (e) {
        print(e);
        continue;
      }
      Book b = await getBookDetails(id);
      if (b != null) {
        b.audioFile = File(f.toString());
        books.add(b);
      }
    }

    return books;
  }

  Future<void> saveBookDetails(Book book) async {
    var map = book.getMap();
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setString("book${book.id}", jsonEncode(map));
  }

  Future<void> deleteBook(Book book) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.remove("book${book.id}");
  }

  Future<Book> getBookDetails(int id) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var obj = sp.getString("book$id");
    var js = json.decode(obj);
    return Book.parseJson(js);
  }
}
