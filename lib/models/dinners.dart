import 'package:equatable/equatable.dart';
import 'package:grocery_manager/entities/entities.dart';

import 'items.dart';

class Dinner extends Equatable {
  final int id;
  final String name;
  final List<GroceryItem> ingredients;

  Dinner({this.id, this.name, this.ingredients});

  @override
  List<Object> get props => [id, name, ingredients];

  DinnerEntity toEntity() {
    return DinnerEntity(id: id, name: name);
  }

  double price() {
    if (ingredients.isEmpty) {
      return 0;
    }

    return ingredients.map((item) => item.price).reduce((value, element) => value += element);
  }

  String ingredientListSummary() {
    if (ingredients.isEmpty) {
      return "N/A";
    }

    String list;

    if (ingredients.length >= 3) {
      list = ingredients.sublist(0, 3).map((item) => item.name).join(", ");
    } else {
      list = ingredients.map((item) => item.name).join(", ");
    }

    if (list.length > 30) {
      list = list.substring(0, 27) + "...";
    }

    return list;
  }
}
