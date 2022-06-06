import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:food_record/app/edit/date_picker.dart';
import 'package:food_record/app/edit/edit_view_model.dart';
import 'package:food_record/app/settings/settings_view_model.dart';

class SettingTile extends StatelessWidget {
  const SettingTile({
    Key? key,
    required this.viewModel,
    required this.title,
    required this.icon,
  }) : super(key: key);

  final String title;
  final SettingsViewModel viewModel;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        print('Tileをタップしたよ〜〜〜');
        notify('食費管理', 'おはようございます！朝の食費を記録しましょう！！！');
      },
      leading: icon,
      tileColor: Colors.white,
      title: Text(
        title,
      ),
      trailing: Icon(
        Icons.arrow_back_ios,
        textDirection: TextDirection.rtl,
      ),
    );
  }

  Future<void> notify(String changeMessage, String timeMessage) {
    final flnp = FlutterLocalNotificationsPlugin();
    // print(flnp);
    return flnp
        .initialize(
          InitializationSettings(
            iOS: IOSInitializationSettings(),
          ),
        )
        .then((_) =>
            flnp.show(0, changeMessage, timeMessage, NotificationDetails()));
  }
}
