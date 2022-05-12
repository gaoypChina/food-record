import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_record/app/record/record_model.dart';
import 'package:food_record/app/record/record_repository.dart';

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
  Future<void> createRecord(int money) async {
    print('記録するよ');
    final data = RecordModel.initialData(money);
    print(data);
    await _recordRepository.createRecord(
      record: data,
    );
  }
}
