import 'package:equatable/equatable.dart';

abstract class MainPageEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchGanresEvent extends MainPageEvent {}

class SearchBookEvent extends MainPageEvent {
  final String hint;

  SearchBookEvent(this.hint);
}
