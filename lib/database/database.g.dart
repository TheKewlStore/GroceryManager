// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorGroceryManagerDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$GroceryManagerDatabaseBuilder databaseBuilder(String name) =>
      _$GroceryManagerDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$GroceryManagerDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$GroceryManagerDatabaseBuilder(null);
}

class _$GroceryManagerDatabaseBuilder {
  _$GroceryManagerDatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

  /// Adds migrations to the builder.
  _$GroceryManagerDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$GroceryManagerDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<GroceryManagerDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name)
        : ':memory:';
    final database = _$GroceryManagerDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$GroceryManagerDatabase extends GroceryManagerDatabase {
  _$GroceryManagerDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ItemDao _itemDaoInstance;

  DinnerDao _dinnerDaoInstance;

  ListDao _listDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `GroceryListItems` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT, `aisle` TEXT, `price` REAL, `neededWeekly` INTEGER)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `GroceryLists` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `timeCreated` INTEGER)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `GroceryListLinks` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `listId` INTEGER, `itemId` INTEGER, `purchased` INTEGER)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Dinners` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `DinnerLinks` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `dinnerId` INTEGER, `itemId` INTEGER)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ItemDao get itemDao {
    return _itemDaoInstance ??= _$ItemDao(database, changeListener);
  }

  @override
  DinnerDao get dinnerDao {
    return _dinnerDaoInstance ??= _$DinnerDao(database, changeListener);
  }

  @override
  ListDao get listDao {
    return _listDaoInstance ??= _$ListDao(database, changeListener);
  }
}

class _$ItemDao extends ItemDao {
  _$ItemDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _groceryItemEntityInsertionAdapter = InsertionAdapter(
            database,
            'GroceryListItems',
            (GroceryItemEntity item) => <String, dynamic>{
                  'id': item.id,
                  'name': item.name,
                  'aisle': item.aisle,
                  'price': item.price,
                  'neededWeekly': item.neededWeekly == null
                      ? null
                      : (item.neededWeekly ? 1 : 0)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<GroceryItemEntity> _groceryItemEntityInsertionAdapter;

  @override
  Future<List<GroceryItemEntity>> getChecklistItems() async {
    return _queryAdapter.queryList(
        'SELECT * FROM GroceryListItems WHERE neededWeekly = true',
        mapper: (Map<String, dynamic> row) => GroceryItemEntity(
            id: row['id'] as int,
            name: row['name'] as String,
            aisle: row['aisle'] as String,
            price: row['price'] as double,
            neededWeekly: row['neededWeekly'] == null
                ? null
                : (row['neededWeekly'] as int) != 0));
  }

  @override
  Future<List<GroceryItemEntity>> getAvailableItems() async {
    return _queryAdapter.queryList('SELECT * FROM GroceryListItems',
        mapper: (Map<String, dynamic> row) => GroceryItemEntity(
            id: row['id'] as int,
            name: row['name'] as String,
            aisle: row['aisle'] as String,
            price: row['price'] as double,
            neededWeekly: row['neededWeekly'] == null
                ? null
                : (row['neededWeekly'] as int) != 0));
  }

  @override
  Future<List<GroceryItemEntity>> getItemsByIds(List<int> ids) async {
    final valueList0 = ids.map((value) => "'$value'").join(', ');
    return _queryAdapter.queryList(
        'SELECT * FROM GroceryListItems WHERE id IN ($valueList0)',
        mapper: (Map<String, dynamic> row) => GroceryItemEntity(
            id: row['id'] as int,
            name: row['name'] as String,
            aisle: row['aisle'] as String,
            price: row['price'] as double,
            neededWeekly: row['neededWeekly'] == null
                ? null
                : (row['neededWeekly'] as int) != 0));
  }

  @override
  Future<GroceryItemEntity> getItem(int id) async {
    return _queryAdapter.query(
        'SELECT * FROM GroceryListItems WHERE id = ? LIMIT 1',
        arguments: <dynamic>[id],
        mapper: (Map<String, dynamic> row) => GroceryItemEntity(
            id: row['id'] as int,
            name: row['name'] as String,
            aisle: row['aisle'] as String,
            price: row['price'] as double,
            neededWeekly: row['neededWeekly'] == null
                ? null
                : (row['neededWeekly'] as int) != 0));
  }

  @override
  Future<void> deleteItems(List<int> ids) async {
    final valueList0 = ids.map((value) => "'$value'").join(', ');
    await _queryAdapter.queryNoReturn(
        'DELETE FROM GroceryListItems WHERE id IN ($valueList0)');
  }

  @override
  Future<int> insertItem(GroceryItemEntity item) {
    return _groceryItemEntityInsertionAdapter.insertAndReturnId(
        item, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertItems(List<GroceryItemEntity> items) {
    return _groceryItemEntityInsertionAdapter.insertListAndReturnIds(
        items, OnConflictStrategy.abort);
  }
}

class _$DinnerDao extends DinnerDao {
  _$DinnerDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _dinnerLinkInsertionAdapter = InsertionAdapter(
            database,
            'DinnerLinks',
            (DinnerLink item) => <String, dynamic>{
                  'id': item.id,
                  'dinnerId': item.dinnerId,
                  'itemId': item.itemId
                }),
        _dinnerEntityInsertionAdapter = InsertionAdapter(
            database,
            'Dinners',
            (DinnerEntity item) =>
                <String, dynamic>{'id': item.id, 'name': item.name});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<DinnerLink> _dinnerLinkInsertionAdapter;

  final InsertionAdapter<DinnerEntity> _dinnerEntityInsertionAdapter;

  @override
  Future<List<DinnerLink>> getLinksForDinner(int id) async {
    return _queryAdapter.queryList(
        'SELECT * FROM DinnerLinks WHERE dinnerId = ?',
        arguments: <dynamic>[id],
        mapper: (Map<String, dynamic> row) => DinnerLink(
            id: row['id'] as int,
            dinnerId: row['dinnerId'] as int,
            itemId: row['itemId'] as int));
  }

  @override
  Future<List<DinnerEntity>> getAvailableDinners() async {
    return _queryAdapter.queryList('SELECT * FROM Dinners',
        mapper: (Map<String, dynamic> row) =>
            DinnerEntity(id: row['id'] as int, name: row['name'] as String));
  }

  @override
  Future<void> deleteDinners(List<int> ids) async {
    final valueList0 = ids.map((value) => "'$value'").join(', ');
    await _queryAdapter
        .queryNoReturn('DELETE FROM Dinners WHERE id in ($valueList0)');
  }

  @override
  Future<void> insertDinnerLinks(List<DinnerLink> links) async {
    await _dinnerLinkInsertionAdapter.insertList(
        links, OnConflictStrategy.abort);
  }

  @override
  Future<int> insertDinner(DinnerEntity dinner) {
    return _dinnerEntityInsertionAdapter.insertAndReturnId(
        dinner, OnConflictStrategy.abort);
  }
}

class _$ListDao extends ListDao {
  _$ListDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _groceryListEntityInsertionAdapter = InsertionAdapter(
            database,
            'GroceryLists',
            (GroceryListEntity item) => <String, dynamic>{
                  'id': item.id,
                  'timeCreated': _dateTimeConverter.encode(item.timeCreated)
                }),
        _groceryListLinkInsertionAdapter = InsertionAdapter(
            database,
            'GroceryListLinks',
            (GroceryListLink item) => <String, dynamic>{
                  'id': item.id,
                  'listId': item.listId,
                  'itemId': item.itemId,
                  'purchased':
                      item.purchased == null ? null : (item.purchased ? 1 : 0)
                }),
        _groceryListEntityUpdateAdapter = UpdateAdapter(
            database,
            'GroceryLists',
            ['id'],
            (GroceryListEntity item) => <String, dynamic>{
                  'id': item.id,
                  'timeCreated': _dateTimeConverter.encode(item.timeCreated)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<GroceryListEntity> _groceryListEntityInsertionAdapter;

  final InsertionAdapter<GroceryListLink> _groceryListLinkInsertionAdapter;

  final UpdateAdapter<GroceryListEntity> _groceryListEntityUpdateAdapter;

  @override
  Future<List<GroceryListEntity>> getAvailableLists() async {
    return _queryAdapter.queryList('SELECT * FROM GroceryLists',
        mapper: (Map<String, dynamic> row) => GroceryListEntity(
            id: row['id'] as int,
            timeCreated: _dateTimeConverter.decode(row['timeCreated'] as int)));
  }

  @override
  Future<List<GroceryListLink>> getLinksForList(int id) async {
    return _queryAdapter.queryList(
        'SELECT * FROM GroceryListLinks WHERE listId = ?',
        arguments: <dynamic>[id],
        mapper: (Map<String, dynamic> row) => GroceryListLink(
            id: row['id'] as int,
            listId: row['listId'] as int,
            itemId: row['itemId'] as int,
            purchased: row['purchased'] == null
                ? null
                : (row['purchased'] as int) != 0));
  }

  @override
  Future<List<DinnerLink>> getLinksForDinner(int id) async {
    return _queryAdapter.queryList(
        'SELECT * FROM DinnerLinks WHERE dinnerId = ?',
        arguments: <dynamic>[id],
        mapper: (Map<String, dynamic> row) => DinnerLink(
            id: row['id'] as int,
            dinnerId: row['dinnerId'] as int,
            itemId: row['itemId'] as int));
  }

  @override
  Future<int> insertList(GroceryListEntity list) {
    return _groceryListEntityInsertionAdapter.insertAndReturnId(
        list, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertListLinks(List<GroceryListLink> links) async {
    await _groceryListLinkInsertionAdapter.insertList(
        links, OnConflictStrategy.replace);
  }

  @override
  Future<int> updateList(GroceryListEntity list) {
    return _groceryListEntityUpdateAdapter.updateAndReturnChangedRows(
        list, OnConflictStrategy.replace);
  }
}

// ignore_for_file: unused_element
final _dateTimeConverter = DateTimeConverter();
