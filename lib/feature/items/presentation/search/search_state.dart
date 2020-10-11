part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchResultsLoading extends SearchState {}

class SearchResultsLoaded extends SearchState {
  final List<ItemDomainModel> results;

  SearchResultsLoaded({@required this.results});
}

class SearchResultsFailure extends SearchState {
  final Failure failure;

  SearchResultsFailure({@required this.failure});
}
