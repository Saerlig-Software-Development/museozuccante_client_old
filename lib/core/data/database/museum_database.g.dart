// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'museum_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ItemsLocalDatasource _itemsDaoInstance;

  RoomsLocalDatasource _roomsDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `items` (`id` TEXT, `title` TEXT, `subtitle` TEXT, `poster` TEXT, `body` TEXT, `highlighted` INTEGER, `room_id` TEXT, `room_title` TEXT, `room_floor` INTEGER, `room_number` INTEGER, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `rooms` (`id` TEXT, `title` TEXT, `floor` INTEGER, `number` INTEGER, `offset_x` REAL, `offset_y` REAL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ItemsLocalDatasource get itemsDao {
    return _itemsDaoInstance ??=
        _$ItemsLocalDatasource(database, changeListener);
  }

  @override
  RoomsLocalDatasource get roomsDao {
    return _roomsDaoInstance ??=
        _$RoomsLocalDatasource(database, changeListener);
  }
}

class _$ItemsLocalDatasource extends ItemsLocalDatasource {
  _$ItemsLocalDatasource(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _itemLocalModelInsertionAdapter = InsertionAdapter(
            database,
            'items',
            (ItemLocalModel item) => <String, dynamic>{
                  'id': item.id,
                  'title': item.title,
                  'subtitle': item.subtitle,
                  'poster': item.poster,
                  'body': item.body,
                  'highlighted': item.highlighted == null
                      ? null
                      : (item.highlighted ? 1 : 0),
                  'room_id': item.roomId,
                  'room_title': item.roomTitle,
                  'room_floor': item.roomFloor,
                  'room_number': item.roomNumber
                },
            changeListener),
        _itemLocalModelDeletionAdapter = DeletionAdapter(
            database,
            'items',
            ['id'],
            (ItemLocalModel item) => <String, dynamic>{
                  'id': item.id,
                  'title': item.title,
                  'subtitle': item.subtitle,
                  'poster': item.poster,
                  'body': item.body,
                  'highlighted': item.highlighted == null
                      ? null
                      : (item.highlighted ? 1 : 0),
                  'room_id': item.roomId,
                  'room_title': item.roomTitle,
                  'room_floor': item.roomFloor,
                  'room_number': item.roomNumber
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ItemLocalModel> _itemLocalModelInsertionAdapter;

  final DeletionAdapter<ItemLocalModel> _itemLocalModelDeletionAdapter;

  @override
  Future<List<ItemLocalModel>> getItems() async {
    return _queryAdapter.queryList('SELECT * FROM items',
        mapper: (Map<String, dynamic> row) => ItemLocalModel(
            id: row['id'] as String,
            title: row['title'] as String,
            subtitle: row['subtitle'] as String,
            poster: row['poster'] as String,
            body: row['body'] as String,
            roomId: row['room_id'] as String,
            roomTitle: row['room_title'] as String,
            roomFloor: row['room_floor'] as int,
            roomNumber: row['room_number'] as int,
            highlighted: row['highlighted'] == null
                ? null
                : (row['highlighted'] as int) != 0));
  }

  @override
  Future<ItemLocalModel> findItemById(String id) async {
    return _queryAdapter.query('SELECT * FROM items WHERE id = ?',
        arguments: <dynamic>[id],
        mapper: (Map<String, dynamic> row) => ItemLocalModel(
            id: row['id'] as String,
            title: row['title'] as String,
            subtitle: row['subtitle'] as String,
            poster: row['poster'] as String,
            body: row['body'] as String,
            roomId: row['room_id'] as String,
            roomTitle: row['room_title'] as String,
            roomFloor: row['room_floor'] as int,
            roomNumber: row['room_number'] as int,
            highlighted: row['highlighted'] == null
                ? null
                : (row['highlighted'] as int) != 0));
  }

  @override
  Future<List<ItemLocalModel>> getRoomItems(String roomId) async {
    return _queryAdapter.queryList('SELECT * FROM items WHERE room_id = ?',
        arguments: <dynamic>[roomId],
        mapper: (Map<String, dynamic> row) => ItemLocalModel(
            id: row['id'] as String,
            title: row['title'] as String,
            subtitle: row['subtitle'] as String,
            poster: row['poster'] as String,
            body: row['body'] as String,
            roomId: row['room_id'] as String,
            roomTitle: row['room_title'] as String,
            roomFloor: row['room_floor'] as int,
            roomNumber: row['room_number'] as int,
            highlighted: row['highlighted'] == null
                ? null
                : (row['highlighted'] as int) != 0));
  }

  @override
  Stream<List<ItemLocalModel>> watchAllItems() {
    return _queryAdapter.queryListStream('SELECT * FROM items',
        queryableName: 'items',
        isView: false,
        mapper: (Map<String, dynamic> row) => ItemLocalModel(
            id: row['id'] as String,
            title: row['title'] as String,
            subtitle: row['subtitle'] as String,
            poster: row['poster'] as String,
            body: row['body'] as String,
            roomId: row['room_id'] as String,
            roomTitle: row['room_title'] as String,
            roomFloor: row['room_floor'] as int,
            roomNumber: row['room_number'] as int,
            highlighted: row['highlighted'] == null
                ? null
                : (row['highlighted'] as int) != 0));
  }

  @override
  Future<void> deleteAllItems() async {
    await _queryAdapter.queryNoReturn('DELETE FROM items');
  }

  @override
  Future<void> bookmarkItem(String id) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE items SET bookmarked=1 WHERE id=?',
        arguments: <dynamic>[id]);
  }

  @override
  Future<void> insertItem(ItemLocalModel item) async {
    await _itemLocalModelInsertionAdapter.insert(
        item, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertItems(List<ItemLocalModel> items) {
    return _itemLocalModelInsertionAdapter.insertListAndReturnIds(
        items, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteItems(List<ItemLocalModel> items) async {
    await _itemLocalModelDeletionAdapter.deleteList(items);
  }
}

class _$RoomsLocalDatasource extends RoomsLocalDatasource {
  _$RoomsLocalDatasource(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _roomLocalModelInsertionAdapter = InsertionAdapter(
            database,
            'rooms',
            (RoomLocalModel item) => <String, dynamic>{
                  'id': item.id,
                  'title': item.title,
                  'floor': item.floor,
                  'number': item.number,
                  'offset_x': item.offsetX,
                  'offset_y': item.offsetY
                },
            changeListener),
        _roomLocalModelDeletionAdapter = DeletionAdapter(
            database,
            'rooms',
            ['id'],
            (RoomLocalModel item) => <String, dynamic>{
                  'id': item.id,
                  'title': item.title,
                  'floor': item.floor,
                  'number': item.number,
                  'offset_x': item.offsetX,
                  'offset_y': item.offsetY
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<RoomLocalModel> _roomLocalModelInsertionAdapter;

  final DeletionAdapter<RoomLocalModel> _roomLocalModelDeletionAdapter;

  @override
  Future<List<RoomLocalModel>> getRooms() async {
    return _queryAdapter.queryList('SELECT * FROM rooms',
        mapper: (Map<String, dynamic> row) => RoomLocalModel(
            id: row['id'] as String,
            title: row['title'] as String,
            floor: row['floor'] as int,
            number: row['number'] as int,
            offsetX: row['offset_x'] as double,
            offsetY: row['offset_y'] as double));
  }

  @override
  Future<RoomLocalModel> findRoomById(String id) async {
    return _queryAdapter.query('SELECT * FROM rooms WHERE id = ?',
        arguments: <dynamic>[id],
        mapper: (Map<String, dynamic> row) => RoomLocalModel(
            id: row['id'] as String,
            title: row['title'] as String,
            floor: row['floor'] as int,
            number: row['number'] as int,
            offsetX: row['offset_x'] as double,
            offsetY: row['offset_y'] as double));
  }

  @override
  Stream<List<RoomLocalModel>> watchRooms() {
    return _queryAdapter.queryListStream('SELECT * FROM rooms',
        queryableName: 'rooms',
        isView: false,
        mapper: (Map<String, dynamic> row) => RoomLocalModel(
            id: row['id'] as String,
            title: row['title'] as String,
            floor: row['floor'] as int,
            number: row['number'] as int,
            offsetX: row['offset_x'] as double,
            offsetY: row['offset_y'] as double));
  }

  @override
  Future<void> deleteAllRooms() async {
    await _queryAdapter.queryNoReturn('DELETE FROM rooms');
  }

  @override
  Future<void> insertRoom(RoomLocalModel room) async {
    await _roomLocalModelInsertionAdapter.insert(
        room, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertRooms(List<RoomLocalModel> rooms) {
    return _roomLocalModelInsertionAdapter.insertListAndReturnIds(
        rooms, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteRooms(List<RoomLocalModel> rooms) async {
    await _roomLocalModelDeletionAdapter.deleteList(rooms);
  }
}
