import 'package:flutter/material.dart';
import 'package:grocery_manager/database/database.dart';
import 'package:grocery_manager/entities/entities.dart';
import 'package:grocery_manager/models/models.dart';

class ItemRepository {
  final GroceryManagerDatabase database;

  ItemRepository({@required this.database});

  Future<List<GroceryItem>> getChecklistItems() async {
    return _entitiesToItems(await database.itemDao.getChecklistItems());
  }

  Future<List<GroceryItem>> getAvailableItems() async {
    return _entitiesToItems(await database.itemDao.getAvailableItems());
  }

  Future<List<GroceryItem>> getItemsByIds(List<int> ids) async {
    return _entitiesToItems(await database.itemDao.getItemsByIds(ids));
  }

  Future<GroceryItem> getItem(int id) async {
    return _entityToItem(await database.itemDao.getItem(id));
  }

  Future<void> createItem(GroceryItem item) async {
    await database.itemDao.insertItem(item.toEntity());
  }

  Future<GroceryItem> _entityToItem(GroceryItemEntity entity) async {
    return GroceryItem.fromEntity(entity);
  }

  Future<List<GroceryItem>> _entitiesToItems(List<GroceryItemEntity> entities) async {
    return entities.map((entity) => GroceryItem.fromEntity(entity)).toList();
  }

  Future<void> deleteItem(GroceryItem item) async {
    return database.itemDao.deleteItems([item.toEntity().id]);
  }

  Future<void> deleteItems(List<GroceryItem> items) async {
    return database.itemDao.deleteItems(items.map((item) => item.toEntity().id).toList());
  }
}
