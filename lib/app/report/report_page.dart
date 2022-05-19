import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_record/app/record/record_model.dart';
import 'package:food_record/app/report/report_model.dart';
import 'package:food_record/app/report/report_view_model.dart';

///日付と体重を持つクラスを作成
// class ReportModel {
//   final DateTime date;
//   final double weight;

//   ReportModel(this.date, this.weight);
// }

class ReportPage extends ConsumerWidget {
  ReportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(reportViewModelProvider);
    final reports = viewModel.reports;
    final index = viewModel.recordIndex;

    return Scaffold(
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
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(reports.toString()),
            CupertinoSlidingSegmentedControl<int>(
              children: {
                0: Text('1週間'),
                1: Text('1ヶ月'),
                2: Text('6ヶ月'),
                3: Text('カスタム')
              },
              groupValue: index,
              onValueChanged: (index) {
                print(index);
                viewModel.updateIndex(int.parse(index.toString()));
              },
            ),
            Container(
              height: 250,
              //グラフ表示部分
              // recordIndexの数値を渡して、表示するグラフを変更する
              child: changeChart(index, reports),
            ),
          ],
        ),
      ),
    );
  }

  Widget changeChart(int index, List<ReportModel> reports) {
    print(reports);
    if (index == 0) {
      // print('切り替え時$index');
      final reportList = reports
          .map((report) => ReportModel(
                date: report.date,
                expense: report.expense,
                // date: report.expenditureDate,
                // expense: report.money.toDouble(),
              ))
          .toList();
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
      return charts.TimeSeriesChart(
        _createReportModel(reportList),
      );
    } else if (index == 1) {
      print('切り替え時$index');
      return charts.TimeSeriesChart(
        _createReportModel(weightList),
      );
    } else if (index == 2) {
      print('切り替え時$index');
      return charts.TimeSeriesChart(
        _createReportModel(weightList),
      );
    } else {
      print('切り替え時$index');
      return charts.TimeSeriesChart(
        _createReportModel(weightList),
      );
    }
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
      List<ReportModel> weightList) {
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
