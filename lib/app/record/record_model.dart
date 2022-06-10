import 'dart:math';

class RecordModel {
  const RecordModel({
    this.id,
    required this.money,
    required this.category,
    required this.expenditureDate,
    required this.createdAt,
    this.shop,
    this.memo,
  });

  final int? id;
  final int money;
  final String category;
  final DateTime expenditureDate;
  final DateTime createdAt;
  final String? shop;
  final String? memo;

  Map<String, dynamic> toMap() {
    final map = {
      'id': id,
      'money': money,
      'category': category,
      'expenditureDate': expenditureDate.microsecondsSinceEpoch,
      'createdAt': createdAt.microsecondsSinceEpoch,
    };
    return map;
  }

  // Map<String, dynamic>パターン
  factory RecordModel.fromMap(Map<String, dynamic> map) {
    final room = RecordModel(
      id: int.parse(map['id'].toString()),
      money: int.parse(map['money'].toString()),
      category: map['category'].toString(),
      expenditureDate: DateTime.fromMicrosecondsSinceEpoch(
        int.parse(map['expenditureDate'].toString()),
      ),
      createdAt: DateTime.fromMicrosecondsSinceEpoch(
        int.parse(map['createdAt'].toString()),
      ),
    );
    return room;
  }

  factory RecordModel.initialData(
    int money,
    DateTime expenditureDate,
    String category,
  ) {
    return RecordModel(
      money: money,
      category: category,
      expenditureDate: expenditureDate,
      createdAt: DateTime.now(),
    );
  }
}
