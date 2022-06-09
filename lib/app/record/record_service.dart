import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_record/app/record/record_model.dart';
import 'package:food_record/app/record/record_repository.dart';
import 'package:food_record/app/report/report_model.dart';

final recordServiceProvider = Provider<RecordService>((ref) {
  return RecordService(
    ref.watch(recordRepositoryProvider),
  );
});

class RecordService {
  RecordService(this._recordRepository);

  final RecordRepository _recordRepository;

  /// ユーザーデータをFirestoreに保存
  // Future<void> setRoom(String name, String userId) async {
  // final data = RoomModel.initialData(name, userId);
  // final roomId = data.id;
  // await _roomRepository.setRoom(roomId: roomId, data: data);
  // }

  // Future<List<RecordModel>> fetchRooms() async {
  Future<void> createRecord(
    int money,
    DateTime expenditureDate,
    String category,
  ) async {
    print('記録するよ');
    final data = RecordModel.initialData(
      money,
      expenditureDate,
      category,
    );
    print(data);
    await _recordRepository.createRecord(
      record: data,
    );
  }

  Future<void> updateRecord(
    int id,
    int money,
    DateTime expenditureDate,
    String category,
    DateTime createdAt,
  ) async {
    print('Recordをアップデートするよ');
    final data = RecordModel(
      id: id,
      money: money,
      expenditureDate: expenditureDate,
      category: category,
      createdAt: createdAt,
    );
    print(data);
    await _recordRepository.updateRecord(
      record: data,
    );
  }

  Future<void> deleteRecord(RecordModel record) async {
    await _recordRepository.deleteRecord(
      record: record,
    );
  }

  Future<List<RecordModel>> getWeekRecords() async {
    return _recordRepository.getWeekRecords();
  }

  Future<List<RecordModel>> getMonthRecords() async {
    return _recordRepository.getMonthRecords();
  }

  Future<List<RecordModel>> getThreeMonthRecords() async {
    return _recordRepository.getThreeMonthRecords();
  }

  Future<List<RecordModel>> getCustomRecords(
    DateTime opening,
    DateTime closing,
  ) async {
    return _recordRepository.getCustomRecords(opening, closing);
  }

  Future<List<ReportModel>> fetchWeekRecords() async {
    return _recordRepository.fetchWeekRecords();
  }

  Future<List<ReportModel>> fetchMonthRecords() async {
    return _recordRepository.fetchMonthRecords();
  }

  Future<List<ReportModel>> fetchThreeMonthRecords() async {
    return _recordRepository.fetchThreeMonthRecords();
  }

  Future<List<ReportModel>> fetchCustomPeriodRecords(
    DateTime opening,
    DateTime closing,
  ) async {
    return _recordRepository.fetchCustomPeriodRecords(opening, closing);
  }
}
