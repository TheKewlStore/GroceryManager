import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:grocery_manager/models/models.dart';
import 'package:intl/intl.dart';

Widget lookupItemBar(Function(GroceryItem) onGroceryItemAdded, List<GroceryItem> availableItems, List<GroceryItem> currentItems) {
  return TypeAheadField(
    textFieldConfiguration: TextFieldConfiguration(
      decoration: InputDecoration(
        icon: Icon(Icons.add),
        hintText: "Eggs",
        labelText: "Add Item",
      ),
      onSubmitted: (value) {
        onGroceryItemAdded(
          availableItems.firstWhere(
            (element) => element.name == value,
            orElse: () => null,
          ),
        );
      },
    ),
    suggestionsCallback: (pattern) async {
      return availableItems.where((element) => element.name.contains(pattern) && !currentItems.contains(element));
    },
    itemBuilder: (context, GroceryItem suggestion) {
      return ListTile(
        leading: Icon(Icons.shopping_cart),
        title: Text(suggestion.name),
        subtitle: Text(NumberFormat.simpleCurrency().format(suggestion.price)),
      );
    },
    onSuggestionSelected: (GroceryItem suggestion) {
      onGroceryItemAdded(suggestion);
    },
  );
}
