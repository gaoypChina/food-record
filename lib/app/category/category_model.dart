class CategoryModel {
  CategoryModel({
    this.id,
    required this.category,
  });

  final int? id;
  final String category;

  Map<String, dynamic> toMap() {
    final map = {
      'id': id,
      'category': category,
    };
    return map;
  }

  // Map<String, dynamic>パターン
  // factory CategoryModel.fromMap(Map<String, dynamic> map) {
  //   final room = CategoryModel(
  //     id: int.parse(map['id'].toString()),
  //     category: map['category'].toString(),
  //   );
  //   return room;
  // }

  CategoryModel.fromJson(Map map)
      : id = int.parse(map['id'].toString()),
        category = map['category'].toString();
}
