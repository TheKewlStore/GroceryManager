import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:grocery_manager/database/database.dart';
import 'package:grocery_manager/entities/entities.dart';
import 'package:grocery_manager/models/models.dart';

import 'items.dart';

class DinnerRepository {
  final GroceryManagerDatabase database;
  final ItemRepository itemRepository;

  DinnerRepository({@required this.database, @required this.itemRepository});

  Future<List<Dinner>> getAvailableDinners() async {
    return _entitiesToDinners(await database.dinnerDao.getAvailableDinners());
  }

  Future<void> createDinner(Dinner dinner) async {
    List<int> itemIds = dinner.ingredients.map((ingredient) => ingredient.id).toList();
    int dinnerId = await database.dinnerDao.insertDinner(dinner.toEntity());
    List<DinnerLink> links = [];

    for (int itemId in itemIds) {
      links.add(DinnerLink(dinnerId: dinnerId, itemId: itemId));
    }

    await database.dinnerDao.insertDinnerLinks(links);
  }

  Future<List<Dinner>> _entitiesToDinners(List<DinnerEntity> entities) async {
    return Future.wait(entities.map((entity) async {
      List<DinnerLink> links = await database.dinnerDao.getLinksForDinner(entity.id);
      List<int> ids = links.map((link) => link.itemId).toList();
      List<GroceryItem> items = await itemRepository.getItemsByIds(ids);
      return Dinner(id: entity.id, name: entity.name, ingredients: items);
    }));
  }

  Future<void> deleteDinners(List<Dinner> dinners) async {
    return database.dinnerDao.deleteDinners(dinners.map((dinner) => dinner.id).toList());
  }

  Future<void> importDinners(File file) async {
    final input = file.openRead();
    final data = await input.transform(utf8.decoder).transform(CsvToListConverter()).toList();

    for (List<dynamic> row in data.skip(1)) {
      int id = row[0];
      String name = row[1];
      String itemIdString = row[2];
      List<int> itemIDs = itemIdString.split(",").map((id) => int.parse(id));
      List<GroceryItem> items = await itemRepository.getItemsByIds(itemIDs);
      await createDinner(Dinner(id: id, name: name, ingredients: items));
    }
  }
}
