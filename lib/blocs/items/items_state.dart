import 'package:flutter/material.dart';
import 'package:grocery_manager/models/models.dart';

@immutable
abstract class ItemsState {}

class LoadingItemsState extends ItemsState {}

class ViewingItemsState extends ItemsState {
  final List<GroceryItem> availableItems;

  ViewingItemsState(this.availableItems);
}

class CreatingItemState extends ItemsState {}

class DeletingItemState extends ItemsState {
  final GroceryItem item;

  DeletingItemState(this.item);
}

class EditingItemState extends ItemsState {
  final GroceryItem item;

  EditingItemState(this.item);
}
