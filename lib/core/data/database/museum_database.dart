// database.dart

// required package imports
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:museo_zuccante/feature/items/data/datasources/items_local_datasource.dart';
import 'package:museo_zuccante/feature/items/data/models/item_local_model.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'museum_database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [
  ItemLocalModel,
])
abstract class AppDatabase extends FloorDatabase {
  ItemsLocalDatasource get itemsDao;
}
