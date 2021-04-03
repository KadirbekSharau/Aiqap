import 'dart:convert';

import 'package:aiqap/config.dart';
import 'package:aiqap/feature/main_page/model/book.dart';
import 'package:http/http.dart';

class MainPageApiProvider {
  Future<List<Book>> fetchBooksList() async {
    var uri = Uri.parse("$BACKEND_URL/api/posts/");
    var response =
        await get(uri, headers: {"Content-Type": "application/json"});
    print(response.statusCode);
    var jsonList = json.decode(utf8.decode(response.bodyBytes));
    return Book.parseList(jsonList['results']);
  }
}
