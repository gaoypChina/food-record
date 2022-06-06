import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_record/app/home/date_picker.dart';
import 'package:food_record/app/home/home_page.dart';
import 'package:food_record/app/notification/notification_page.dart';
import 'package:food_record/app/report/report_page.dart';
import 'package:food_record/app/report/report_view_model.dart';
import 'package:food_record/app/root/root_view_model.dart';
import 'package:food_record/app/root/tab_controller.dart';
import 'package:food_record/app/settings/settings_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:food_record/app/root/root_method.dart';

class RootPage extends ConsumerStatefulWidget {
  const RootPage({
    Key? key,
    // required this.analytics,
  }) : super(key: key);
  RootPageState createState() => RootPageState();
}

class RootPageState extends ConsumerState<RootPage> {
  final RootMethod _rootMethod = RootMethod();

  @override
  void initState() {
    super.initState();
    print('初期きどう');
    // TODO: SharedPreferenceの値次第で初期起動かどうか判断する
    // final firstLoading = getFirstLoading();
    _rootMethod.getFirstLoading().then((firstLoading) {
      if (firstLoading != true) {
        print('初期テスト');
        return;
      } else {
        print('テスト春');
        Future.delayed(Duration.zero, () {
          _openNotificationDialog();
        });
      }
    });
  }

  void _openNotificationDialog() {
    showCupertinoDialog<String>(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Text('通知設定'),
            ),
            content: Text('食費の入力忘れ防止のために、通知を送信してもよろしいでしょうか？'),
            actions: [
              TextButton(
                onPressed: () {
                  // viewModel.foodPriceController.clear();
                  // viewModel.updateExpenditureDate();
                  Navigator.pop(context);
                },
                child: Text(
                  '後で設定する',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.blue,
                  ),
                ),
              ),
              TextButton(
                onPressed: () async {
                  print('OK');
                  await _rootMethod.reserveLocalNotification();
                  // await _rootMethod.setIsFirstLoading();
                  Navigator.pop(context);
                },
                child: Text(
                  'OK',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
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
      SettingsPage(),
      // NotificationPage(),
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
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.notifications),
          //   label: '通知',
          // ),
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
