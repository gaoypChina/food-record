import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_record/app/custom/custom_view_model.dart';
import 'package:food_record/app/report/report_model.dart';

class SimpleDateTile extends StatelessWidget {
  const SimpleDateTile({
    Key? key,
    required this.viewModel,
    required this.period,
    required this.index,
  }) : super(key: key);

  final CustomViewModel viewModel;
  final String period;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
          ),
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
            viewModel.selectedPeriodIndex == index
                ? Icon(Icons.check_box)
                : Icon(Icons.check_box_outline_blank),
            // TODO: ここにチェックマークを入れる
            // Text(
            //   '${now.year}年${now.month}月${now.day}日',
            //   style: TextStyle(
            //     fontWeight: FontWeight.bold,
            //   ),
            // )
          ],
        ),
        onTap: () {
          viewModel.setPeriodIndex(index);
          print('Indexを切り替えるよ');
        },
      ),
    );
  }
}
