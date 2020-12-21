import 'package:equatable/equatable.dart';
import 'package:grocery_manager/models/models.dart';

abstract class ListState extends Equatable {
  const ListState();

  @override
  List<Object> get props => [];
}

class LoadingLists extends ListState {}

class ShowingAllLists extends ListState {
  final List<GroceryList> availableLists;

  ShowingAllLists(this.availableLists);
}

class ShowingChecklist extends ListState {
  final DateTime timeCreated;
  final List<GroceryItem> itemsToCheck;

  ShowingChecklist({this.itemsToCheck, this.timeCreated});

  @override
  List<Object> get props => [itemsToCheck, timeCreated];
}

class SchedulingDinners extends ListState {
  final List<Dinner> availableDinners;
  final List<GroceryItem> currentItems;
  final DateTime timeCreated;

  SchedulingDinners({this.availableDinners, this.currentItems, this.timeCreated});

  @override
  List<Object> get props => [availableDinners, currentItems, timeCreated];
}

class EditingList extends ListState {
  final List<GroceryItem> availableItems;
  final List<GroceryItem> currentItems;
  final DateTime timeCreated;

  EditingList({this.availableItems, this.currentItems, this.timeCreated});

  @override
  List<Object> get props => [availableItems, currentItems, timeCreated];
}

class ListShopping extends ListState {
  final GroceryList list;

  ListShopping(this.list);
}

class ItemLoadingFailed extends ListState {
  final Error error;

  ItemLoadingFailed({this.error});

  @override
  List<Object> get props => [error];
}
