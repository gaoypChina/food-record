import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_record/app/record/record_model.dart';
import 'package:food_record/app/record/record_service.dart';
import 'package:food_record/app/report/report_model.dart';

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
  List<ReportModel> reports = [];
  int recordIndex = 0;

  Future<void> load() async {
    reports = await fetchWeekRecords();
    reports.forEach((report) => {
          print(report.date),
          print(report.expense),
        });
    print('初期リロード$reports');
    notifyListeners();
  }

  Future<void> loadMonth() async {
    reports = await fetchMonthRecords();
    print('リロード$reports');
    notifyListeners();
  }

  Future<void> loadThreeMonth() async {
    reports = await fetchThreeMonthRecords();
    print('リロード$reports');
    notifyListeners();
  }

  Future<List<ReportModel>> fetchWeekRecords() async {
    final reports = await _recordService.fetchWeekRecords();
    print('fetchしてるよ〜〜〜$reports');
    return reports;
  }

  Future<List<ReportModel>> fetchMonthRecords() async {
    final monthReports = await _recordService.fetchMonthRecords();
    print('月のレポート表示$monthReports');
    return monthReports;
    // reports = monthReports;
    // notifyListeners();
  }

  Future<List<ReportModel>> fetchThreeMonthRecords() async {
    final threeMonthReports = await _recordService.fetchThreeMonthRecords();
    print('月のレポート表示$threeMonthReports');
    return threeMonthReports;
    // reports = monthReports;
    // notifyListeners();
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
    }
    notifyListeners();
  }
}
