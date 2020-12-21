import 'package:equatable/equatable.dart';
import 'package:grocery_manager/entities/entities.dart';

import 'items.dart';

class GroceryListItem extends Equatable {
  final int id;
  final GroceryItem item;
  final bool purchased;

  GroceryListItem({this.id, this.item, this.purchased});

  GroceryListItem copyWith({int id, bool purchased}) {
    return GroceryListItem(
      id: id ?? this.id,
      item: this.item,
      purchased: purchased ?? this.purchased,
    );
  }

  GroceryListLink toEntity(int listId) {
    return GroceryListLink(
      id: id,
      listId: listId,
      itemId: itemId,
      purchased: purchased,
    );
  }

  @override
  List<Object> get props => [];

  int get itemId => item.id;
  String get name => item.name;
  String get aisle => item.aisle;
  String get abbreviatedAisle => item.abbreviatedAisle;
  double get price => item.price;
}

class GroceryList extends Equatable {
  final int id;
  final DateTime timeCreated;
  final List<GroceryListItem> items;

  GroceryList({this.id, this.timeCreated, this.items});

  @override
  List<Object> get props => [];

  GroceryListEntity toEntity() {
    return GroceryListEntity(id: this.id, timeCreated: this.timeCreated);
  }

  GroceryList copyWith({id, timeCreated, items}) {
    return GroceryList(
      id: id ?? this.id,
      timeCreated: timeCreated ?? this.timeCreated,
      items: items ?? this.items,
    );
  }

  double totalPrice() {
    double total = 0;

    for (GroceryListItem item in items) {
      total += item.price;
    }

    return total;
  }

  double spentPrice() {
    double total = 0;

    for (GroceryListItem item in items) {
      if (item.purchased) {
        total += item.price;
      }
    }

    return total;
  }
}
