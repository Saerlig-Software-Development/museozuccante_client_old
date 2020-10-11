part of 'search_bloc.dart';

abstract class SearchEvent {
  const SearchEvent();
}

class SearchItem extends SearchEvent {
  final String query;

  SearchItem({@required this.query});
}
