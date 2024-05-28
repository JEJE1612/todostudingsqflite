import 'dart:io';
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/cubit/database_state.dart';
import 'package:path/path.dart';

class DatabaseBloc extends Cubit<DatabaseState> {
  DatabaseBloc() : super(InitDatabaseState());
  Database? database;
  Future<void> initDatabase() async {
    final databasePath = await getDatabasesPath();

    final path = join(databasePath, 'todo.db');
    if (await Directory(dirname(path)).exists()) {
      
        await Directory(dirname(path)).create(recursive: true);
        database = await openDatabase(path, version: 1,
            onCreate: (Database db, int version) async {
          await db.execute(
              'CREATE TABLE todoapp (id INTEGER PRIMARY KEY, name TEXT)');
        });
        emit(LoadDatabaseState());
     // await deleteDatabase(path);
    } else {
      try {
        await Directory(dirname(path)).create(recursive: true);
        database = await openDatabase(path, version: 1,
            onCreate: (Database db, int version) async {
          await db.execute(
              'CREATE TABLE todoapp (id INTEGER PRIMARY KEY, name TEXT)');
        });
        emit(LoadDatabaseState());
      } catch (e) {
        log(e as double);
        print(e);
      }
    }
  }
}
