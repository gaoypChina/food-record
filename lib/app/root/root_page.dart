import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_record/app/home/home_page.dart';
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
    final _views = [
      HomePage(),
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
        selectedItemColor: Color.fromARGB(255, 27, 152, 40),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'ホーム',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inbox),
            label: '過去の記録',
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
