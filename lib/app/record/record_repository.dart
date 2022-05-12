import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_record/app/record/record_model.dart';
import 'package:food_record/app/record/record_remote_data_source.dart';

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
    print('test');
    await _recordRemoteDataSource.createRecord(
      record: record,
    );
  }
}
