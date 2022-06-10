import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_record/app/record/record_model.dart';
import 'package:food_record/app/record/record_service.dart';

final editViewModelProvider = ChangeNotifierProvider.autoDispose((ref) {
  return EditViewModel(
    ref.watch(recordServiceProvider),
  );
});

class EditViewModel extends ChangeNotifier {
  EditViewModel(this._recordService) {
    // print('EditViewModel初期描画');
    load();
  }
  final RecordService _recordService;
  List<RecordModel> rooms = [];
  // moneyでのDialogの文字入力部分
  final TextEditingController foodPriceController = TextEditingController();
  // DateTimePickerで必要な状態管理
  static DateTime today = DateTime.now();
  int selectYear = today.year;
  int selectMonth = today.month;
  int selectDay = today.day;

  // EditPageでの状態管理(カテゴリー、金額)
  String category = '';
  int money = 0;
  DateTime date = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  bool isUpdatedCategory = false;
  bool isUpdatedMoney = false;
  bool isUpdatedDate = false;

  // TODO: 初期ロードでカテゴリー, 金額, 日数を引数から受け取って更新したい。

  Future<void> load() async {
    category = '';
    money = 0;
    date = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );
  }

  Future<void> createRecord(
    int money,
    DateTime expenditureDate,
    String category,
  ) async {
    await _recordService.createRecord(
      money,
      expenditureDate,
      category,
    );
  }

  Future<void> updateRecord(
    int id,
    int money,
    DateTime expenditureDate,
    String category,
    DateTime createdAt,
  ) async {
    // return _recordService.fetchRooms();
    await _recordService.updateRecord(
      id,
      money,
      expenditureDate,
      category,
      createdAt,
    );
  }

  Future<void> deleteRecord(RecordModel record) async {
    await _recordService.deleteRecord(record);
  }

  Future<DateTime> createExpenditureDate(int year, int month, int day) async {
    final expenditureDate = DateTime(year, month, day);
    // print('支出日: $expenditureDate');
    return expenditureDate;
  }

  Future<void> getTaxIncludePrice(double number) async {
    if (foodPriceController.text.isEmpty == false) {
      final foodPrice = int.parse(foodPriceController.text) * number;
      final floorFoodPrice = foodPrice.round();
      // print(foodPrice);
      // print(floorFoodPrice);
      foodPriceController.text = floorFoodPrice.toString();
    }
  }

  Future<void> updateCategory(String selectedCategory) async {
    category = selectedCategory;
    isUpdatedCategory = true;
    // print(category);
    // print(isUpdatedCategory);
    notifyListeners();
  }

  Future<void> updateMoney(int foodPrice) async {
    money = foodPrice;
    isUpdatedMoney = true;
    // print(money);
    // print(isUpdatedMoney);
    notifyListeners();
  }

  Future<void> updateExpenditureDate() async {
    final expenditureDate = DateTime(selectYear, selectMonth, selectDay);
    date = expenditureDate;
    isUpdatedDate = true;
    // print(date);
    // print(isUpdatedDate);
    notifyListeners();
  }
}
