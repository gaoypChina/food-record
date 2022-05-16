import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_record/app/home/home_view_model.dart';

class InputDialog extends StatelessWidget {
  const InputDialog({
    Key? key,
    required this.category,
    required this.viewModel,
  }) : super(key: key);

  final String category;
  final HomeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(category),
      content: Column(
        children: [
          SizedBox(
            width: 2,
            height: 2,
          ),
          Text('金額を入力してください'),
          SizedBox(
            width: 18,
            height: 18,
          ),
          CupertinoTextField(
            controller: viewModel.foodPriceController,
            autofocus: true,
            keyboardType: TextInputType.number,
          ),
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
            final expenditureDate = await viewModel.createExpenditureDate(
              viewModel.selectYear,
              viewModel.selectMonth,
              viewModel.selectDay,
            );
            print('返り血$expenditureDate');
            final foodPrice = int.parse(viewModel.foodPriceController.text);
            print('食費の金額: $foodPrice');
            await viewModel.createRecord(
              foodPrice,
              expenditureDate,
              category,
            );
            viewModel.foodPriceController.clear();
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
  }
}
