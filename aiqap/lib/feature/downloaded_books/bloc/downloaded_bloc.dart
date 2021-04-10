import 'package:aiqap/feature/downloaded_books/bloc/downloaded_event.dart';
import 'package:aiqap/feature/downloaded_books/bloc/downloaded_state.dart';
import 'package:aiqap/feature/downloaded_books/resources/downloads_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DownloadsBloc extends Bloc<DownloadsEvent, DownloadsState> {
  DownloadsRepository repository = DownloadsRepository();
  DownloadsBloc() : super(LoadingDownloadsState());

  @override
  Stream<DownloadsState> mapEventToState(DownloadsEvent event) async* {
    if (event is GetDownloadsEvent) {
      var books = await repository.getDownloadedBooks();
      yield FetchedDownloadsState(books);
    }
  }
}
