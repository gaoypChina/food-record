import 'package:app_settings/app_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_record/app/custom/custom_view_model.dart';
import 'package:food_record/app/edit/edit_view_model.dart';
import 'package:food_record/app/report/report_model.dart';
import 'package:food_record/app/settings/settings_view_model.dart';

class SimpleDateTile extends StatelessWidget {
  const SimpleDateTile({
    Key? key,
    required this.viewModel,
    required this.period,
    required this.index,
    required this.context,
    // required this.isChecked,
  }) : super(key: key);

  final SettingsViewModel viewModel;
  final String period;
  final int index;
  final BuildContext context;
  // final bool isChecked;

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
            showCheckBox(index, viewModel),
          ],
        ),
        onTap: () async {
          if (viewModel.canBeNotified) {
            if (index == 0) {
              await viewModel.updateIsMorning();
            } else if (index == 1) {
              await viewModel.updateIsNoon();
            } else if (index == 2) {
              await viewModel.updateIsNight();
            }
          } else {
            await viewModel.getPermission().then((value) async {
              // print('許可の真偽値: $value');
              if (value) {
                await viewModel.notificationToggleOn(index);
                // await viewModel.notificationTurnOn();
                // TODO: indexに応じて予約処理を記述
              } else {
                _openNotificationDialog();
              }
            });
          }
          // viewModel.isMorning = false;
          // viewModel.setPeriodIndex(index);
          // print(viewModel.isMorning);
          // print(viewModel.isNoon);
          // print(viewModel.isNight);
          // print('Indexを切り替えるよ');
        },
      ),
    );
  }
}

StatelessWidget showCheckBox(
  int index,
  SettingsViewModel viewModel,
) {
  if (index == 0) {
    return MorningCheckBox(viewModel: viewModel);
  } else if (index == 1) {
    return NoonCheckBox(viewModel: viewModel);
  } else {
    return NightCheckBox(viewModel: viewModel);
  }
}

class MorningCheckBox extends StatelessWidget {
  const MorningCheckBox({
    Key? key,
    required this.viewModel,
    // required this.isChecked,
  }) : super(key: key);

  final SettingsViewModel viewModel;
  // final bool isChecked;

  @override
  Widget build(BuildContext context) {
    return Container(
      // child: isChecked
      child: viewModel.isMorning
          ? Icon(
              Icons.check_box,
              color: Colors.blue,
            )
          : Icon(
              Icons.check_box_outline_blank,
              color: Colors.blue,
            ),
    );
  }
}

class NoonCheckBox extends StatelessWidget {
  const NoonCheckBox({
    Key? key,
    required this.viewModel,
    // required this.isChecked,
  }) : super(key: key);

  final SettingsViewModel viewModel;
  // final bool isChecked;

  @override
  Widget build(BuildContext context) {
    return Container(
      // child: isChecked
      child: viewModel.isNoon
          ? Icon(
              Icons.check_box,
              color: Colors.blue,
            )
          : Icon(
              Icons.check_box_outline_blank,
              color: Colors.blue,
            ),
    );
  }
}

class NightCheckBox extends StatelessWidget {
  const NightCheckBox({
    Key? key,
    required this.viewModel,
    // required this.isChecked,
  }) : super(key: key);

  final SettingsViewModel viewModel;
  // final bool isChecked;

  @override
  Widget build(BuildContext context) {
    return Container(
      // child: isChecked
      child: viewModel.isNight
          ? Icon(
              Icons.check_box,
              color: Colors.blue,
            )
          : Icon(
              Icons.check_box_outline_blank,
              color: Colors.blue,
            ),
    );
  }
}
