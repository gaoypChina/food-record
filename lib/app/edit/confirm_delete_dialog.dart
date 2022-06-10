import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_record/app/edit/edit_view_model.dart';
import 'package:food_record/app/record/record_model.dart';

class ConfirmDeleteDialog {
  Future<void> deleteRecordDialog(
    BuildContext context,
    EditViewModel viewModel,
    RecordModel record,
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
              Text('削除した記録はもとに戻せません'),
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
                // print('レコード名: $record');
                await viewModel.deleteRecord(record);
                // await viewModel.deleteCategory(index);
                // await viewModel.addNewCategory(category);
                // viewModel.money = foodPrice;
                // await viewModel.createRecord(
                //   foodPrice,
                //   expenditureDate,
                //   category,
                // );
                Navigator.pop(context);
                Navigator.pop<int>(context, index);
                int count = 0;
                // Navigator.popUntil(context, (_) => count++ >= 2);
              },
              child: Text(
                '削除',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
