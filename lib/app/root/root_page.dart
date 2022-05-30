import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_record/app/home/home_page.dart';
import 'package:food_record/app/report/report_page.dart';
import 'package:food_record/app/report/report_view_model.dart';
import 'package:food_record/app/root/tab_controller.dart';

class RootPage extends ConsumerWidget {
  const RootPage({
    Key? key,
    // required this.analytics,
  }) : super(key: key);

  // final FirebaseAnalytics analytics;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabType = ref.watch(tabTypeProvider);
    final tabTypeFunc = ref.watch(tabTypeProvider.notifier);
    // final report = ref.watch(reportViewModelProvider);
    // final reports = report.reports;
    // print('Reportの値はこれだよ〜〜〜$reports');
    final _views = [
      HomePage(),
      ReportPage(
          // report: report,
          ),
    ];
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: _views[tabType.index]),
          // Container(
          //   color: Colors.white,
          //   height: 48.0,
          //   width: double.infinity,
          //   child: AdWidget(ad: myBanner),
          // ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        // unselectedIconTheme: IconThemeData(
        //   color: Colors.grey.shade400,
        // ),
        // selectedIconTheme: IconThemeData(
        //   color: Color.fromARGB(255, 27, 152, 40),
        // ),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color.fromARGB(255, 27, 152, 40),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.edit),
            label: '食費記録',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assessment_outlined),
            label: 'レポート',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: '通知',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: '設定',
          ),
        ],
        onTap: (int selectIndex) {
          tabTypeFunc.state = TabType.values[selectIndex];
        },
        currentIndex: tabType.index,
      ),
    );
  }
}
