import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:grocery_manager/entities/entities.dart';

@Entity(tableName: "GroceryLists")
class GroceryListEntity extends Equatable {
  @PrimaryKey(autoGenerate: true)
  final int id;
  final DateTime timeCreated;

  GroceryListEntity({this.id, this.timeCreated});

  @override
  List<Object> get props => [id, timeCreated];
}

@Entity(
  tableName: "GroceryListLinks",
  foreignKeys: [
    ForeignKey(
      childColumns: ["listId"],
      parentColumns: ["id"],
      entity: GroceryListEntity,
      onDelete: ForeignKeyAction.cascade,
    ),
    ForeignKey(
      childColumns: ["itemId"],
      parentColumns: ["id"],
      entity: GroceryItemEntity,
      onDelete: ForeignKeyAction.cascade,
    ),
  ],
)
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
