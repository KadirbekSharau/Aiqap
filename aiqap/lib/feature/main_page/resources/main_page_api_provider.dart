import 'dart:convert';

import 'package:aiqap/config.dart';
import 'package:aiqap/feature/main_page/model/book.dart';
import 'package:http/http.dart';

class MainPageApiProvider {
  Future<List<Book>> fetchBooksList() async {
    var uri = Uri.parse("$BACKEND_URL/http://57d35b8d3f5c.ngrok.io/api/posts/");
    var response = await get(uri);
    var jsonList = json.decode(utf8.decode(response.bodyBytes));
    print(response.statusCode);
    return Book.parseList(jsonList);
  }
}
