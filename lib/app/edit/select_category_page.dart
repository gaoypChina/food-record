import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_record/app/edit/select_category_view_model.dart';
import 'package:food_record/app/edit_category/edit_category_method.dart';
import 'package:food_record/app/edit_category/edit_category_view_model.dart';

class SelectCategoryPage extends ConsumerWidget {
  const SelectCategoryPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(selectCategoryViewModelProvider);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'カテゴリーを選択する',
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
                        final selectedCategory = viewModel.categories[index];
                        // print('選択したカテゴリー: $selectedCategory');
                        Navigator.pop<String>(context, selectedCategory);
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
    );
  }
}
