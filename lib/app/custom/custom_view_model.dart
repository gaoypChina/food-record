import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_record/app/record/record_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

final customViewModelProvider = ChangeNotifierProvider((ref) {
  return CustomViewModel(
    ref.watch(recordServiceProvider),
  );
});

class CustomViewModel extends ChangeNotifier {
  CustomViewModel(this._recordService) {
    // print('ロードするよ');
    load();
  }
  final RecordService _recordService;
  int selectedPeriodIndex = 0;
  DateTime openingDate = DateTime.now();
  DateTime closingDate = DateTime.now().add(
    Duration(days: 1),
  );
  bool isFullPeriod = false;
  static const indexPrefsKey = 'selectedPeriodIndex';
  static const openingPrefsKey = 'customOpening';
  static const closingPrefsKey = 'customClosing';

  // TODO: 初期ロードの処理
  Future<void> load() async {
    final index = await getPeriodIndex();
    // print(index);
    selectedPeriodIndex = int.parse(index.toString());
    notifyListeners();
  }

  // TODO: shared_preferenceを読み込む処理
  Future<int?> getPeriodIndex() async {
    final prefs = await SharedPreferences.getInstance();
    final index = prefs.getInt(indexPrefsKey);
    // print(index);
    // selectedPeriodIndex = int.parse(index.toString());
    return index;
  }

  Future<void> getOpeningDate() async {
    final prefs = await SharedPreferences.getInstance();
    final index = prefs.getInt(openingPrefsKey);
  }

  Future<void> setOpeningDate(DateTime date) async {
    final prefs = await SharedPreferences.getInstance();
    final opening = date.millisecondsSinceEpoch;
    // print('opening: $opening');
    await prefs.setInt(openingPrefsKey, opening);
    isFullPeriod = false;
    notifyListeners();
  }

  Future<void> setClosingDate(DateTime date) async {
    final prefs = await SharedPreferences.getInstance();
    final closing = date.millisecondsSinceEpoch;
    // print('closing: $closing');
    await prefs.setInt(closingPrefsKey, closing);
    isFullPeriod = false;
    notifyListeners();
  }

  // TODO: shared_preferenceを書き込む処理
  Future<void> setPeriodIndex(int themeIndex) async {
    final prefs = await SharedPreferences.getInstance();
    if (selectedPeriodIndex != themeIndex) {
      selectedPeriodIndex = themeIndex;
      // print(selectedPeriodIndex);
      await prefs.setInt(indexPrefsKey, themeIndex);
      if (selectedPeriodIndex == 0) {
        setToday();
      } else if (selectedPeriodIndex == 1) {
        setYesterday();
      } else if (selectedPeriodIndex == 2) {
        setCurrentWeek();
      } else if (selectedPeriodIndex == 3) {
        setCurrentMonth();
      } else if (selectedPeriodIndex == 4) {
        setCurrentYear();
      } else if (selectedPeriodIndex == 5) {
        setPastHalfYear();
      } else if (selectedPeriodIndex == 6) {
        setPastOneYear();
      }
      // else if (selectedPeriodIndex == 7) {
      //   setFullPeriod();
      // }
      else if (selectedPeriodIndex == 7) {
        setOpeningDate(openingDate);
        setClosingDate(closingDate);
      }
      // getPeriodIndex();
      notifyListeners();
    }
  }

  Future<void> setToday() async {
    openingDate = DateTime.now();
    closingDate = DateTime.now().add(
      Duration(days: 1),
    );
    isFullPeriod = false;
  }

  Future<void> setYesterday() async {
    openingDate = DateTime.now().add(
      Duration(days: -1),
    );
    closingDate = DateTime.now();
    isFullPeriod = false;
  }

  Future<void> setCurrentWeek() async {
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
    // print(today);
    final monday =
        isWeekday == 1 ? today : today.add(Duration(days: isWeekday - 1) * -1);
    final sunday = isWeekday == 7 ? today : monday.add(Duration(days: 6));
    // print('月曜日: ${monday}');
    // print('日曜日: ${sunday}');
    openingDate = monday;
    closingDate = sunday;
    isFullPeriod = false;
  }

  Future<void> setCurrentMonth() async {
    final now = DateTime.now();
    openingDate = DateTime(
      now.year,
      now.month,
      1,
    );

    closingDate = DateTime(
      now.year,
      now.month + 1,
      1,
    ).add(Duration(days: -1));
    isFullPeriod = false;
  }

  Future<void> setCurrentYear() async {
    final now = DateTime.now();
    openingDate = DateTime(
      now.year,
      1,
      1,
    );

    closingDate = DateTime(
      now.year + 1,
      1,
      1,
    ).add(Duration(days: -1));
    isFullPeriod = false;
  }

  Future<void> setPastHalfYear() async {
    final now = DateTime.now();
    final today = DateTime(
      now.year,
      now.month,
      now.day,
    );
    openingDate = today.add(Duration(
      days: 180 * -1,
    ));

    closingDate = today;
    isFullPeriod = false;
  }

  Future<void> setPastOneYear() async {
    final now = DateTime.now();
    final today = DateTime(
      now.year,
      now.month,
      now.day,
    );
    openingDate = today.add(Duration(
      days: 365 * -1,
    ));

    closingDate = today;
    isFullPeriod = false;
  }

  Future<void> setFullPeriod() async {
    isFullPeriod = true;
  }
}
