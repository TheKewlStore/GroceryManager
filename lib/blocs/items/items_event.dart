import 'package:flutter/material.dart';
import 'package:grocery_manager/models/models.dart';

@immutable
abstract class ItemsEvent {}

class ItemsLoaded extends ItemsEvent {}

class CreateNewItem extends ItemsEvent {}

class EditExistingItem extends ItemsEvent {
  final GroceryItem item;

  EditExistingItem(this.item);
}

class ItemSaved extends ItemsEvent {
  final GroceryItem item;

  ItemSaved(this.item);
}

class ItemsDeleted extends ItemsEvent {
  final List<GroceryItem> items;

  ItemsDeleted({this.items});
}

class ItemCancelled extends ItemsEvent {}
