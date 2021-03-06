import 'package:aiqap/feature/main_page/model/book.dart';
import 'package:aiqap/feature/main_page/resources/main_page_api_provider.dart';

class MainPageRepository {
  MainPageApiProvider _apiProvider = MainPageApiProvider();
  Future<List<Book>> fetchBooksList() async {
    return await _apiProvider.fetchBooksList();
  }
}
