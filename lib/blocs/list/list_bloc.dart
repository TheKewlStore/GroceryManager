import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_manager/models/models.dart';
import 'package:grocery_manager/repositories/repository.dart';

import 'list_events.dart';
import 'list_states.dart';

export 'list_events.dart';
export 'list_states.dart';

class ListBloc extends Bloc<ListEvent, ListState> {
  final GroceryManagerRepository repository;

  ListBloc({@required this.repository}) : super(LoadingLists()) {
    add(ListsLoaded());
  }

  @override
  Stream<ListState> mapEventToState(ListEvent event) async* {
    if (event is NewListStarted) {
      yield* _mapNewGroceryListToState(event);
    } else if (event is ChecklistConfirmed) {
      yield* _mapChecklistCompletedToState(event);
    } else if (event is DinnerScheduleConfirmed) {
      yield* _mapDinnerScheduledToState(event);
    } else if (event is ListSaved) {
      yield* _mapListEditingCompletedToState(event);
    } else if (event is ListCancelled) {
      yield* _mapListEditingCancelledToState(event);
    } else if (event is ListsLoaded) {
      yield* _mapGroceryListsLoadedToState(event);
    } else if (event is ListShoppingStarted) {
      yield* _mapShoppingStartedToState(event);
    } else if (event is ListShoppingFinished) {
      yield* _mapShoppingFinishedToState(event);
    }
  }

  Stream<ListState> _mapNewGroceryListToState(NewListStarted event) async* {
    try {
      final checklistItems = await repository.getChecklistItems();
      yield ShowingChecklist(
        itemsToCheck: checklistItems,
        timeCreated: event.timeCreated,
      );
    } catch (error) {
      yield ItemLoadingFailed(error: error);
    }
  }

  Stream<ListState> _mapChecklistCompletedToState(ChecklistConfirmed event) async* {
    try {
      final availableDinners = await repository.getAvailableDinners();
      yield SchedulingDinners(
        availableDinners: availableDinners,
        currentItems: event.itemsChecked,
        timeCreated: event.timeCreated,
      );
    } catch (error) {
      yield ItemLoadingFailed(error: error);
    }
  }

  Stream<ListState> _mapDinnerScheduledToState(DinnerScheduleConfirmed event) async* {
    final availableItems = await repository.getAvailableItems();
    Set<GroceryItem> currentItemSet = event.currentItems.toSet();

    for (Dinner dinner in event.dinnersScheduled) {
      currentItemSet.addAll(dinner.ingredients);
    }

    yield EditingList(
      availableItems: availableItems,
      currentItems: currentItemSet.toList(),
      timeCreated: event.timeCreated,
    );
  }

  Stream<ListState> _mapListEditingCompletedToState(ListSaved event) async* {
    await repository.createList(event.items, event.timeCreated);
    yield ShowingAllLists(await repository.getAvailableLists());
  }

  Stream<ListState> _mapListEditingCancelledToState(ListCancelled event) async* {
    yield ShowingAllLists(await repository.getAvailableLists());
  }

  Stream<ListState> _mapGroceryListsLoadedToState(ListsLoaded event) async* {
    yield ShowingAllLists(await repository.getAvailableLists());
  }

  Stream<ListState> _mapShoppingStartedToState(ListShoppingStarted event) async* {
    yield ListShopping(event.list);
  }

  Stream<ListState> _mapShoppingFinishedToState(ListShoppingFinished event) async* {
    await repository.updateList(event.list);
    yield ShowingAllLists(await repository.getAvailableLists());
  }
}
