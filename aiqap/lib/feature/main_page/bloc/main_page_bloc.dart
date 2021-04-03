import 'package:aiqap/feature/main_page/bloc/main_page_event.dart';
import 'package:aiqap/feature/main_page/bloc/main_page_state.dart';
import 'package:aiqap/feature/main_page/resources/main_page_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPageBloc extends Bloc<MainPageEvent, MainPageState> {
  MainPageBloc() : super(LoadingMainPageState());
  MainPageRepository _repository = MainPageRepository();

  @override
  Stream<MainPageState> mapEventToState(MainPageEvent event) async* {
    if (event is FetchGanresEvent) {
      yield LoadingMainPageState();
      try {
        var books = await _repository.fetchBooksList();
        yield FetchedBooksByGanreState(books);
      } catch (e) {
        yield ErrorMainPageState(e.toString());
      }
    }

    if (event is SearchBookEvent) {
      yield LoadingMainPageState();
      try {
        var books = await _repository.fetchBooksList();
        yield FetchedBooksByGanreState(books);
      } catch (e) {
        yield ErrorMainPageState(e.toString());
      }
    }
  }
}
