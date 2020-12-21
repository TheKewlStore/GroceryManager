import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

@Entity(tableName: "GroceryLists")
class GroceryListEntity extends Equatable {
  @PrimaryKey(autoGenerate: true)
  final int id;
  final DateTime timeCreated;

  GroceryListEntity({this.id, this.timeCreated});

  @override
  List<Object> get props => [id, timeCreated];
}

@Entity(tableName: "GroceryListLinks")
class GroceryListLink extends Equatable {
  @PrimaryKey(autoGenerate: true)
  final int id;
  final int listId;
  final int itemId;
  final bool purchased;

  GroceryListLink({this.id, this.listId, this.itemId, this.purchased});

  @override
  List<Object> get props => [id, listId, itemId, purchased];
}
