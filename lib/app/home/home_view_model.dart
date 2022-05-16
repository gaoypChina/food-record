import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_record/app/record/record_model.dart';
import 'package:food_record/app/record/record_service.dart';

final homeViewModelProvider = ChangeNotifierProvider((ref) {
  return HomeViewModel(
    ref.watch(recordServiceProvider),
  );
});

class HomeViewModel extends ChangeNotifier {
  HomeViewModel(this._recordService);
  final RecordService _recordService;
  List<RecordModel> rooms = [];
  final TextEditingController foodPriceController = TextEditingController();
  static DateTime today = DateTime.now();
  int selectYear = today.year;
  int selectMonth = today.month;
  int selectDay = today.day;

  // Future<void> load() async {
  // rooms = await fetchRoom();
  // await fetchRoom();
  // print(rooms);
  // notifyListeners();
  // }

  // Future<List<RecordModel>> fetchRoom() async {
  Future<void> createRecord(int money, DateTime expenditureDate) async {
    // return _recordService.fetchRooms();
    await _recordService.createRecord(money, expenditureDate);
  }

  Future<DateTime> createExpenditureDate(int year, int month, int day) async {
    final expenditureDate = DateTime(year, month, day);
    print('支出日: $expenditureDate');
    return expenditureDate;
  }
}
