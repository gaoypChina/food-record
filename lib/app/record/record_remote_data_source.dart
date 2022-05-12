import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_record/app/record/record_model.dart';
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
    print('テstudio');
    // await _recordDatabase.deleteTable();
    await _recordDatabase.add(record);
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
