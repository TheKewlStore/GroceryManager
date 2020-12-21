import 'package:equatable/equatable.dart';
import 'package:grocery_manager/entities/entities.dart';

class GroceryItem extends Equatable {
  final int id;
  final String name;
  final String aisle;
  final double price;
  final bool neededWeekly;

  GroceryItem({this.id, this.name, this.aisle, this.price, this.neededWeekly});

  @override
  List<Object> get props => [id, name, aisle, price, neededWeekly];

  GroceryItemEntity toEntity() {
    return GroceryItemEntity(id: id, name: name, aisle: aisle, price: price, neededWeekly: neededWeekly);
  }

  static GroceryItem fromEntity(GroceryItemEntity entity) {
    return GroceryItem(
      id: entity.id,
      name: entity.name,
      aisle: entity.aisle,
      price: entity.price,
      neededWeekly: entity.neededWeekly,
    );
  }

  GroceryItem copyWith({id, name, aisle, price, neededWeekly}) {
    return GroceryItem(
      id: id ?? this.id,
      name: name ?? this.name,
      aisle: aisle ?? this.aisle,
      price: price ?? this.price,
      neededWeekly: neededWeekly ?? this.neededWeekly,
    );
  }

  String get abbreviatedAisle {
    if (aisle.length > 5) {
      return aisle.substring(0, 5) + "...";
    } else {
      return aisle;
    }
  }
}
