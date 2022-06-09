import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_record/app/record/record_model.dart';
import 'package:food_record/app/record/record_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

final selectCategoryViewModelProvider = ChangeNotifierProvider((ref) {
  return SelectCategoryViewModel(
    ref.watch(recordServiceProvider),
  );
});

class SelectCategoryViewModel extends ChangeNotifier {
  SelectCategoryViewModel(this._recordService) {
    print('SharedPreferenceを読み込むよ〜〜〜');
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
  static const categoryListPrefsKey = 'categoryArray';

  Future<void> load() async {
    final savedCategories = await getCategoryList();
    if (savedCategories != null) {
      categories = savedCategories;
      notifyListeners();
      print('保存されているcategoriesを読み込んだよ〜〜〜');
    } else {
      print('まだ、SharedPreferenceは使われてはいないよ〜〜〜$categories');
    }
  }

  Future<List<String>?> getCategoryList() async {
    final prefs = await SharedPreferences.getInstance();
    print(categoryListPrefsKey);
    final categoryList = prefs.getStringList(categoryListPrefsKey);
    print('カテゴリーはjson型？？？$categoryList');
    return categoryList;
  }
}
