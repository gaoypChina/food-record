import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_record/app/record/record_model.dart';
import 'package:food_record/app/record/record_service.dart';
import 'package:food_record/app/report/report_model.dart';

final reportViewModelProvider = ChangeNotifierProvider((ref) {
  return ReportViewModel(
    ref.watch(recordServiceProvider),
  );
});

class ReportViewModel extends ChangeNotifier {
  ReportViewModel(this._recordService) {
    load();
  }

  final RecordService _recordService;
  List<ReportModel> reports = [];
  int recordIndex = 0;

  Future<void> load() async {
    reports = await fetchWeekRecords();
    print('初期リロード$reports');
    notifyListeners();
  }

  Future<List<ReportModel>> fetchWeekRecords() async {
    final reports = _recordService.fetchWeekRecords();
    print('fetchしてるよ〜〜〜$reports');
    return reports;
  }

  Future<void> updateIndex(int index) async {
    recordIndex = index;
    print(recordIndex);
    notifyListeners();
  }
}
