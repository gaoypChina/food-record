import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_record/app/edit/edit_view_model.dart';
import 'package:food_record/app/home/home_view_model.dart';

class InputDialog extends StatelessWidget {
  const InputDialog({
    Key? key,
    required this.category,
    required this.viewModel,
  }) : super(key: key);

  final String category;
  final EditViewModel viewModel;

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                child: Text('×8%'),
                onPressed: () {
                  // print('8%掛ける');
                  viewModel.getTaxIncludePrice(1.08);
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                ),
              ),
              ElevatedButton(
                child: Text('×10%'),
                onPressed: () {
                  // print('10%掛ける');
                  viewModel.getTaxIncludePrice(1.1);
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                ),
              ),
            ],
          )
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            viewModel.foodPriceController.clear();
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
            final foodPrice = int.parse(viewModel.foodPriceController.text);
            // print('食費の金額: $foodPrice');
            await viewModel.updateMoney(foodPrice);
            // viewModel.money = foodPrice;
            // await viewModel.createRecord(
            //   foodPrice,
            //   expenditureDate,
            //   category,
            // );
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
