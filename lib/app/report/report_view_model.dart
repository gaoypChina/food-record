import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_record/app/record/record_model.dart';
import 'package:food_record/app/record/record_service.dart';
import 'package:food_record/app/report/report_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

final reportViewModelProvider = ChangeNotifierProvider.autoDispose((ref) {
  return ReportViewModel(
    ref.watch(recordServiceProvider),
  );
});

class ReportViewModel extends ChangeNotifier {
  ReportViewModel(this._recordService) {
    print('loadするよ〜〜〜');
    load();
  }

  final RecordService _recordService;
  List<RecordModel> records = [];
  List<ReportModel> reports = [];
  int recordIndex = 0;
  int customIndex = 0;
  DateTime opening = DateTime.now();
  DateTime closing = DateTime.now().add(
    Duration(days: 1),
  );
  static const indexPrefsKey = 'selectedPeriodIndex';
  static const openingPrefsKey = 'customOpening';
  static const closingPrefsKey = 'customClosing';

  Future<void> load() async {
    reports = await fetchWeekRecords();
    records = await getWeekRecords();
    // if (recordIndex == 0) {
    //   opening = DateTime.now().add(
    //     Duration(days: -6),
    //   );
    //   closing = DateTime.now();
    //   print(opening);
    //   print(closing);
    // }
    // customIndex = await getCustomIndex();
    // if (customIndex == 8) {
    //   opening = await getOpeningDate();
    //   closing = await getClosingDate();
    // }
    records.forEach((record) => {
          print(record.id),
          print(record.category),
          print(record.createdAt),
          print(record.expenditureDate),
          print(record.money),
        });
    reports.forEach((report) => {
          print(report.date),
          print(report.expense),
        });
    print('初期リロード$records');
    notifyListeners();
  }

  Future<void> loadMonth() async {
    reports = await fetchMonthRecords();
    records = await getMonthRecords();
    print('リロード$reports');
    print('リロード$records');
    notifyListeners();
  }

  Future<void> loadThreeMonth() async {
    reports = await fetchThreeMonthRecords();
    records = await getThreeMonthRecords();
    print('リロード$reports');
    notifyListeners();
  }

  Future<void> loadCustomPeriod() async {
    reports = await fetchCustomPeriodRecords();
    print('リロード$reports');
    notifyListeners();
  }

  // Future<String> loadCustomPeriod() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   print(prefs);
  //   return prefs.getString(indexPrefsKey);
  //   // reports = await
  // }

  Future<int> getCustomIndex() async {
    final prefs = await SharedPreferences.getInstance();
    final customIndex = prefs.getInt(indexPrefsKey);
    print(customIndex);
    if (customIndex == null) {
      const index = 0;
      return index;
    }
    final index = int.parse(customIndex.toString());
    print('インデックスを取得したよ〜〜〜$index');
    return index;
  }

  Future<DateTime> getOpeningDate() async {
    final prefs = await SharedPreferences.getInstance();
    final index = int.parse(prefs.getInt(openingPrefsKey).toString());
    final opening = DateTime.fromMillisecondsSinceEpoch(index);
    print('openingをDateTimeに$opening');
    return opening;
  }

  Future<DateTime> getClosingDate() async {
    final prefs = await SharedPreferences.getInstance();
    final index = int.parse(prefs.getInt(closingPrefsKey).toString());
    final closing = DateTime.fromMillisecondsSinceEpoch(index);
    print('closingをDateTimeに$closing');
    return closing;
  }

  Future<List<RecordModel>> getWeekRecords() async {
    final records = await _recordService.getWeekRecords();
    print(records);
    return records;
  }

  Future<List<RecordModel>> getMonthRecords() async {
    final records = await _recordService.getMonthRecords();
    print(records);
    return records;
  }

  Future<List<RecordModel>> getThreeMonthRecords() async {
    final records = await _recordService.getThreeMonthRecords();
    print(records);
    return records;
  }

  Future<List<ReportModel>> fetchWeekRecords() async {
    final reports = await _recordService.fetchWeekRecords();
    opening = DateTime.now().add(
      Duration(days: -6),
    );
    closing = DateTime.now();
    print(opening);
    print(closing);
    print('fetchしてるよ〜〜〜$reports');
    return reports;
  }

  Future<List<ReportModel>> fetchMonthRecords() async {
    final monthReports = await _recordService.fetchMonthRecords();
    opening = DateTime.now().add(
      Duration(days: -30),
    );
    closing = DateTime.now();
    print(opening);
    print(closing);
    print('月のレポート表示$monthReports');
    return monthReports;
    // reports = monthReports;
    // notifyListeners();
  }

  Future<List<ReportModel>> fetchThreeMonthRecords() async {
    final threeMonthReports = await _recordService.fetchThreeMonthRecords();
    opening = DateTime.now().add(
      Duration(days: -90),
    );
    closing = DateTime.now();
    print(opening);
    print(closing);
    print('月のレポート表示$threeMonthReports');
    return threeMonthReports;
    // reports = monthReports;
    // notifyListeners();
  }

