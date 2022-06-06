import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_record/app/record/record_model.dart';
import 'package:food_record/app/record/record_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

final settingsViewModelProvider = ChangeNotifierProvider((ref) {
  return SettingsViewModel(
    ref.watch(recordServiceProvider),
  );
});

class SettingsViewModel extends ChangeNotifier {
  SettingsViewModel(this._recordService) {
    print('設定画面ロードするよ＝＝＝');
    load();
  }
  final RecordService _recordService;
  bool canBeNotified = false;
  bool isMorning = false;
  bool isNoon = false;
  bool isNight = false;

  static const canBeMorningPrefsKey = 'canBeMorning';
  static const canBeNoonPrefsKey = 'canBeNoon';
  static const canBeNightPrefsKey = 'canBeNight';
  static const canBeNotifiedPrefsKey = 'canBeNotified';

  // static const isFirstLoadingPrefsKey = 'isFirstLoading';

  FlutterLocalNotificationsPlugin flnp = FlutterLocalNotificationsPlugin();

  Future<void> load() async {
    final isEnabletoNotify = await getPermission();
    if (isEnabletoNotify == true) {
      final canBeMorning = await getCanBeMorning();
      final canBeNoon = await getCanBeNoon();
      final canBeNight = await getCanBeNight();
      if (canBeNoon.toString() != 'null' &&
          canBeMorning.toString() != 'null' &&
          canBeNight.toString() != 'null' &&
          canBeNoon is bool &&
          canBeMorning is bool &&
          canBeNight is bool) {
        isMorning = canBeMorning;
        isNoon = canBeNoon;
        isNight = canBeNight;
        print(
            '取得された後ViewModelの真偽値はどうなった？?朝: $isMorning. 昼: $isNoon. 夜: $isNight.');
        // TODO: PermissionHandlerでNotificationが可能かどうか判断するメソッドを呼び出す。
        // await _getPermission();
        final permission = await _getLocalNotification();
        if (permission != true) {
          canBeNotified = false;
        } else {
          canBeNotified = true;
        }
      }
    } else {
      isMorning = false;
      isNoon = false;
      isNight = false;
      canBeNotified = false;
    }
  }

