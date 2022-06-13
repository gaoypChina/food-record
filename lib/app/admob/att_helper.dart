import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/material.dart';

class ATTHelper {
  Future<void> attCheck() async {
    final status = await AppTrackingTransparency.trackingAuthorizationStatus;
    //ATTが設定されていない場合実行
    if (status == TrackingStatus.notDetermined) {
      debugPrint('ATT未設定');
      await Future<void>.delayed(const Duration(milliseconds: 200));
      //ダイアログ表示
      await AppTrackingTransparency.requestTrackingAuthorization();
    } else {
      debugPrint('ATT設定済');
    }
  }
}
