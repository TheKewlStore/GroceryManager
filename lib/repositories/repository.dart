import 'dart:io';

import 'package:flutter/material.dart';
import 'package:grocery_manager/database/database.dart';
import 'package:grocery_manager/models/models.dart';
import 'package:grocery_manager/repositories/dinners.dart';
import 'package:grocery_manager/repositories/items.dart';
import 'package:grocery_manager/repositories/lists.dart';

class GroceryManagerRepository {
  final GroceryManagerDatabase database;
  ItemRepository itemRepository;
  ListRepository listRepository;
  DinnerRepository dinnerRepository;

  GroceryManagerRepository({@required this.database}) {
    itemRepository = ItemRepository(database: database);
    listRepository = ListRepository(database: database, itemRepository: itemRepository);
    dinnerRepository = DinnerRepository(database: database, itemRepository: itemRepository);
  }

  Future<List<GroceryItem>> getChecklistItems() async {
    return itemRepository.getChecklistItems();
  }

  Future<List<GroceryItem>> getAvailableItems() async {
    return itemRepository.getAvailableItems();
  }

  Future<List<GroceryItem>> getItemsByIds(List<int> ids) async {
    return itemRepository.getItemsByIds(ids);
  }

  Future<void> createItem(GroceryItem item) async {
    return itemRepository.createItem(item);
  }

  Future<void> deleteItem(GroceryItem item) async {
    return itemRepository.deleteItem(item);
  }

  Future<void> deleteItems(List<GroceryItem> items) async {
    return itemRepository.deleteItems(items);
  }

  Future<void> importItems(File file) async {
    return itemRepository.importItems(file);
  }

  Future<List<GroceryList>> getAvailableLists() async {
    return listRepository.getAvailableLists();
  }

  Future<void> createList(List<GroceryItem> items, DateTime timeCreated) async {
    return listRepository.createList(items, timeCreated);
  }

  Future<void> updateList(GroceryList list) async {
    return listRepository.updateList(list);
  }

  Future<List<Dinner>> getAvailableDinners() async {
    return dinnerRepository.getAvailableDinners();
  }

  Future<void> createDinner(Dinner dinner) async {
    return dinnerRepository.createDinner(dinner);
  }

  Future<void> deleteDinners(List<Dinner> dinners) async {
    return dinnerRepository.deleteDinners(dinners);
  }
}
