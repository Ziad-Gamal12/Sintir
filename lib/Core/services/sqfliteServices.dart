// ignore_for_file: depend_on_referenced_packages, file_names

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Sqfliteservices {
  static String pathFileName = "data.db";
  static String studentTableName = "Students";
  static String teacherTableName = "Teachers";

  static Database? currentDatabase;

  Future<Database?> get db async {
    if (currentDatabase != null) {
      return currentDatabase;
    } else {
      currentDatabase = await initDB();
      return currentDatabase;
    }
  }

  Future<Database?> initDB() async {
    Database? database;
    String deflutePath = await getDatabasesPath();
    String path = join(deflutePath, pathFileName);
    database = await openDatabase(path, version: 1, onCreate: onCreate);
    return database;
  }

  Future<void> onCreate(Database database, int version) async {
    await database.execute(
        'CREATE TABLE IF NOT EXISTS $studentTableName(id TEXT PRIMARY KEY NOT NULL, firstName TEXT, lastName TEXT, email TEXT, birthDate TEXT, educationLevel TEXT, phoneNumber TEXT, gender TEXT, imageUrl TEXT, schoolName TEXT, kind TEXT)');
    await database.execute(
        'CREATE TABLE IF NOT EXISTS $teacherTableName(id TEXT PRIMARY KEY NOT NULL, address TEXT, firstName TEXT, lastName TEXT, email TEXT, workExperience TEXT, subject TEXT, phoneNumber TEXT, gender TEXT, profilePicurl TEXT, kind TEXT, state TEXT, joinedDate TEXT,socialLinks TEXT )');
  }

  Future<int> insertData({
    required String tableName,
    required Map<String, Object?> data,
  }) async {
    Database? datebase = await db;
    int response = await datebase!.insert(
      tableName,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return response;
  }

  Future<List<Map<String, Object?>>> readData({
    required String tableName,
    required String rawID,
  }) async {
    Database? datebase = await db;
    List<Map<String, Object?>> response = await datebase!.rawQuery(
      "SELECT * FROM '$tableName' WHERE id = '$rawID'",
    );
    return response;
  }

  Future<int> updateData({
    required String tableName,
    required Map<String, dynamic> data,
    required String rawID,
  }) async {
    Database? datebase = await db;
    int response = await datebase!.update(
      tableName,
      data,
      where: rawID,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return response;
  }

  Future<int> deleteData({
    required String tableName,
    required String rawID,
  }) async {
    Database? datebase = await db;
    int response = await datebase!.rawDelete(
      "DELETE FROM $tableName WHERE id = $rawID",
    );
    return response;
  }
}
