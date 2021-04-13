import 'dart:io';

import 'package:aiqap/feature/main_page/model/author.dart';
import 'package:aiqap/feature/main_page/model/category.dart';

class Book {
  final int id;
  final Author author;
  final String title;
  final String description;
  String audio;
  final String img;
  final String release;
  final String upload;
  final Category category;
  File audioFile;

  Book(this.id, this.author, this.title, this.description, this.audio, this.img,
      this.release, this.upload, this.category);

  factory Book.parseJson(json) {
    return Book(
      json['id'],
      Author.parseJson(json['author']),
      json['title'],
      json['description'],
      json['audio'],
      json['image'],
      json['release'],
      json['upload'],
      Category.parseJson(json['category']),
    );
  }

  static List<Book> parseList(json) {
    List<Book> list = [];
    for (var obj in json) {
      list.add(Book.parseJson(obj));
    }
    return list;
  }

  Object getMap() {
    return {
      "id": id,
      "author": {
        "id": author.id,
        "full_name": author.fullName,
        "birth_date": author.birthDate,
      },
      "title": title,
      "description": description,
      "audio": audio,
      "image": img,
      "release": release,
      "upload": upload,
      "category": {
        "id": category.id,
        "name": category.name,
        "created": category.createdDate,
      }
    };
  }
}
