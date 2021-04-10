import 'package:equatable/equatable.dart';

abstract class DownloadsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetDownloadsEvent extends DownloadsEvent {}
