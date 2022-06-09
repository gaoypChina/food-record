import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_record/app/edit_category/edit_category_view_model.dart';

class EditCategoryMethod {
  void showActionSheet(
    BuildContext context,
    EditCategoryViewModel viewModel,
    int index,
  ) {
    print('index: $index');
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('Title'),
        message: const Text('Message'),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            /// This parameter indicates the action would be a default
            /// defualt behavior, turns the action's text to bold text.
            onPressed: () {
              Navigator.pop(context);
              _updateCategoryDialog(context, viewModel, index);
            },
            child: const Text(
              'カテゴリーの編集',
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
              _deleteCategoryDialog(context, viewModel, index);
            },
            child: const Text('カテゴリーの削除'),
          ),
          CupertinoActionSheetAction(
            /// This parameter indicates the action would perform
            /// a destructive action such as delete or exit and turns
            /// the action's text color to red.
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'キャンセル',
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> newCategoryDialog(
    BuildContext context,
    EditCategoryViewModel viewModel,
  ) async {
    await showCupertinoDialog<void>(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text('カテゴリーを追加する'),
          content: Column(
            children: [
              SizedBox(
                width: 2,
                height: 2,
              ),
              Text('カテゴリー名を記入してください。'),
              SizedBox(
                width: 18,
                height: 18,
              ),
              CupertinoTextField(
                controller: viewModel.categoryController,
                autofocus: true,
                keyboardType: TextInputType.text,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                viewModel.categoryController.clear();
                Navigator.pop(context);
              },
              child: Text(
                'キャンセル',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.blue,
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                // final expenditureDate = await viewModel.createExpenditureDate(
                //   viewModel.selectYear,
                //   viewModel.selectMonth,
                //   viewModel.selectDay,
                // );
                // print('返り血$expenditureDate');
                final category = viewModel.categoryController.text;
                print('カテゴリー名: $category');
                await viewModel.addNewCategory(category);
                // viewModel.money = foodPrice;
                // await viewModel.createRecord(
                //   foodPrice,
                //   expenditureDate,
                //   category,
                // );
                viewModel.categoryController.clear();
                Navigator.pop(context);
              },
              child: Text(
                '完了',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _updateCategoryDialog(
    BuildContext context,
    EditCategoryViewModel viewModel,
    int index,
  ) async {
    await showCupertinoDialog<void>(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text('${viewModel.categories[index]}の名前変更'),
          content: Column(
            children: [
              SizedBox(
                width: 2,
                height: 2,
              ),
              Text('新しいカテゴリー名を記入してください。'),
              SizedBox(
                width: 18,
                height: 18,
              ),
              CupertinoTextField(
                controller: viewModel.categoryController,
                autofocus: true,
                keyboardType: TextInputType.text,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                viewModel.categoryController.clear();
                Navigator.pop(context);
              },
              child: Text(
                'キャンセル',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.blue,
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                // final expenditureDate = await viewModel.createExpenditureDate(
                //   viewModel.selectYear,
                //   viewModel.selectMonth,
                //   viewModel.selectDay,
                // );
                // print('返り血$expenditureDate');
                final category = viewModel.categoryController.text;
                print('カテゴリー名: $category');
                await viewModel.updateCategory(category, index);
                // await viewModel.addNewCategory(category);
                // viewModel.money = foodPrice;
                // await viewModel.createRecord(
                //   foodPrice,
                //   expenditureDate,
                //   category,
                // );
                viewModel.categoryController.clear();
                Navigator.pop(context);
              },
              child: Text(
                '完了',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteCategoryDialog(
    BuildContext context,
    EditCategoryViewModel viewModel,
    int index,
  ) async {
    await showCupertinoDialog<void>(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text('最終確認'),
          content: Column(
            children: [
              SizedBox(
                width: 2,
                height: 2,
              ),
              Text('${viewModel.categories[index]}をカテゴリーから削除します'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'キャンセル',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.blue,
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                // final expenditureDate = await viewModel.createExpenditureDate(
                //   viewModel.selectYear,
                //   viewModel.selectMonth,
                //   viewModel.selectDay,
                // );
                // print('返り血$expenditureDate');
                print('カテゴリー名: ${viewModel.categories[index]}');
                await viewModel.deleteCategory(index);
                // await viewModel.addNewCategory(category);
                // viewModel.money = foodPrice;
                // await viewModel.createRecord(
                //   foodPrice,
                //   expenditureDate,
                //   category,
                // );
                Navigator.pop(context);
              },
              child: Text(
                '完了',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
