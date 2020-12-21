import 'package:floor/floor.dart';
import 'package:grocery_manager/entities/entities.dart';

@dao
abstract class ItemDao {
  @Query("SELECT * FROM GroceryListItems WHERE neededWeekly = true")
  Future<List<GroceryItemEntity>> getChecklistItems();

  @Query("SELECT * FROM GroceryListItems")
  Future<List<GroceryItemEntity>> getAvailableItems();

  @Query("SELECT * FROM GroceryListItems WHERE id IN (:ids)")
  Future<List<GroceryItemEntity>> getItemsByIds(List<int> ids);

  @Query("SELECT * FROM GroceryListItems WHERE id = :id LIMIT 1")
  Future<GroceryItemEntity> getItem(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> insertItem(GroceryItemEntity item);

  @insert
  Future<List<int>> insertItems(List<GroceryItemEntity> items);

  @Query("DELETE FROM GroceryListItems WHERE id IN (:ids)")
  Future<void> deleteItems(List<int> ids);
}