  Future<List<ReportModel>> fetchCustomPeriodRecords() async {
    // final customOpening = await getOpeningDate();
    // final customClosing = await getClosingDate();
    // opening = customOpening;
    // closing = customClosing;
    // print('オープニング: $opening');
    // print('クロージング: $closing');
    final index = await getCustomIndex();
    if (index == 0) {
      print(index);
      final customOpening = DateTime.now();
      final customClosing = DateTime.now().add(
        Duration(days: 1),
      );
      opening = customOpening;
      closing = customClosing;
      print('オープニング: $opening');
      print('クロージング: $closing');
      final customPeriodReports = await _recordService.fetchCustomPeriodRecords(
        customOpening,
        customClosing,
      );
      return customPeriodReports;
    } else if (index == 1) {
      print(index);
      final customOpening = DateTime.now().add(
        Duration(days: -1),
      );
      final customClosing = DateTime.now();
      opening = customOpening;
      closing = customClosing;
      print('オープニング: $opening');
      print('クロージング: $closing');
      final customPeriodReports = await _recordService.fetchCustomPeriodRecords(
        customOpening,
        customClosing,
      );
      return customPeriodReports;
    } else if (index == 2) {
      print(index);
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
      final monday = isWeekday == 1
          ? today
          : today.add(Duration(days: isWeekday - 1) * -1);
      final sunday = isWeekday == 7 ? today : monday.add(Duration(days: 6));
      opening = monday;
      closing = sunday;
      print('オープニング: $opening');
      print('クロージング: $closing');
      final customPeriodReports = await _recordService.fetchCustomPeriodRecords(
        monday,
        sunday,
      );
      return customPeriodReports;
    } else if (index == 3) {
      print(index);
      final now = DateTime.now();
      final customOpening = DateTime(
        now.year,
        now.month,
        1,
      );

      final customClosing = DateTime(
        now.year,
        now.month + 1,
        1,
      ).add(Duration(days: -1));
      opening = customOpening;
      closing = customClosing;
      print('オープニング: $opening');
      print('クロージング: $closing');
      final customPeriodReports = await _recordService.fetchCustomPeriodRecords(
        customOpening,
        customClosing,
      );
      return customPeriodReports;
    } else if (index == 4) {
      print(index);
      final now = DateTime.now();
      final customOpening = DateTime(
        now.year,
        1,
        1,
      );

      final customClosing = DateTime(
        now.year + 1,
        1,
        1,
      ).add(Duration(days: -1));
      opening = customOpening;
      closing = customClosing;
      print('オープニング: $opening');
      print('クロージング: $closing');
      final customPeriodReports = await _recordService.fetchCustomPeriodRecords(
        customOpening,
        customClosing,
      );
      return customPeriodReports;
    } else if (index == 5) {
      print(index);
      final now = DateTime.now();
      final today = DateTime(
        now.year,
        now.month,
        now.day,
      );
      final customOpening = today.add(Duration(
        days: 180 * -1,
      ));

      final customClosing = today;

      opening = customOpening;
      closing = customClosing;
      print('オープニング: $opening');
      print('クロージング: $closing');
      final customPeriodReports = await _recordService.fetchCustomPeriodRecords(
        customOpening,
        customClosing,
      );
      return customPeriodReports;
    } else if (index == 6) {
      print(index);
      final now = DateTime.now();
      final today = DateTime(
        now.year,
        now.month,
        now.day,
      );
      final customOpening = today.add(Duration(
        days: 365 * -1,
      ));

      final customClosing = today;

      opening = customOpening;
      closing = customClosing;
      print('オープニング: $opening');
      print('クロージング: $closing');
      final customPeriodReports = await _recordService.fetchCustomPeriodRecords(
        customOpening,
        customClosing,
      );
      return customPeriodReports;
    } else if (index == 7) {
      print(index);
      final customPeriodReports = await _recordService.fetchWeekRecords();
      return customPeriodReports;
      // } else if (index == 8) {
    } else {
      print(index);
      final customOpening = await getOpeningDate();
      final customClosing = await getClosingDate();
      opening = customOpening;
      closing = customClosing;
      print('オープニング: $opening');
      print('クロージング: $closing');
      final customPeriodReports = await _recordService.fetchCustomPeriodRecords(
        opening,
        closing,
      );
      return customPeriodReports;
    }
  }

  Future<void> updateIndex(int index) async {
    recordIndex = index;
    print(recordIndex);
    if (index == 0) {
      await load();
    } else if (index == 1) {
      await loadMonth();
    } else if (index == 2) {
      await loadThreeMonth();
    } else if (index == 3) {
      await loadCustomPeriod();
    }
    notifyListeners();
  }
}
