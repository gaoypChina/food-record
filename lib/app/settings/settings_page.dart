import 'package:app_review/app_review.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_record/app/edit/date_picker.dart';
import 'package:food_record/app/edit/edit_view_model.dart';
import 'package:food_record/app/edit/input_dialog.dart';
import 'package:food_record/app/record/record_model.dart';
import 'package:food_record/app/settings/setting_tile.dart';
import 'package:food_record/app/settings/settings_view_model.dart';
import 'package:food_record/app/settings/simple_data_tile.dart';
import 'package:food_record/app/settings/toggle_tile.dart';
// import 'package:share_plus/share_plus.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(settingsViewModelProvider);
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          '設定',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 32,
            ),
            child: ExpansionTile(
              initiallyExpanded: true,
              leading: Icon(
                Icons.notifications,
                color: Colors.blue,
              ),
              backgroundColor: Colors.white,
              collapsedBackgroundColor: Colors.white,
              title: Text(
                '入力忘れ防止の通知',
              ),
              children: [
                ToggleTile(
                  period: '通知オン / オフ',
                  viewModel: viewModel,
                  context: context,
                ),
                SimpleDateTile(
                  period: '朝(8時)',
                  viewModel: viewModel,
                  index: 0,
                  context: context,
                  // isChecked: viewModel.isMorning,
                  // period: period,
                  // index: index,
                ),
                SimpleDateTile(
                  period: '昼(13時)',
                  viewModel: viewModel,
                  index: 1,
                  context: context,
                  // isChecked: viewModel.isNoon,
                  // period: period,
                  // index: index,
                ),
                SimpleDateTile(
                  period: '夜(20時)',
                  viewModel: viewModel,
                  index: 2,
                  context: context,
                  // isChecked: viewModel.isNight,
                  // period: period,
                  // index: index,
                ),
                // SettingTile(
                //   viewModel: viewModel,
                //   title: '入力忘れ防止の通知',
                //   icon: Icon(
                //     Icons.notifications,
                //     color: Colors.blue,
                //   ),
                // ),
              ],
            ),
          ),
          // SettingTile(
          //   viewModel: viewModel,
          //   title: 'このアプリを紹介する',
          //   icon: Icon(
          //     Icons.share_sharp,
          //     color: Colors.blue,
          //   ),
          //   onTap: () {
          //     print('紹介するよ〜〜〜');
          //     Share.share('食費管理');
          //   },
          // ),
          // SettingTile(
          //   viewModel: viewModel,
          //   title: 'このアプリを評価する',
          //   icon: Icon(
          //     Icons.thumb_up_outlined,
          //     color: Colors.blue,
          //   ),
          //   onTap: () async {
          //     await appReview();
          //   },
          // ),
          // Text(
          //     '${record.expenditureDate.year}/${record.expenditureDate.month}/${record.expenditureDate.day}'),
        ],
      ),
    );
  }

  // Future<void> appReview() async {
  //   await AppReview.writeReview.then((value) {
  //     print('レビュー終わったよ〜〜〜$value');
  //   });
  // }
}
