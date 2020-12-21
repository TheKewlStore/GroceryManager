import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

@Entity(tableName: "GroceryListItems")
class GroceryItemEntity extends Equatable {
  @PrimaryKey(autoGenerate: true)
  final int id;
  final String name;
  final String aisle;
  final double price;
  final bool neededWeekly;

  GroceryItemEntity({this.id, this.name, this.aisle, this.price, this.neededWeekly});

  @override
  List<Object> get props => [id, name, aisle, price, neededWeekly];
}
