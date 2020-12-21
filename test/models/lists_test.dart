import 'package:flutter_test/flutter_test.dart';
import 'package:grocery_manager/models/models.dart';

void main() {
  group("GroceryListItem model tests", () {
    test("Ensure the copyWith function works", () {
      GroceryItem bread = GroceryItem(id: 1, name: "Bread", price: 2.99, neededWeekly: true);
      GroceryListItem listItem = GroceryListItem(id: 1, item: bread, purchased: false);
      GroceryListItem changedBoth = listItem.copyWith(id: 2, purchased: true);
      GroceryListItem changedId = listItem.copyWith(id: 3);
      GroceryListItem changedPurchased = listItem.copyWith(purchased: true);

      // Verify no side effects.
      expect(listItem.id, 1);
      expect(listItem.item, bread);
      expect(listItem.purchased, false);

      // Verify copy with both worked properly.
      expect(changedBoth.id, 2);
      expect(changedBoth.item, bread);
      expect(changedBoth.purchased, true);

      // Verify copy with id worked properly.
      expect(changedId.id, 3);
      expect(changedId.item, bread);
      expect(changedId.purchased, false);

      // Verify copy with purchased worked properly.
      expect(changedPurchased.id, 1);
      expect(changedPurchased.item, bread);
      expect(changedPurchased.purchased, true);
    });
  });
}
