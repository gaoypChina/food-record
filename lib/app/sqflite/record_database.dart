import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_record/app/record/record_model.dart';
import 'package:food_record/app/report/report_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final recordDatabaseProvider = Provider<RecordDatabase>((ref) {
  return RecordDatabase();
});

class RecordDatabase {
  static Future<Database> get database async {
    final _database = openDatabase(
      join(await getDatabasesPath(), 'expenses_database.db'),
      version: 1,
      onCreate: _onCreate,
    );
    print('データーベース作成中');
    print(_database);
    return _database;
  }

  static Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE expenses(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        money TEXT,
        category TEXT,
        expenditureDate INTEGER,
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
      'expenses',
      record.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print('追加後のDB$db');
    // final List<Map<String, dynamic>> maps = await db.query('expenses');
    // print('追加後のdb$db');
  }

  Future<List<RecordModel>> records() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('expenses');
    print(db);
    final test = DateTime.fromMicrosecondsSinceEpoch(
      int.parse(maps[0]['expenditureDate'].toString()),
    );
    // final test = maps[0]['expenditureDate'].toString();
    // DateTime.parse(maps[0]['expenditureDate'].toString()).toLocal();
    print('支出日をparse$test');
    final fixedMaps = maps
        .map((record) => RecordModel(
              id: int.parse(record['id'].toString()),
              money: int.parse(record['money'].toString()),
              category: record['category'].toString(),
              expenditureDate: DateTime.fromMicrosecondsSinceEpoch(
                int.parse(record['expenditureDate'].toString()),
              ),
              createdAt: DateTime.fromMicrosecondsSinceEpoch(
                int.parse(record['createdAt'].toString()),
              ),
            ))
        .toList();
    return fixedMaps;
  }

  Future<List<ReportModel>> getWeekRecords() async {
    final db = await database;
    final now = DateTime.now();
    final today = DateTime(
      now.year,
      now.month,
      now.day,
    );
    final isWeekday = DateTime(
      now.year,
      now.month,
      now.day,
    ).weekday;
    print(today);
    final monday =
        isWeekday == 1 ? today : today.add(Duration(days: isWeekday - 1) * -1);
    final sunday =
        isWeekday == 7 ? today : today.add(Duration(days: isWeekday - 1) * 1);
    print(monday);
    print(monday.microsecondsSinceEpoch);
    print(sunday);
    print(sunday.microsecondsSinceEpoch);
    print('これ何曜日？${monday.weekday}');
    final formattedMonday = monday.microsecondsSinceEpoch.toString();
    final formattedSunday = sunday.microsecondsSinceEpoch.toString();
    // final mondayRawQuery = 'select * from expenses order by expenditureDate';
    final mondayRawQuery =
        'select expenditureDate, sum(money) from expenses where expenditureDate between $formattedMonday and $formattedSunday group by expenditureDate';
    // final mondayRawQuery =
    //     'select money, expenditureDate, sum(money), count(*) from expenses where expenditureDate between $formattedMonday and $formattedSunday group by expenditureDate';
    // final mondayRawQuery =
    //     'select * from expenses where expenditureDate between $formattedMonday and $formattedSunday order by expenditureDate';
    // final sundayRawQuery =
    //     'select * from expenses where expenditureDate = $formattedSunday';
    // final mondayRawQuery =
    //     'select * from expenses where expenditureDate = $formattedMonday';
    // final mondayRawQuery =
    //     'select expenditureDate, typeof(expenditureDate), createdAt, typeof(createdAt) from expenses';
    final List<Map<String, dynamic>> maps = await db.rawQuery(mondayRawQuery);
    // final List<Map<String, dynamic>> maps =
    //     await db.rawQuery('select * from expenses limit 3 offset 1;');
    print(maps);
    print(maps[0]['expenditureDate'].toString());
    print(maps[0]['sum(money)'].toString());
    final fixedMaps = maps
        .map(
          (record) => ReportModel(
            expense: double.parse(record['sum(money)'].toString()),
            date: DateTime.fromMicrosecondsSinceEpoch(
              int.parse(record['expenditureDate'].toString()),
            ),
            // id: int.parse(record['id'].toString()),
            // money: int.parse(record['money'].toString()),
            // category: record['category'].toString(),
            // expenditureDate: DateTime.fromMicrosecondsSinceEpoch(
            // int.parse(record['expenditureDate'].toString()),
            // ),
            // createdAt: DateTime.fromMicrosecondsSinceEpoch(
            //   int.parse(record['createdAt'].toString()),
          ),
        )
        .toList();
    print('object');
    print(fixedMaps);
    return fixedMaps;
  }

  Future<List<ReportModel>> getMonthReports() async {
    final db = await database;
    final now = DateTime.now();
    final first = DateTime(
      now.year,
      now.month,
      1,
    );
    print('月の初日$first');
    final end = DateTime(
      now.year,
      now.month + 1,
      1,
    ).add(Duration(days: -1));
    print('月の末日$end');

    final isWeekday = DateTime(
      now.year,
      now.month,
      now.day,
    ).weekday;

    final formattedMonthFirst = first.microsecondsSinceEpoch.toString();
    final formattedMonthEnd = end.microsecondsSinceEpoch.toString();
    final monthRawQuery =
        'select expenditureDate, sum(money) from expenses where expenditureDate between $formattedMonthFirst and $formattedMonthEnd group by expenditureDate';
    final List<Map<String, dynamic>> maps = await db.rawQuery(monthRawQuery);
    print(maps);
    print(maps[0]['expenditureDate'].toString());
    print(maps[0]['sum(money)'].toString());
    final fixedMaps = maps
        .map(
          (record) => ReportModel(
            expense: double.parse(record['sum(money)'].toString()),
            date: DateTime.fromMicrosecondsSinceEpoch(
              int.parse(record['expenditureDate'].toString()),
            ),
          ),
        )
        .toList();
    print('object');
    print(fixedMaps);
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
      'expenses',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteTable() async {
    final db = await database;

    await db.execute('DROP TABLE expenses;');
    print(db);
    print(db.path);
  }
}