  Future<bool?> getCanBeMorning() async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstLoading = prefs.getBool(canBeMorningPrefsKey);
    return isFirstLoading;
  }

  Future<bool?> getCanBeNoon() async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstLoading = prefs.getBool(canBeNoonPrefsKey);
    return isFirstLoading;
  }

  Future<bool?> getCanBeNight() async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstLoading = prefs.getBool(canBeNightPrefsKey);
    return isFirstLoading;
  }

  Future<bool?> _getLocalNotification() async {
    final prefs = await SharedPreferences.getInstance();
    final isNotified = prefs.getBool(canBeNotifiedPrefsKey);
    return isNotified;
  }

  Future<void> updateIsMorning() async {
    if (isMorning) {
      print('通知予約キャンセル');
      await flnp.cancel(1);
    } else {
      await _scheduleDailyMorningNotification();
    }
    isMorning = !isMorning;
    await _setCanBeMorning(isMorning);
    notifyListeners();
  }

  Future<void> updateIsNoon() async {
    if (isNoon) {
      print('通知予約キャンセル');
      await flnp.cancel(2);
    } else {
      await _scheduleDailyNoonNotification();
    }
    isNoon = !isNoon;
    await _setCanBeNoon(isNoon);
    notifyListeners();
  }

  Future<void> updateIsNight() async {
    if (isNight) {
      print('通知予約キャンセル');
      await flnp.cancel(3);
    } else {
      await _scheduleDailyNightNotification();
    }
    isNight = !isNight;
    await _setCanBeNight(isNight);
    notifyListeners();
  }

  Future<void> _setCanBeMorning(bool canbeCalled) async {
    final prefs = await SharedPreferences.getInstance();
    print('朝通知するよ');
    await prefs.setBool(canBeMorningPrefsKey, canbeCalled);
  }

  Future<void> _setCanBeNoon(bool canbeCalled) async {
    final prefs = await SharedPreferences.getInstance();
    print('昼通知するよ');
    await prefs.setBool(canBeNoonPrefsKey, canbeCalled);
  }

  Future<void> _setCanBeNight(bool canbeCalled) async {
    final prefs = await SharedPreferences.getInstance();
    print('夜通知するよ');
    await prefs.setBool(canBeNightPrefsKey, canbeCalled);
  }

  Future<void> _setLocalNotification(bool canbeCalled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(canBeNotifiedPrefsKey, canbeCalled);
  }

  Future<bool> getPermission() async {
    // permission_handler で通知に対する許可状態を把握
    var statusForNotificationO = await Permission.notification.status;

    print("statusForNotificationO: $statusForNotificationO");

    if (statusForNotificationO != PermissionStatus.granted) {
      // 許可されていなかったら、ここで設定変更してもらうよう、促すメッセージを出す
      print('通知が許可されていません！');
      canBeNotified = false;
      return false;
      // TODO: 設定ページに飛ばすダイアログを出す。
    }
    canBeNotified = true;
    return true;
  }

  // Future<void> toggleSwitch() async {
  //   if (canBeNotified) {
  //     await notificationTurnOff();
  //   } else {
  //     await notificationTurnOn();
  //   }
  // }

  Future<void> notificationToggleOn(int index) async {
    canBeNotified = true;
    await _setLocalNotification(true);

    // TODO: indexに値に応じてstateを更新
    if (index == 0) {
      isMorning = true;
      await _setCanBeMorning(true);
      await _scheduleDailyMorningNotification();
    } else if (index == 1) {
      isNoon = true;
      await _setCanBeNoon(true);
      await _scheduleDailyNoonNotification();
    } else {
      isNight = true;
      await _setCanBeNight(true);
      await _scheduleDailyNightNotification();
    }
    notifyListeners();
  }

  // TODO: toggleをONにした時に呼び出す
  Future<void> notificationTurnOn() async {
    // TODO: A.PermissionHandlerの通知の設定を許可する
    // await _getPermission();

    canBeNotified = true;
    await _setLocalNotification(true);

    // TODO: B.morning, lunch, nightをtrueに。
    isMorning = true;
    isNoon = true;
    isNight = true;
    await _setCanBeMorning(true);
    await _setCanBeNoon(true);
    await _setCanBeNight(true);

    // TODO: C. 通知の予約処理(朝・昼・夜)
    await _scheduleDailyMorningNotification();
    await _scheduleDailyNoonNotification();
    await _scheduleDailyNightNotification();

    notifyListeners();
  }

  // TODO: toggleをOFFにした時に呼び出す
  Future<void> notificationTurnOff() async {
    canBeNotified = false;
    await _setLocalNotification(false);

    // TODO:A. morning, lunch, nightをfalseに。
    isMorning = false;
    isNoon = false;
    isNight = false;
    await _setCanBeMorning(false);
    await _setCanBeNoon(false);
    await _setCanBeNight(false);

    // TODO: B. 通知を全てキャンセルにする。
    print('通知を全てキャンセル');
    await flnp.cancelAll();
    notifyListeners();
  }

  Future<void> _scheduleDailyMorningNotification() async {
    // await removeNotification();
    // await getNotificationCount();
    await flnp.zonedSchedule(
      1,
      '食費管理',
      'おはようございます！朝の記録をつけましょう！！！🍙',
      await _nextInstanceOfTenAM(8),
      NotificationDetails(),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> _scheduleDailyNoonNotification() async {
    // await removeNotification();
    // await getNotificationCount();
    await flnp.zonedSchedule(
      2,
      '食費管理',
      'こんにちは！昼の記録をつけましょう！！！🍜',
      await _nextInstanceOfTenAM(13),
      NotificationDetails(),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> _scheduleDailyNightNotification() async {
    // await removeNotification();
    // await getNotificationCount();
    await flnp.zonedSchedule(
      3,
      '食費管理',
      '今日も1日お疲れ様でした！ 夜の記録を忘れないように...！！！🍽',
      await _nextInstanceOfTenAM(20),
      NotificationDetails(),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<tz.TZDateTime> _nextInstanceOfTenAM(int hour) async {
    tz.initializeTimeZones();
    // final location = tz.getLocation(timeZoneName);
    final japan = tz.getLocation("Asia/Tokyo");
    // print(timeZoneName);
    print(japan);
    tz.setLocalLocation(japan);
    print(tz.local);
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    // final locations = tz.timeZoneDatabase.locations;
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
    );
    print(now);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    print(scheduledDate);
    return scheduledDate;
  }
}
