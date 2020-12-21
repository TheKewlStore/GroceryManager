import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

@Entity(tableName: "Dinners")
class DinnerEntity extends Equatable {
  @PrimaryKey(autoGenerate: true)
  final int id;
  final String name;

  DinnerEntity({this.id, this.name});

  @override
  List<Object> get props => [id, name];
}

@Entity(tableName: "DinnerLinks")
class DinnerLink extends Equatable {
  @PrimaryKey(autoGenerate: true)
  final int id;
  final int dinnerId;
  final int itemId;

  DinnerLink({this.id, this.dinnerId, this.itemId});

  @override
  List<Object> get props => [id, dinnerId, itemId];
}
