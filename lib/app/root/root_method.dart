import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class RootMethod {
  static const canBeNotifiedPrefsKey = 'canBeNotified';
  static const isFirstLoadingPrefsKey = 'isFirstLoading';
  static const canBeMorningPrefsKey = 'canBeMorning';
  static const canBeNoonPrefsKey = 'canBeNoon';
  static const canBeNightPrefsKey = 'canBeNight';

  FlutterLocalNotificationsPlugin flnp = FlutterLocalNotificationsPlugin();

  Future<void> _initializeNotification() async {
    // print('Flutter Local Notificationの初期化');
    await flnp.initialize(
      const InitializationSettings(
        iOS: IOSInitializationSettings(),
      ),
    );
  }

  Future<bool?> getFirstLoading() async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstLoading = prefs.getBool(isFirstLoadingPrefsKey);
    // print(isFirstLoading);
    if (isFirstLoading == null) {
      // print('object');
      return true;
    }
    // print('初期起動じゃないよ〜〜〜');
    return isFirstLoading;
  }

  // OKを押した場合の処理
  Future<void> reserveLocalNotification() async {
    // TODO: 1.SharedPreferenceのisFirstLoadingをfalseにする。
    await _setIsFirstLoading();

    // TODO: FLNPの初期化
    await _initializeNotification();
    // TODO: 2.朝、昼、夜の通知予約をする
    await _scheduleDailyMorningNotification();
    await _scheduleDailyNoonNotification();
    await _scheduleDailyNightNotification();

    // 3.SharedPreferenceのcanBeNotifiedをtrueにする
    // ↓をコメントにした理由はPermissionHandlerで代用できるからである。
    await _setLocalNotification(true);

    // TODO: 4.SharedPreferenceのmorning, lunch, nightをtrueにする。
    await _setCanBeMorning(true);
    await _setCanBeNoon(true);
    await _setCanBeNight(true);
  }

  // 後で行うを押した場合の処理
  Future<void> doItLater() async {
    // TODO 1.SharedPreferenceのisFirstLoadingをfalseにする。
    await _setIsFirstLoading();

    // TODO 2.SharedPreferenceのcanBeNotifiedをfalseにする
    // ↓をコメントにした理由はPermissionHandlerで代用できるからである。
    await _setLocalNotification(false);

    // TODO 3.SharedPreferenceのmorning, lunch, nightをfalseにする。
    await _setCanBeMorning(false);
    await _setCanBeNoon(false);
    await _setCanBeNight(false);
  }

  Future<void> _setIsFirstLoading() async {
    final prefs = await SharedPreferences.getInstance();
    // print('初期起動後falseにするよ〜〜〜');
    await prefs.setBool(isFirstLoadingPrefsKey, false);
    // TODO: 朝、昼、夜の通知予約処理を呼び出す
    // await _setLocalNotification();
  }

  Future<void> _setCanBeMorning(bool canbeCalled) async {
    final prefs = await SharedPreferences.getInstance();
    // print('朝通知するよ');
    await prefs.setBool(canBeMorningPrefsKey, canbeCalled);
  }

  Future<void> _setCanBeNoon(bool canbeCalled) async {
    final prefs = await SharedPreferences.getInstance();
    // print('昼通知するよ');
    await prefs.setBool(canBeNoonPrefsKey, canbeCalled);
  }

  Future<void> _setCanBeNight(bool canbeCalled) async {
    final prefs = await SharedPreferences.getInstance();
    // print('夜通知するよ');
    await prefs.setBool(canBeNightPrefsKey, canbeCalled);
  }

  Future<void> _setLocalNotification(bool canbeCalled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(canBeNotifiedPrefsKey, canbeCalled);
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

  // Future<void> removeNotification() async {
  //   await flnp.cancel(1);
  // }

  // Future<void> getNotificationCount() async {
  //   final pendingNotificationRequests =
  //       await flnp.pendingNotificationRequests();
  //   print('予約されている通知数を確認');
  //   print(pendingNotificationRequests.first.id);
  // }

  Future<tz.TZDateTime> _nextInstanceOfTenAM(int hour) async {
    tz.initializeTimeZones();
    // final location = tz.getLocation(timeZoneName);
    final japan = tz.getLocation("Asia/Tokyo");
    // print(timeZoneName);
    // print(japan);
    tz.setLocalLocation(japan);
    // print(tz.local);
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    // final locations = tz.timeZoneDatabase.locations;
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
    );
    // print(now);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    // print(scheduledDate);
    return scheduledDate;
  }
}
