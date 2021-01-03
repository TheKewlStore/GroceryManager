import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_manager/repositories/repository.dart';

import 'dinners_event.dart';
import 'dinners_state.dart';

export 'dinners_event.dart';
export 'dinners_state.dart';

class DinnersBloc extends Bloc<DinnerEvent, DinnerState> {
  final GroceryManagerRepository repository;

  DinnersBloc({@required this.repository}) : super(LoadingDinners()) {
    add(DinnersLoaded());
  }

  @override
  Stream<DinnerState> mapEventToState(DinnerEvent event) async* {
    if (event is DinnersLoaded) {
      yield* mapDinnersLoadedState(event);
    } else if (event is NewDinnerStarted) {
      yield* mapNewDinnerStartedState(event);
    } else if (event is EditingDinnerStarted) {
      yield* mapEditingDinnerStartedState(event);
    } else if (event is DinnerSaved) {
      yield* mapDinnerSavedState(event);
    } else if (event is DinnerCancelled) {
      yield* mapDinnerCancelledState(event);
    } else if (event is DinnersDeleted) {
      yield* mapDinnerDeletedState(event);
    } else if (event is DinnersImported) {
      yield* mapDinnersImportedState(event);
    }
  }

  Stream<DinnerState> mapDinnersLoadedState(DinnersLoaded event) async* {
    yield ViewingAllDinners(availableDinners: await repository.getAvailableDinners());
  }

  Stream<DinnerState> mapNewDinnerStartedState(NewDinnerStarted event) async* {
    yield CreatingDinner(availableItems: await repository.getAvailableItems());
  }

  Stream<DinnerState> mapEditingDinnerStartedState(EditingDinnerStarted event) async* {
    yield EditingDinner(dinner: event.dinner, availableItems: await repository.getAvailableItems());
  }

  Stream<DinnerState> mapDinnerSavedState(DinnerSaved event) async* {
    await repository.createDinner(event.dinner);
    yield ViewingAllDinners(availableDinners: await repository.getAvailableDinners());
  }

  Stream<DinnerState> mapDinnerCancelledState(DinnerCancelled event) async* {
    yield ViewingAllDinners(availableDinners: await repository.getAvailableDinners());
  }

  Stream<DinnerState> mapDinnerDeletedState(DinnersDeleted event) async* {
    await repository.deleteDinners(event.dinners);
    yield ViewingAllDinners(availableDinners: await repository.getAvailableDinners());
  }

  Stream<DinnerState> mapDinnersImportedState(DinnersImported event) async* {
    yield ViewingAllDinners(availableDinners: await repository.getAvailableDinners());
  }
}
