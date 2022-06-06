import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_record/app/custom/custom_date_tile.dart';
import 'package:food_record/app/custom/custom_view_model.dart';
import 'package:food_record/app/custom/simple_date_tile.dart';
import 'package:food_record/app/report/report_model.dart';

class CustomPage extends ConsumerWidget {
  CustomPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(customViewModelProvider);
    // final openingDate = viewModel.openingDate;
    // final closingDate = viewModel.closingDate;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          '期間を設定する',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.amber.shade100,
            ),
            child: ListTile(
              title: Center(
                child: viewModel.isFullPeriod
                    ? Text('全期間')
                    : Text(
                        '${viewModel.openingDate.year}年${viewModel.openingDate.month}月${viewModel.openingDate.day}日 - ${viewModel.closingDate.year}年${viewModel.closingDate.month}月${viewModel.closingDate.day}日',
                        // '${now.year}年${now.month}月${now.day}日',
                        // style: TextStyle(
                        //   fontWeight: FontWeight.bold,
                        // ),
                      ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SimpleDateTile(
                    viewModel: viewModel,
                    period: '今日',
                    index: 0,
                  ),
                  SimpleDateTile(
                    viewModel: viewModel,
                    period: '昨日',
                    index: 1,
                  ),
                  SimpleDateTile(
                    viewModel: viewModel,
                    period: '今週',
                    index: 2,
                  ),
                  SimpleDateTile(
                    viewModel: viewModel,
                    period: '今月',
                    index: 3,
                  ),
                  SimpleDateTile(
                    viewModel: viewModel,
                    period: '今年',
                    index: 4,
                  ),
                  SimpleDateTile(
                    viewModel: viewModel,
                    period: '過去180日間',
                    index: 5,
                  ),
                  SimpleDateTile(
                    viewModel: viewModel,
                    period: '過去365日間',
                    index: 6,
                  ),
                  // SimpleDateTile(
                  //   viewModel: viewModel,
                  //   period: '全期間',
                  //   index: 7,
                  // ),
                  ExpansionTile(
                    title: Text('カスタム(開始日、締め日を指定)'),
                    children: [
                      SimpleDateTile(
                        viewModel: viewModel,
                        period: 'カスタムを適用する',
                        index: 7,
                      ),
                      CustomDateTile(
                        viewModel: viewModel,
                        period: '開始日',
                        // now: viewModel.openingDate,
                      ),
                      CustomDateTile(
                        viewModel: viewModel,
                        period: '締め日',
                        // now: viewModel.closingDate,
                      )
                    ],
                  ),
                  // CustomDateTile(period: 'カスタム', now: now),
                ],
              ),
            ),
          ),
          // Stack(
          //   children: [
          //     Container(
          //       color: Colors.green,
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.all(20.0),
          //       child: Align(
          //         alignment: Alignment.bottomCenter,
          //         child: ElevatedButton(
          //           child: Text(
          //             '選択した期間で絞り込む',
          //             style: TextStyle(
          //               fontSize: 18,
          //               fontWeight: FontWeight.bold,
          //             ),
          //           ),
          //           onPressed: () {
          //             Navigator.pop(context);
          //           },
          //           style: ElevatedButton.styleFrom(
          //             minimumSize: Size(250, 50),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          // CustomDateTile(period: '過去7日間', now: now),
          // CustomDateTile(period: '過去30日間', now: now),
          // CustomDateTile(period: '過去90日間', now: now),
          // CustomDateTile(period: '開始日', now: now),
          // CustomDateTile(period: '締め日', now: now),
          // ListTile(
          //   title: Text(
          //     '締め日',
          //     style: TextStyle(
          //       fontWeight: FontWeight.bold,
          //       fontSize: 18,
          //     ),
          //   ),
          // ),
          // ElevatedButton(
          //   onPressed: () {
          //     print('保存する');
          //   },
          //   child: Text('保存する'),
          // ),
        ],
      ),
    );
  }

  // void updateIndex(CustomViewModel viewModel, int index) {
  //   viewModel.setPeriodIndex(index);
  //   print('Indexを切り替えるよ');
  // }
}
