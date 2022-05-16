import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_record/app/record/record_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final recordDatabaseProvider = Provider<RecordDatabase>((ref) {
  return RecordDatabase();
});

class RecordDatabase {
  static Future<Database> get database async {
    final _database = openDatabase(
      join(await getDatabasesPath(), 'costs_database.db'),
      version: 1,
      onCreate: _onCreate,
    );
    print('データーベース作成中');
    print(_database);
    return _database;
  }

  static Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE costs(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        money TEXT,
        category TEXT,
        expenditureDate TEXT,
        createdAt TEXT
      )
    ''');
  }

  Future<void> add(RecordModel record) async {
    final db = await database;
    print(db);
    print(record);
    print(record.toMap());
    await db.insert(
      'costs',
      record.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print('追加後のDB$db');
    // final List<Map<String, dynamic>> maps = await db.query('costs');
    // print('追加後のdb$db');
  }

  Future<List<RecordModel>> records() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('costs');
    final fixedMaps = maps
        .map((record) => RecordModel(
              id: int.parse(record['id'].toString()),
              money: int.parse(record['money'].toString()),
              category: record['category'].toString(),
              expenditureDate:
                  DateTime.parse(record['expenditureDate'].toString())
                      .toLocal(),
              createdAt:
                  DateTime.parse(record['createdAt'].toString()).toLocal(),
            ))
        .toList();
    return fixedMaps;
  }

  Future<int> getrecordIndex() async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db.rawQuery('SELECT LAST_INSERT_ROWID()');
    final recordIndex = int.parse(maps.first.toString().substring(22, 23));
    return recordIndex;
  }

  Future<void> deleterecord(int id) async {
    final db = await database;

    await db.delete(
      'costs',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteTable() async {
    final db = await database;

    await db.execute('DROP TABLE costs;');
    print(db);
    print(db.path);
  }
}
