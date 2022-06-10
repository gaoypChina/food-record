import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_record/app/custom/custom_page.dart';
import 'package:food_record/app/edit/edit_page.dart';
import 'package:food_record/app/home/home_page.dart';
import 'package:food_record/app/record/record_model.dart';
import 'package:food_record/app/report/no_data_alert.dart';
import 'package:food_record/app/report/report_model.dart';
import 'package:food_record/app/report/report_view_model.dart';

///日付と体重を持つクラスを作成
// class ReportModel {
//   final DateTime date;
//   final double weight;

//   ReportModel(this.date, this.weight);
// }

class ReportPage extends ConsumerWidget {
  ReportPage({
    Key? key,
    // required this.report,
  }) : super(key: key);

  // final ReportViewModel report;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(reportViewModelProvider);
    // final list = viewModel.weekRecords;
    // var list = [
    //   "メッセージ",
    //   "メッセージ",
    //   "メッセージ",
    //   "メッセージ",
    //   "メッセージ",
    // ];
    // final reports = viewModel.reports;
    // final reportList = reports
    //     .map((report) => ReportModel(
    //           date: report.date,
    //           expense: report.expense,
    //         ))
    //     .toList();
    // print(reportList[0].date);
    // print(reportList[0].expense);
    // final index = viewModel.recordIndex;

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          // print('期間を設定する');
          Navigator.push(
            context,
            MaterialPageRoute<ReportModel>(
              builder: (context) => CustomPage(),
            ),
          ).then((value) => {
                viewModel.recordIndex = 3,
                viewModel.loadCustomPeriod(),
              });
        },
        backgroundColor: Colors.green,
        label: Text('期間を設定'),
        icon: Icon(
          Icons.search,
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.green,
        title: Column(
          children: const [
            Text(
              '収支レポート',
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.replay_outlined,
              size: 28,
            ),
            onPressed: () async {
              // print('ローディング');
              if (viewModel.recordIndex == 0) {
                await viewModel.updateWeekRecords();
                await viewModel.updateWeekReports();
              } else if (viewModel.recordIndex == 1) {
                await viewModel.updateMonthRecords();
                await viewModel.updateMonthReports();
              } else if (viewModel.recordIndex == 2) {
                await viewModel.updateThreeMonthRecords();
                await viewModel.updateThreeMonthReports();
              } else {
                await viewModel.updateCustomRecords();
                await viewModel.updateCustomReports();
              }
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Text(viewModel.reports.toString()),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.amber.shade100,
                  ),
                  child: ListTile(
                    title: Center(
                      child: Text(
                        '${viewModel.opening.year}年${viewModel.opening.month}月${viewModel.opening.day}日 - ${viewModel.closing.year}年${viewModel.closing.month}月${viewModel.closing.day}日',
                      ),
                      // child: Text('全期間'),
                      // child: viewModel.isFullPeriod
                      //     ? Text('全期間')
                      //     : Text(
                      //         '${viewModel.openingDate.year}年${viewModel.openingDate.month}月${viewModel.openingDate.day}日 - ${viewModel.closingDate.year}年${viewModel.closingDate.month}月${viewModel.closingDate.day}日',
                      // '${now.year}年${now.month}月${now.day}日',
                      // style: TextStyle(
                      //   fontWeight: FontWeight.bold,
                      // ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 8,
                  ),
                  child: Container(
                    child: CupertinoSlidingSegmentedControl<int>(
                      children: {
                        0: Text('1週間'),
                        1: Text('1ヶ月'),
                        2: Text('3ヶ月'),
                        3: Text('カスタム')
                      },
                      groupValue: viewModel.recordIndex,
                      onValueChanged: (index) {
                        // print(index);
                        viewModel.updateIndex(int.parse(index.toString()));
                        // if (viewModel.recordIndex == 3) {
                        // TODO: 下のコードを移動する
                        // final result = Navigator.push(
                        //   context,
                        //   MaterialPageRoute<ReportModel>(
                        //     builder: (context) => CustomPage(),
                        //   ),
                        // );
                        // _______________________________
                        //
                        // showCupertinoDialog<void>(
                        //   context: context,
                        //   builder: (context) {
                        //     return CupertinoAlertDialog(
                        //       title: Text("カスタムできるよ〜"),
                        //       content: Text('自由に期間を決めてグラフを描画しよう！！！'),
                        //       actions: [
                        //         TextButton(
                        //           onPressed: () => Navigator.pop(context),
                        //           child: Text('OK'),
                        //         ),
                        //       ],
                        //     );
                        //   },
                        // );
                        // }
                      },
                    ),
                  ),
                ),
                changeChart(viewModel),
                // viewModel.weekReports.isNotEmpty
                //     ? Container(
                //         height: 250,
                //         child: changeChart(viewModel),
                // charts.TimeSeriesChart(
                //   _createReportModel(viewModel.reports),
                //   // _createReportModel(reportList),
                // ),
                //   )
                // : NoDataAlert(),
                // CupertinoSlidingSegmentedControl<int>(
                //   children: {
                //     0: Text('日時'),
                //     1: Text('価格'),
                //     2: Text('カテゴリー'),
                //   },
                //   groupValue: 0,
                //   onValueChanged: (index) {
                //     print('test: $index');
                //   },
                // ),
                changeRecord(viewModel),
                // viewModel.weekRecords.isNotEmpty
                //     ? ListView.builder(
                //         shrinkWrap: true,
                //         physics: NeverScrollableScrollPhysics(),
                //         itemCount: viewModel.weekRecords.length,
                //         itemBuilder: (BuildContext context, int index) {
                // if (index >= list.length) {
                //   list.addAll([
                //     "メッセージ",
                //     "メッセージ",
                //     "メッセージ",
                //     "メッセージ",
                //   ]);
                // }
                //       return _messageItem(list[index]);
                //     },
                //   )
                // : Container(),
                // viewModel.recordIndex == 3
                //     ?
                // ElevatedButton(
                //     onPressed: () {
                //       // final result = Navigator.push(
                //       Navigator.push(
                //         context,
                //         MaterialPageRoute<ReportModel>(
                //           builder: (context) => CustomPage(),
                //         ),
                //       ).then((value) => {
                //             viewModel.loadCustomPeriod(),
                //           });
                //       // if (result != null) {
                //       //   print('カスタムされた期間で読み込む');
                //       //   viewModel.loadCustomPeriod();
                //       // }
                //     },
                //     child: Text('期間を設定する'),
                //   )
                // : Container(),
              ],
            ),
          ),
          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: Padding(
          //     padding: const EdgeInsets.only(bottom: 8),
          //     child: ElevatedButton(
          //       child: Text(
          //         '期間を設定する',
          //         style: TextStyle(
          //           fontSize: 20,
          //           fontWeight: FontWeight.bold,
          //         ),
          //       ),
          //       onPressed: () {
          //         Navigator.push(
          //           context,
          //           MaterialPageRoute<ReportModel>(
          //             builder: (context) => CustomPage(),
          //           ),
          //         ).then((value) => {
          //               viewModel.recordIndex = 3,
          //               viewModel.loadCustomPeriod(),
          //             });
          //       },
          //       style: ElevatedButton.styleFrom(
          //         padding: EdgeInsets.only(
          //           top: 8,
          //           bottom: 8,
          //         ),
          //         elevation: 0,
          //         minimumSize: Size(300, 50),
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(36),
          //         ),
          //       ),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }

  Widget _messageItem(
    RecordModel record,
    BuildContext context,
    ReportViewModel viewModel,
  ) {
    return Container(
      decoration: new BoxDecoration(
          border:
              new Border(bottom: BorderSide(width: 1.0, color: Colors.grey))),
      child: ListTile(
        dense: true,
        leading: Icon(
          Icons.arrow_back_ios,
          size: 32,
          color: Colors.green,
        ),
        title: Text(
          record.category,
          style: TextStyle(color: Colors.black, fontSize: 18.0),
        ),
        subtitle: Text(
          '${record.expenditureDate.year}年${record.expenditureDate.month}月${record.expenditureDate.day}日',
          style: TextStyle(color: Colors.grey.shade800, fontSize: 12.0),
        ),
        trailing: Text(
          '${record.money}円',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute<int>(
              builder: (context) => EditPage(
                record: record,
                index: viewModel.recordIndex,
              ),
            ),
          ).then((value) async {
            // print('RecordIndex: ${value}');
            if (value == 0) {
              await viewModel.updateWeekRecords();
              await viewModel.updateWeekReports();
            } else if (value == 1) {
              await viewModel.updateMonthRecords();
              await viewModel.updateMonthReports();
            } else if (value == 2) {
              await viewModel.updateThreeMonthRecords();
              await viewModel.updateThreeMonthReports();
            } else {
              await viewModel.updateCustomRecords();
              await viewModel.updateCustomReports();
            }
            // viewModel.load();
            // viewModel.recordIndex = 3,
            // viewModel.loadCustomPeriod(),
          });
          // print("onTap called.");
        }, // タップ
        onLongPress: () {
          // print("onLongTap called.");
        }, // 長押し
      ),
    );
  }

  Widget changeChart(
    ReportViewModel viewModel,
    // int index,
    // List<ReportModel> reports,
    // Future<void> getMonthRecords,
  ) {
    // Widget changeChart(ReportViewModel viewModel) {
    // print(reports);
    if (viewModel.recordIndex == 0) {
      // if (index == 0) {
      // print('切り替え時$index');
      // viewModel.load();
      final reports = viewModel.weekReports;
      // final reportList = reports
      //     .map((report) => ReportModel(
      //           date: report.date,
      //           expense: report.expense,
      // date: report.expenditureDate,
      // expense: report.money.toDouble(),
      // ))
      // .toList();
      // print('テルミ');
      // final test = reportList.map((report) {
      //   print('春');
      //   final currentIndex = reportList.indexOf(report);
      //   print(reportList.indexOf(report));
      //   print(report.date);
      //   if (currentIndex == 0) {
      //     return report;
      //   } else if (reportList[currentIndex - 1].date != report.date) {
      //     return report;
      //   } else {
      //     final newReport = ReportModel(
      //       date: report.date,
      //       expense: report.expense + reportList[currentIndex - 1].expense,
      //     );
      //     return newReport;
      //   }
      // }).toList();
      // print(test);
      // records.sort((a, b) {
      //   if (a.expenditureDate == b.expenditureDate) {
      //     print('Aやで${a.expenditureDate}');
      //     print('Bやで${b.expenditureDate}');
      //     return 1;
      //   } else {
      //     return 1;
      //   }
      // });
      // records.reduce((value, element) {
      //   print('${value.expenditureDate} + ${element.expenditureDate}');
      //   return RecordModel(
      //     money: 100,
      //     category: 'caream',
      //     expenditureDate: DateTime.now(),
      //     createdAt: DateTime.now(),
      //   );
      // });
      // print(reportList[0].expense);
      // print(reportList[0].date);
      // print(reportList.map((report) => report));
      return reports.isNotEmpty
          ? Container(
              height: 250,
              child: charts.TimeSeriesChart(
                _createReportModel(reports),
              ),
              // child: changeChart(viewModel),
              // charts.TimeSeriesChart(
              //   _createReportModel(viewModel.reports),
              //   // _createReportModel(reportList),
              // ),
            )
          : NoDataAlert();
      // return charts.TimeSeriesChart(
      //   _createReportModel(reportList),
      // );
    } else if (viewModel.recordIndex == 1) {
      // } else if (index == 1) {
      // print('切り替え時${index}');
      // print('切り替え時${viewModel.recordIndex}');
      // viewModel.fetchMonthRecords();
      // viewModel.loadMonth();
      // print('一ヶ月のレポートのデータ取得したよ〜〜〜${viewModel.monthReports}');
      // return charts.TimeSeriesChart(
      //   _createReportModel(viewModel.monthReports),
      // _createReportModel(reports),
      // );
      final reports = viewModel.monthReports;
      return reports.isNotEmpty
          ? Container(
              height: 250,
              child: charts.TimeSeriesChart(
                _createReportModel(reports),
              ),
              // child: changeChart(viewModel),
              // charts.TimeSeriesChart(
              //   _createReportModel(viewModel.reports),
              //   // _createReportModel(reportList),
              // ),
            )
          : NoDataAlert();
    } else if (viewModel.recordIndex == 2) {
      // } else if (index == 2) {
      // print('切り替え時${index}');
      // print('切り替え時${viewModel.recordIndex}');
      // print('3ヶ月のレポートのデータ取得したよ〜〜〜${viewModel.threeMonthReports}');
      final reports = viewModel.threeMonthReports;
      // return charts.TimeSeriesChart(
      //   _createReportModel(viewModel.threeMonthReports),
      // );
      return reports.isNotEmpty
          ? Container(
              height: 250,
              child: charts.TimeSeriesChart(
                _createReportModel(reports),
              ),
              // child: changeChart(viewModel),
              // charts.TimeSeriesChart(
              //   _createReportModel(viewModel.reports),
              //   // _createReportModel(reportList),
              // ),
            )
          : NoDataAlert();
    } else {
      // print('切り替え時${index}');
      // print('切り替え時${viewModel.recordIndex}');
      // print('カスタムのレポートのデータ取得したよ〜〜〜${viewModel.customReports}');
      final reports = viewModel.customReports;
      return reports.isNotEmpty
          ? Container(
              height: 250,
              child: charts.TimeSeriesChart(
                _createReportModel(reports),
              ),
              // child: changeChart(viewModel),
              // charts.TimeSeriesChart(
              //   _createReportModel(viewModel.reports),
              //   // _createReportModel(reportList),
              // ),
            )
          : NoDataAlert();
      // return charts.TimeSeriesChart(
      //   _createReportModel(viewModel.customReports),
      // );
    }
  }

  Widget changeRecord(
    ReportViewModel viewModel,
  ) {
    if (viewModel.recordIndex == 0) {
      final records = viewModel.weekRecords;
      return records.isNotEmpty
          ? ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: records.length,
              itemBuilder: (BuildContext context, int index) {
                // if (index >= list.length) {
                //   list.addAll([
                //     "メッセージ",
                //     "メッセージ",
                //     "メッセージ",
                //     "メッセージ",
                //   ]);
                // }
                return _messageItem(
                  records[index],
                  context,
                  viewModel,
                );
              },
            )
          : Container();
    } else if (viewModel.recordIndex == 1) {
      final records = viewModel.monthRecords;
      return records.isNotEmpty
          ? ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: records.length,
              itemBuilder: (BuildContext context, int index) {
                // if (index >= list.length) {
                //   list.addAll([
                //     "メッセージ",
                //     "メッセージ",
                //     "メッセージ",
                //     "メッセージ",
                //   ]);
                // }
                return _messageItem(
                  records[index],
                  context,
                  viewModel,
                );
              },
            )
          : Container();
    } else if (viewModel.recordIndex == 2) {
      final records = viewModel.threeMonthRecords;
      return records.isNotEmpty
          ? ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: records.length,
              itemBuilder: (BuildContext context, int index) {
                // if (index >= list.length) {
                //   list.addAll([
                //     "メッセージ",
                //     "メッセージ",
                //     "メッセージ",
                //     "メッセージ",
                //   ]);
                // }
                return _messageItem(
                  records[index],
                  context,
                  viewModel,
                );
              },
            )
          : Container();
    } else {
      final records = viewModel.customRecords;
      return records.isNotEmpty
          ? ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: records.length,
              itemBuilder: (BuildContext context, int index) {
                // if (index >= list.length) {
                //   list.addAll([
                //     "メッセージ",
                //     "メッセージ",
                //     "メッセージ",
                //     "メッセージ",
                //   ]);
                // }
                return _messageItem(
                  records[index],
                  context,
                  viewModel,
                );
              },
            )
          : Container();
    }
    // return Text('テスト');
  }

