import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_record/app/edit_category/edit_category_view_model.dart';

class EditCategoryPage extends ConsumerWidget {
  const EditCategoryPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(editCategoryViewModelProvider);
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'カテゴリーを編集する',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: viewModel.categories.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    child: ListTile(
                      onTap: () {
                        print('カテゴリーの編集と削除を記述するよ');
                      },
                      tileColor: Colors.white,
                      title: Text(
                        viewModel.categories[index],
                      ),
                      trailing: Icon(
                        Icons.arrow_back_ios,
                        textDirection: TextDirection.rtl,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('カテゴリーを追加する');
        },
        backgroundColor: Colors.green,
        child: Icon(
          Icons.add,
        ),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {
      //     print('カテゴリーを追加する');
      //   },
      //   backgroundColor: Colors.green,
      //   icon: Icon(
      //     Icons.add,
      //   ),
      //   label: Text(
      //     '追加する',
      //     style: TextStyle(
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      // ),
    );
  }
}
