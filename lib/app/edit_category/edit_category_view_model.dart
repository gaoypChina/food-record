import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_record/app/category/category_model.dart';
import 'package:food_record/app/record/record_model.dart';
import 'package:food_record/app/record/record_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

final editCategoryViewModelProvider = ChangeNotifierProvider((ref) {
  return EditCategoryViewModel(
    ref.watch(recordServiceProvider),
  );
});

class EditCategoryViewModel extends ChangeNotifier {
  // EditCategoryViewModel(this._recordService);
  EditCategoryViewModel(this._recordService) {
    print('設定画面ロードするよ＝＝＝');
    load();
  }
  final RecordService _recordService;
  List<String> categories = [
    '朝食',
    '昼食',
    '夕食',
    'おやつ',
    '飲み物',
    '食材',
    '交際費',
    'カフェ',
  ];
  static const categoryPrefsKey = 'category';

  FlutterLocalNotificationsPlugin flnp = FlutterLocalNotificationsPlugin();

  Future<void> load() async {
    final savedCategories = await getCategory();
    if (savedCategories != null) {
      categories = savedCategories;
      print('保存されているcategoriesを読み込んだよ〜〜〜');
    } else {
      print('まだ、SharedPreferenceは使われてはいないよ〜〜〜$categories');
    }
    notifyListeners();
  }

  Future<List<String>?> getCategory() async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstLoading = prefs.getStringList(categoryPrefsKey);
    print('カテゴリーはjson型？？？$isFirstLoading');
    return isFirstLoading;
  }

  Future<void> setCategory(List<String> categories) async {
    final prefs = await SharedPreferences.getInstance();
    print('カテゴリーを更新するよ〜〜〜$categories');
    await prefs.setStringList(categoryPrefsKey, categories);
  }
}
