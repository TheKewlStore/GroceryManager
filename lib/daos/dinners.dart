import 'package:floor/floor.dart';
import 'package:grocery_manager/entities/entities.dart';

@dao
abstract class DinnerDao {
  @Query("SELECT * FROM DinnerLinks WHERE dinnerId = :id")
  Future<List<DinnerLink>> getLinksForDinner(int id);

  @Query("SELECT * FROM Dinners")
  Future<List<DinnerEntity>> getAvailableDinners();

  @insert
  Future<void> insertDinnerLinks(List<DinnerLink> links);

  @insert
  Future<int> insertDinner(DinnerEntity dinner);

  @Query("DELETE FROM Dinners WHERE id in (:ids)")
  Future<void> deleteDinners(List<int> ids);
}
