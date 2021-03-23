import 'package:aiqap/feature/main_page/model/book.dart';
import 'package:equatable/equatable.dart';

abstract class MainPageState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadingMainPageState extends MainPageState {}

class ErrorMainPageState extends MainPageState {
  final String error;

  ErrorMainPageState(this.error);
}

class FetchedBooksByGanreState extends MainPageState {
  final List<Genre> ganres;

  FetchedBooksByGanreState(this.ganres);
}
