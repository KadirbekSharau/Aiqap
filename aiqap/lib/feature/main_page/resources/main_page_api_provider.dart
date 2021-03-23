import 'package:aiqap/feature/main_page/model/book.dart';

class MainPageApiProvider {
  Future<List<Genre>> fetchBooksByGenre() async {
    await Future.delayed(Duration(seconds: 2));
    return genresList;
  }
}
