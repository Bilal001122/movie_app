import 'package:sqflite/sqflite.dart';

class DataBase {
  // open database and create table
  static late var databasesPath;
  static late String path;
  static Database? database;

  static Future<void> openDB() async {
    databasesPath = await getDatabasesPath();
    path = '${databasesPath}test15.db';
    database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE FAV ('
          'id INTEGER PRIMARY KEY, name TEXT, title TEXT,'
          ' overview TEXT, poster_path TEXT,'
          ' vote_average TEXT, release_date TEXT, first_air_date TEXT)',
        );
      },
    );
  }

// insert to database

  static Future<void> insertToDB({
    required String? name,
    required String? overview,
    required String? posterPath,
    required String? voteAverage,
    required String? releaseDate,
    required String? firstAirDate,
    required String? title,
  }) async {
    await openDB();
    await database?.transaction((txn) async {
      int id1 = await txn.rawInsert(
        'INSERT INTO FAV(name, title, overview, poster_path,'
        ' vote_average, release_date, first_air_date) VALUES('
        ' "$name","$title", "$overview", "$posterPath",'
        ' "$voteAverage", "$releaseDate", "$firstAirDate")',
      );
    });
  }

// get from database

  static Future<List<Map<String, dynamic>>> getFromDB() async {
    await openDB();
    List<Map<String, dynamic>> list =
        await database!.rawQuery('SELECT * FROM FAV');
    return list;
  }

// delete from database

  static Future<void> deleteFromDB({required String? id}) async {
    await openDB();
    await database?.transaction((txn) async {
      int id1 = await txn.rawDelete('DELETE FROM FAV WHERE name = ?', [id]);
      int id2 = await txn.rawDelete('DELETE FROM FAV WHERE title = ?', [id]);
    });
  }
}
