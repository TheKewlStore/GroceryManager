import 'package:equatable/equatable.dart';
import 'package:grocery_manager/date_time_utils.dart';
import 'package:grocery_manager/models/models.dart';

abstract class ListEvent extends Equatable {
  const ListEvent();

  @override
  List<Object> get props => [];
}

class ListsLoaded extends ListEvent {}

class NewListStarted extends ListEvent {
  final DateTime timeCreated;

  const NewListStarted({this.timeCreated});

  @override
  List<Object> get props => [timeCreated];

  @override
  String toString() => "NewGroceryListStarted(dateTime: ${formatDateTime(timeCreated)})";
}

class ChecklistConfirmed extends ListEvent {
  final DateTime timeCreated;
  final List<GroceryItem> itemsChecked;

  const ChecklistConfirmed({this.itemsChecked, this.timeCreated});

  @override
  List<Object> get props => [itemsChecked, timeCreated];

  @override
  String toString() => "ChecklistConfirmed(itemsChecked: $itemsChecked, dateTime: ${formatDateTime(timeCreated)})";
}

class DinnerScheduleConfirmed extends ListEvent {
  final DateTime timeCreated;
  final List<Dinner> dinnersScheduled;
  final List<GroceryItem> currentItems;

  DinnerScheduleConfirmed({this.dinnersScheduled, this.currentItems, this.timeCreated});

  @override
  List<Object> get props => [dinnersScheduled, currentItems];

  @override
  String toString() => "DinnerScheduleConfirmed(dinnersScheduled: $dinnersScheduled, currentItems: $currentItems, dateTime: ${formatDateTime(timeCreated)})";
}

class ListShoppingStarted extends ListEvent {
  final GroceryList list;

  ListShoppingStarted(this.list);
}

class ListShoppingFinished extends ListEvent {
  final GroceryList list;

  ListShoppingFinished(this.list);
}

class ListCancelled extends ListEvent {}

class ListSaved extends ListEvent {
  final DateTime timeCreated;
  final List<GroceryItem> items;

  const ListSaved({this.items, this.timeCreated});

  @override
  List<Object> get props => [items];

  @override
  String toString() => "ListSaved(items: $items, timeCreated: ${formatDateTime(timeCreated)})";
}
