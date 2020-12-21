import 'package:grocery_manager/models/models.dart';

abstract class DinnerState {}

class LoadingDinners extends DinnerState {}

class ViewingAllDinners extends DinnerState {
  final List<Dinner> availableDinners;

  ViewingAllDinners({this.availableDinners});
}

class CreatingDinner extends DinnerState {
  final List<GroceryItem> availableItems;

  CreatingDinner({this.availableItems});
}

class EditingDinner extends DinnerState {
  final Dinner dinner;
  final List<GroceryItem> availableItems;

  EditingDinner({this.dinner, this.availableItems});
}
