import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:museo_zuccante/core/data/exceptions/failures.dart';
import 'package:museo_zuccante/feature/items/domain/model/item_domain_model.dart';
import 'package:museo_zuccante/feature/items/domain/repositories/items_repository.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  ItemsRepository itemsRepository;

  SearchBloc({@required this.itemsRepository}) : super(SearchInitial());

  List<ItemDomainModel> items;

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is SearchItem) {
      yield SearchResultsLoading();

      if (items == null) {
        final itemsLocal = await itemsRepository.getItems();
        items = itemsLocal.getOrElse(() {
          return [];
        });
      } else {
        if (event.query.length >= 2) {
          final results = items
              .where((element) => _showResult(event.query, element))
              .toList();

          print(results);

          yield SearchResultsLoaded(results: results);
        }
      }
    }
  }

  bool _showResult(String query, ItemDomainModel model) {
    return model.title.toLowerCase().contains(query.toLowerCase()) ||
        model.subtitle.toLowerCase().contains(query.toLowerCase()) ||
        model.room.title.toLowerCase().contains(query.toLowerCase());
  }
}
