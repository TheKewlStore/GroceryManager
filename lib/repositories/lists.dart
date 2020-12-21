import 'package:flutter/foundation.dart';
import 'package:grocery_manager/database/database.dart';
import 'package:grocery_manager/entities/entities.dart';
import 'package:grocery_manager/models/models.dart';

import 'items.dart';

class ListRepository {
  final GroceryManagerDatabase database;
  final ItemRepository itemRepository;

  ListRepository({@required this.database, @required this.itemRepository});

  Future<List<GroceryList>> getAvailableLists() async {
    return _entitiesToLists(await database.listDao.getAvailableLists());
  }

  Future<void> createList(List<GroceryItem> items, DateTime timeCreated) async {
    List<GroceryListItem> listItems = items.map((item) => GroceryListItem(item: item, purchased: false)).toList();
    GroceryList list = GroceryList(timeCreated: timeCreated, items: listItems);
    int listId = await database.listDao.insertList(list.toEntity());
    List<GroceryListLink> links = [];

    for (GroceryListItem item in list.items) {
      links.add(item.toEntity(listId));
    }

    await database.listDao.insertListLinks(links);
  }

  Future<void> updateList(GroceryList list) async {
    await database.listDao.updateList(list.toEntity());
    await database.listDao.insertListLinks(list.items.map((item) => item.toEntity(list.id)).toList());
  }

  Future<List<GroceryListItem>> _entitiesToListItems(List<GroceryListLink> links) async {
    return Future.wait(
      links.map(
        (link) async {
          GroceryItem item = await itemRepository.getItem(link.itemId);
          return GroceryListItem(
            id: link.id,
            item: item,
            purchased: link.purchased,
          );
        },
      ),
    );
  }

  Future<List<GroceryList>> _entitiesToLists(List<GroceryListEntity> entities) async {
    return Future.wait(
      entities.map(
        (entity) async {
          List<GroceryListLink> links = await database.listDao.getLinksForList(entity.id);
          List<GroceryListItem> items = await _entitiesToListItems(links);

          return GroceryList(
            id: entity.id,
            items: items,
            timeCreated: entity.timeCreated,
          );
        },
      ),
    );
  }
}
