import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_record/app/custom/custom_view_model.dart';
import 'package:food_record/app/edit/edit_view_model.dart';
import 'package:food_record/app/report/report_model.dart';
import 'package:food_record/app/settings/settings_view_model.dart';
import 'package:app_settings/app_settings.dart';
import 'package:permission_handler/permission_handler.dart';

class ToggleTile extends StatelessWidget {
  const ToggleTile({
    Key? key,
    required this.viewModel,
    required this.period,
    required this.context,
    // required this.index,
  }) : super(key: key);

  final SettingsViewModel viewModel;
  final String period;
  final BuildContext context;
  // final int index;

  void _openNotificationDialog() {
    showCupertinoDialog<String>(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Text('通知設定'),
            ),
            content: Text('設定アプリから通知を有効にしてください'),
            actions: [
              TextButton(
                onPressed: () {
                  // viewModel.foodPriceController.clear();
                  // viewModel.updateExpenditureDate();
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
                  // print('開く');
                  // await _rootMethod.reserveLocalNotification();
                  // await _rootMethod.setIsFirstLoading();
                  // await openAppSettings();
                  await AppSettings.openNotificationSettings();
                  Navigator.pop(context);
                },
                child: Text(
                  '開く',
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
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade300,
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
            // viewModel.selectedPeriodIndex == index
            //     ? Icon(Icons.check_box)
            //     :
            CupertinoSwitch(
              activeColor: Colors.blue,
              value: viewModel.canBeNotified,
              onChanged: (isValue) async {
                // print('通知: $isValue');
                // viewModel.toggleSwitch();
                if (viewModel.canBeNotified) {
                  await viewModel.notificationTurnOff();
                } else {
                  // TODO: PermissionHandlerで通知が許可されているか真偽値で返す。
                  await viewModel.getPermission().then((value) async {
                    // print('許可の真偽値: $value');
                    if (value) {
                      await viewModel.notificationTurnOn();
                    } else {
                      _openNotificationDialog();
                    }
                  });
                }
                // print(viewModel.canBeNotified);
              },
            ),
            // Icon(Icons.check_box_outline_blank),
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
          // viewModel.setPeriodIndex(index);
          // print('Indexを切り替えるよ');
        },
      ),
    );
  }
}
