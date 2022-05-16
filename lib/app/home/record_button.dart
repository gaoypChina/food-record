import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_record/app/home/home_view_model.dart';

class RecordButton extends StatelessWidget {
  const RecordButton({
    Key? key,
    required this.viewModel,
    required this.category,
  }) : super(key: key);

  final HomeViewModel viewModel;
  final String category;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.green,
          shape: CircleBorder(),
        ),
        onPressed: () {
          print('食費を入力');
          showCupertinoDialog<void>(
            context: context,
            builder: (context) {
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
                      final expenditureDate =
                          await viewModel.createExpenditureDate(
                        viewModel.selectYear,
                        viewModel.selectMonth,
                        viewModel.selectDay,
                      );
                      print('返り血$expenditureDate');
                      final foodPrice =
                          int.parse(viewModel.foodPriceController.text);
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
            },
          );
        },
        child: Text(
          category,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
