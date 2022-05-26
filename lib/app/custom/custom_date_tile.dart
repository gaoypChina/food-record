import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_record/app/custom/custom_view_model.dart';
import 'package:food_record/app/custom/date_picker.dart';

class CustomDateTile extends StatelessWidget {
  const CustomDateTile({
    Key? key,
    required this.period,
    // required this.now,
    required this.viewModel,
  }) : super(key: key);

  final String period;
  // final DateTime now;
  final CustomViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(),
        ),
      ),
      child: ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              // '開始日',
              period,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            period == '開始日'
                ? Text(
                    '${viewModel.openingDate.year}年${viewModel.openingDate.month}月${viewModel.openingDate.day}日',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : Text(
                    '${viewModel.closingDate.year}年${viewModel.closingDate.month}月${viewModel.closingDate.day}日',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  )
          ],
        ),
        onTap: () {
          showCupertinoDialog<String>(
              context: context,
              builder: (context) {
                return CupertinoAlertDialog(
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Text('$periodを選択'),
                  ),
                  content: Container(
                    width: 120,
                    height: 120,
                    child: DatePicker(
                      viewModel: viewModel,
                      isOpening: period == '開始日' || false,
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        // viewModel.foodPriceController.clear();
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
                      onPressed: () {
                        print('OK');
                        if (period == '開始日') {
                          viewModel.setOpeningDate(viewModel.openingDate);
                        } else {
                          viewModel.setClosingDate(viewModel.closingDate);
                        }
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
                  // content: Container(
                  //   height: 120,
                  //   width: 120,
                  // child: DatePicker(),
                  // ),
                );
              });
        },
      ),
    );
  }
}
