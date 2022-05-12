import 'dart:math';

class RecordModel {
  const RecordModel({
    this.id,
    required this.money,
    required this.createdAt,
  });

  final int? id;
  final int money;
  final DateTime createdAt;

  Map<String, dynamic> toMap() {
    final map = {
      'id': id,
      'money': money,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
    return map;
  }

  // Map<String, dynamic>パターン
  factory RecordModel.fromMap(Map<String, dynamic> map) {
    final room = RecordModel(
      id: int.parse(map['id'].toString()),
      money: int.parse(map['money'].toString()),
      createdAt: DateTime.fromMillisecondsSinceEpoch(
          int.parse(map['createdAt'].toString())),
    );
    return room;
  }

  factory RecordModel.initialData(int money) {
    return RecordModel(
      money: money,
      createdAt: DateTime.now(),
    );
  }
}
