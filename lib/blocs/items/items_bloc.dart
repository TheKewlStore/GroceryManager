import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:grocery_manager/repositories/repository.dart';

import 'items_event.dart';
import 'items_state.dart';

export 'items_event.dart';
export 'items_state.dart';

class ItemsBloc extends Bloc<ItemsEvent, ItemsState> {
  final GroceryManagerRepository repository;

  ItemsBloc({this.repository}) : super(LoadingItemsState()) {
    add(ItemsLoaded());
  }

  @override
  Stream<ItemsState> mapEventToState(ItemsEvent event) async* {
    if (event is CreateNewItem) {
      yield* mapCreateNewItem(event);
    } else if (event is EditExistingItem) {
      yield* mapEditExistingItem(event);
    } else if (event is ItemSaved) {
      yield* mapItemSaved(event);
    } else if (event is ItemsDeleted) {
      yield* mapItemDeleted(event);
    } else if (event is ItemsLoaded) {
      yield* mapItemsLoaded(event);
    } else if (event is ItemCancelled) {
      yield* mapItemCancelled(event);
    } else if (event is ItemsImported) {
      yield* mapItemsImported(event);
    }
  }

  Stream<ItemsState> mapCreateNewItem(CreateNewItem event) async* {
    yield CreatingItemState();
  }

  Stream<ItemsState> mapEditExistingItem(EditExistingItem event) async* {
    yield EditingItemState(event.item);
  }

  Stream<ItemsState> mapItemSaved(ItemSaved event) async* {
    await repository.createItem(event.item);
    yield ViewingItemsState(await repository.getAvailableItems());
  }

  Stream<ItemsState> mapItemDeleted(ItemsDeleted event) async* {
    await repository.deleteItems(event.items);
    yield ViewingItemsState(await repository.getAvailableItems());
  }

  Stream<ItemsState> mapItemsLoaded(ItemsLoaded event) async* {
    yield ViewingItemsState(await repository.getAvailableItems());
  }

  Stream<ItemsState> mapItemCancelled(ItemCancelled event) async* {
    yield ViewingItemsState(await repository.getAvailableItems());
  }

  Stream<ItemsState> mapItemsImported(ItemsImported event) async* {
    await repository.importItems(event.file);
    yield ViewingItemsState(await repository.getAvailableItems());
  }
}
