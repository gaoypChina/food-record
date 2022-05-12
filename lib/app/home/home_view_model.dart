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

  // Future<void> load() async {
  // rooms = await fetchRoom();
  // await fetchRoom();
  // print(rooms);
  // notifyListeners();
  // }

  // Future<List<RecordModel>> fetchRoom() async {
  Future<void> createRecord(int money) async {
    // return _recordService.fetchRooms();
    await _recordService.createRecord(money);
  }
}
