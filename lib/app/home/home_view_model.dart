import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_record/app/record/record_model.dart';
import 'package:food_record/app/record/record_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

final homeViewModelProvider = ChangeNotifierProvider((ref) {
  return HomeViewModel(
    ref.watch(recordServiceProvider),
  );
});

class HomeViewModel extends ChangeNotifier {
  HomeViewModel(this._recordService) {
    load();
  }
  final RecordService _recordService;
  // List<RecordModel> rooms = [];
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
  final TextEditingController foodPriceController = TextEditingController();
  static DateTime today = DateTime.now();
  int selectYear = today.year;
  int selectMonth = today.month;
  int selectDay = today.day;
  static const categoryListPrefsKey = 'categoryArray';

  // Future<void> load() async {
  // rooms = await fetchRoom();
  // await fetchRoom();
  // print(rooms);
  // notifyListeners();
  // }

  Future<void> load() async {
    final readingCategories = await getCategories();
    if (readingCategories != null) {
      categories = readingCategories;
      print('保存されているcategoriesを読み込んだよ〜〜〜$categories');
    } else {
      print('まだ、SharedPreferenceは使われてはいないよ〜〜〜$categories');
    }
    notifyListeners();
  }

  Future<List<String>?> getCategories() async {
    final prefs = await SharedPreferences.getInstance();
    final categoryList = prefs.getStringList(categoryListPrefsKey);
    print('カテゴリーはjson型？？？$categoryList');
    return categoryList;
  }

  // Future<List<RecordModel>> fetchRoom() async {
  Future<void> createRecord(
    int money,
    DateTime expenditureDate,
    String category,
  ) async {
    // return _recordService.fetchRooms();
    await _recordService.createRecord(
      money,
      expenditureDate,
      category,
    );
  }

  Future<DateTime> createExpenditureDate(int year, int month, int day) async {
    final expenditureDate = DateTime(year, month, day);
    print('支出日: $expenditureDate');
    return expenditureDate;
  }

  Future<void> getTaxIncludePrice(double number) async {
    if (foodPriceController.text.isEmpty == false) {
      final foodPrice = int.parse(foodPriceController.text) * number;
      final floorFoodPrice = foodPrice.round();
      print(foodPrice);
      print(floorFoodPrice);
      foodPriceController.text = floorFoodPrice.toString();
    }
  }
}
