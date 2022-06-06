import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_record/app/record/record_model.dart';
import 'package:food_record/app/record/record_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

final rootViewModelProvider = ChangeNotifierProvider((ref) {
  return RootViewModel(
    ref.watch(recordServiceProvider),
  );
});

class RootViewModel extends ChangeNotifier {
  RootViewModel(this._recordService);
  final RecordService _recordService;

  bool isFirstLoading = true;

  static const isFirstLoadingPrefsKey = 'isFirstLoading';
  // static const morningPrefsKey = 'customMorning';
  // static const noonPrefsKey = 'customNoon';
  // static const nightPrefsKey = 'customNight';

  // Future<void> load() async {
  //   final firstLoading = await getFirstLoading();
  //   isFirstLoading = firstLoading;
  //   print('初期起動: $bool');
  //   notifyListeners();
  // }

  Future<bool?> getIsFirstLoading() async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstLoading = prefs.getBool(isFirstLoadingPrefsKey);
    return isFirstLoading;
  }
}
