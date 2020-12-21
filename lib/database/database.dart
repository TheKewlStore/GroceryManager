// ignore: unused_import
import 'dart:async';

import 'package:floor/floor.dart';
import 'package:grocery_manager/daos/daos.dart';
import 'package:grocery_manager/database/converters.dart';
import 'package:grocery_manager/entities/entities.dart';
// ignore: unused_import
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart';

@TypeConverters([DateTimeConverter])
@Database(version: 1, entities: [GroceryItemEntity, GroceryListEntity, GroceryListLink, DinnerEntity, DinnerLink])
abstract class GroceryManagerDatabase extends FloorDatabase {
  ItemDao get itemDao;
  DinnerDao get dinnerDao;
  ListDao get listDao;
}
