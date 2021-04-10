import 'package:aiqap/feature/main_page/model/book.dart';
import 'package:equatable/equatable.dart';

abstract class DownloadsState extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchedDownloadsState extends DownloadsState {
  final List<Book> books;

  FetchedDownloadsState(this.books);
}

class LoadingDownloadsState extends DownloadsState {}

class ErrorDownloadedState extends DownloadsState {
  final String err;

  ErrorDownloadedState(this.err);
}