//ReportModelのリストを作成。好きな日付と体重入れよう
  final weightList = <ReportModel>[
    ReportModel(
      date: DateTime(2020, 10, 1),
      expense: 20,
    ),
    // ReportModel(DateTime(2020, 10, 2), 50),
    // ReportModel(DateTime(2020, 10, 3), 53),
    // ReportModel(DateTime(2020, 10, 4), 40),
    // ReportModel(DateTime(2020, 10, 5), 20),
    // ReportModel(DateTime(2020, 10, 6), 10),
    // ReportModel(DateTime(2020, 10, 7), 20),
    // ReportModel(DateTime(2020, 10, 8), 50),
    // ReportModel(DateTime(2020, 10, 9), 53),
    // ReportModel(DateTime(2020, 10, 10), 40),
    // ReportModel(DateTime(2020, 10, 11), 20),
    // ReportModel(DateTime(2020, 10, 12), 10),
    // ReportModel(DateTime(2020, 10, 13), 40),
    // ReportModel(DateTime(2020, 10, 14), 20),
    // ReportModel(DateTime(2020, 10, 15), 10),
    // ReportModel(DateTime(2020, 10, 16), 10),
    // ReportModel(DateTime(2020, 10, 17), 40),
    // ReportModel(DateTime(2020, 10, 18), 20),
    // ReportModel(DateTime(2020, 10, 19), 10),
    // ReportModel(DateTime(2020, 10, 20), 40),
    // ReportModel(DateTime(2020, 10, 21), 20),
    // ReportModel(DateTime(2020, 10, 22), 10),
    // ReportModel(DateTime(2020, 10, 23), 40),
    // ReportModel(DateTime(2020, 10, 24), 20),
    // ReportModel(DateTime(2020, 10, 25), 10),
    // ReportModel(DateTime(2020, 10, 26), 10),
    // ReportModel(DateTime(2020, 10, 27), 40),
    // ReportModel(DateTime(2020, 10, 28), 20),
    // ReportModel(DateTime(2020, 10, 29), 10),
    // ReportModel(DateTime(2020, 10, 30), 50),
    // ReportModel(DateTime(2020, 10, 31), 30),
  ];

//上のリストからグラフに表示させるデータを生成
  List<charts.Series<ReportModel, DateTime>> _createReportModel(
    List<ReportModel> weightList,
  ) {
    return [
      charts.Series<ReportModel, DateTime>(
        id: 'Muscles',
        data: weightList,
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (ReportModel reportModel, _) => reportModel.date,
        measureFn: (ReportModel reportModel, _) => reportModel.expense,
      )
    ];
  }
}
