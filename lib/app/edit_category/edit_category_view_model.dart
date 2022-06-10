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
import 'dart:convert';

final editCategoryViewModelProvider = ChangeNotifierProvider((ref) {
  return EditCategoryViewModel(
    ref.watch(recordServiceProvider),
  );
});

class EditCategoryViewModel extends ChangeNotifier {
  // EditCategoryViewModel(this._recordService);
  EditCategoryViewModel(this._recordService) {
    // print('設定画面ロードするよ＝＝＝');
    load();
  }
  final RecordService _recordService;
  final TextEditingController categoryController = TextEditingController();
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

  FlutterLocalNotificationsPlugin flnp = FlutterLocalNotificationsPlugin();

  Future<void> load() async {
    final savedCategories = await getCategoryList();
    if (savedCategories != null) {
      categories = savedCategories;
      notifyListeners();
      // print('保存されているcategoriesを読み込んだよ〜〜〜');
    } else {
      // print('まだ、SharedPreferenceは使われてはいないよ〜〜〜$categories');
      await setCategoryList(categories);
      // categories.forEach((category) {
      //   print('一個ずつcategory保存していくよ〜〜〜');
      // });
      // setCategory(category);
    }
  }

  Future<List<String>?> getCategoryList() async {
    final prefs = await SharedPreferences.getInstance();
    // print(categoryListPrefsKey);
    // final isFirstLoading = prefs
    //     .getStringList(categoryListPrefsKey)
    //     ?.cast<String>() as List<String>;
    final categoryList = prefs.getStringList(categoryListPrefsKey);
    // print('カテゴリーはjson型？？？$categoryList');
    return categoryList;

    // if (categoryList != null) {
    // final readingList = categoryList
    //     .map((category) => CategoryModel.fromJson(json.encode(category)))
    //     .toList();
    // final readingList = categoryList
    // final readingList = categoryList
    //     .map((category) => CategoryModel(
    //         id: int.parse(category['id'].toString()),
    //         category: category['category'].toString()))
    //     .toList();
    // } else {}
    // return isFirstLoading;
  }

  Future<void> setCategoryList(List<String> categories) async {
    final prefs = await SharedPreferences.getInstance();
    final index = categories.length - 1;
    // print('新しく作成するIndex: $index');
    // print('保存するするするCategories: $categories');
    // final fixedCategories =
    // final newCategories = categories
    //     .map(
    //       (category) => CategoryModel(
    //         id: index,
    //         category: category,
    //       ),
    //     )
    //     .toList();
    // print('新しいカテゴリーを作成するよ〜〜〜$newCategories');
    // final fixedCategories = newCategories
    //     .map((newCategory) => json.encode(newCategory.toMap()))
    //     .toList();
    // print('新しいカテゴリーを作成するよ〜〜〜$fixedCategories');
    await prefs.setStringList(categoryListPrefsKey, categories);

    // final newCategory = CategoryModel(
    //   id: index,
    //   category: category,
    // );
    // await prefs.setStringList(categoryListPrefsKey, category);
  }

  Future<void> addNewCategory(String category) async {
    categories.add(category);
    await setCategoryList(categories);
    notifyListeners();
    // money = category;
    // print(money);
  }

  Future<void> updateCategory(
    String newCategory,
    int index,
  ) async {
    final updatedCategory = categories
        .map(
          (category) =>
              categories.indexOf(category) == index ? newCategory : category,
        )
        .toList();
    // final updatedCategory = categories
    //     .where(
    //       (element) => categories.indexOf(element) == index,
    //     )
    //     .toList();
    // print('カテゴリーの番号: $index');
    // print('新しいカテゴリー: $newCategory');
    // print('条件に合ったカテゴリー: $updatedCategory');
    // print(updatedCategory);
    categories = updatedCategory;
    // print(categories);
    notifyListeners();
    await setCategoryList(updatedCategory);
    // await setCategoryList(categories);
    // notifyListeners();
    // money = category;
    // print(money);
  }

  Future<void> deleteCategory(
    int index,
  ) async {
    // print('削除前のCategories: $categories');
    categories.removeAt(index);
    await setCategoryList(categories);
    // print('削除後のCategories: $categories');
    notifyListeners();
    // final fixedCategory = categories
    //     .map(
    //       (category) =>
    //           categories.indexOf(category) == index ? newCategory : category,
    //     )
    //     .toList();
  }
}
