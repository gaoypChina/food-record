import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_record/app/record/record_model.dart';
import 'package:food_record/app/report/report_model.dart';
import 'package:food_record/app/sqflite/record_database.dart';

final recordRemoteDataSourceProvider = Provider<RecordRemoteDataSource>((ref) {
  return RecordRemoteDataSource(
    ref.watch(recordDatabaseProvider),
  );
});

class RecordRemoteDataSource {
  RecordRemoteDataSource(this._recordDatabase);
  final RecordDatabase _recordDatabase;

  Future<void> createRecord({
    required RecordModel record,
  }) async {
    // print('テstudio');
    // await _recordDatabase.deleteTable();
    await _recordDatabase.add(record);
  }

  Future<void> updateRecord({
    required RecordModel record,
  }) async {
    // print('Databaseに更新するよ〜〜〜: $record');
    await _recordDatabase.updateRecord(record);
  }

  Future<void> deleteRecord({
    required RecordModel record,
  }) async {
    // print('Databaseに更新するよ〜〜〜: $record');
    final recordId = int.parse(record.id.toString());
    await _recordDatabase.deleteRecord(recordId);
  }

  Future<List<RecordModel>> getWeekRecordList() async {
    return _recordDatabase.getWeekRecordList();
  }

  Future<List<RecordModel>> getMonthRecordList() async {
    return _recordDatabase.getMonthRecordList();
  }

  Future<List<RecordModel>> getThreeMonthRecordList() async {
    return _recordDatabase.getThreeMonthRecordList();
  }

  Future<List<RecordModel>> getCustomRecords(
    DateTime opening,
    DateTime closing,
  ) async {
    return _recordDatabase.getCustomPeriodRecordList(opening, closing);
  }

  Future<List<ReportModel>> getWeekRecords() async {
    return _recordDatabase.getWeekRecords();
  }

  Future<List<ReportModel>> getMonthRecords() async {
    return _recordDatabase.getMonthReports();
  }

  Future<List<ReportModel>> getThreeMonthRecords() async {
    return _recordDatabase.getThreeMonthReports();
  }

  Future<List<ReportModel>> getCustomPeriodRecords(
    DateTime opening,
    DateTime closing,
  ) async {
    return _recordDatabase.getCustomPeriodRecords(opening, closing);
  }

  // Future<void> setRoom(
  //     {required String roomId, required Map<String, dynamic> data}) async {
  //   await _cloudFirestoreService.setData(
  //       path: FirestorePath.roomPath(roomId), data: data);
  // }

  // Future<List<RecordModel>> getRooms() async {
  //   return _cloudFirestoreService.collectionFuture<RecordModel>(
  //     path: FirestorePath.roomDomain,
  //     builder: (data, _) {
  //       RecordModel stream;
  //       try {
  //         stream = RecordModel.fromMap(data);
  //         // print(stream);
  //         return stream;
  //       } on Exception catch (e) {
  //         print(e);
  //         throw (e);
  //       }
  //     },
  //   );
  // }
}
