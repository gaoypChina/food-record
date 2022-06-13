import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_record/app/record/record_model.dart';
import 'package:food_record/app/record/record_remote_data_source.dart';
import 'package:food_record/app/report/report_model.dart';

final recordRepositoryProvider = Provider<RecordRepository>((ref) {
  return RecordRepository(
    ref.watch(recordRemoteDataSourceProvider),
  );
});

class RecordRepository {
  RecordRepository(this._recordRemoteDataSource);
  final RecordRemoteDataSource _recordRemoteDataSource;

  Future<void> setRoom({
    required String roomId,
    required RecordModel data,
  }) async {
    // await _recordRemoteDataSource.setRoom(roomId: roomId, data: data.toMap());
  }

  Future<void> createRecord({
    required RecordModel record,
  }) async {
    // print('test');
    await _recordRemoteDataSource.createRecord(
      record: record,
    );
  }

  Future<void> updateRecord({
    required RecordModel record,
  }) async {
    // print('update: $record');
    await _recordRemoteDataSource.updateRecord(
      record: record,
    );
  }

  Future<void> deleteRecord({
    required RecordModel record,
  }) async {
    // print('delete: $record');
    await _recordRemoteDataSource.deleteRecord(
      record: record,
    );
  }

  Future<List<RecordModel>> getWeekRecords() async {
    return _recordRemoteDataSource.getWeekRecordList();
  }

  Future<List<RecordModel>> getMonthRecords() async {
    return _recordRemoteDataSource.getMonthRecordList();
  }

  Future<List<RecordModel>> getThreeMonthRecords() async {
    return _recordRemoteDataSource.getThreeMonthRecordList();
  }

  Future<List<RecordModel>> getCustomRecords(
    DateTime opening,
    DateTime closing,
  ) async {
    return _recordRemoteDataSource.getCustomRecords(opening, closing);
  }

  Future<List<ReportModel>> fetchWeekRecords() async {
    return _recordRemoteDataSource.getWeekRecords();
  }

  Future<List<ReportModel>> fetchMonthRecords() async {
    return _recordRemoteDataSource.getMonthRecords();
  }

  Future<List<ReportModel>> fetchThreeMonthRecords() async {
    return _recordRemoteDataSource.getThreeMonthRecords();
  }

  Future<List<ReportModel>> fetchCustomPeriodRecords(
    DateTime opening,
    DateTime closing,
  ) async {
    return _recordRemoteDataSource.getCustomPeriodRecords(opening, closing);
  }

  Future<int> getCategoryIndex() async {
    return _recordRemoteDataSource.getCategoryIndex();
  }
}
