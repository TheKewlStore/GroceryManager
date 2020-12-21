import 'package:floor/floor.dart';
import 'package:grocery_manager/entities/entities.dart';

@dao
abstract class ListDao {
  @Query("SELECT * FROM GroceryLists")
  Future<List<GroceryListEntity>> getAvailableLists();

  @Query("SELECT * FROM GroceryListLinks WHERE listId = :id")
  Future<List<GroceryListLink>> getLinksForList(int id);

  @Query("SELECT * FROM DinnerLinks WHERE dinnerId = :id")
  Future<List<DinnerLink>> getLinksForDinner(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> insertList(GroceryListEntity list);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<int> updateList(GroceryListEntity list);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertListLinks(List<GroceryListLink> links);
}
