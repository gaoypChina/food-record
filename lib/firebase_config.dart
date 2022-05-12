import 'dart:developer';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class DefaultFirebaseConfig {
  FirebaseOptions? get platformOptions {
    if (Platform.isIOS) {
      // iOS and MacOS
      return const FirebaseOptions(
        appId: '1:824269911129:ios:1295575eaea3156cc86d48',
        apiKey: 'AIzaSyACOj1l8ts0vdqCkZUEaXKDbTYfVR17qIw',
        projectId: 'food-record-3783d',
        messagingSenderId: '824269911129',
        iosBundleId: 'com.kasiwa.intervalWalking',
        iosClientId:
            '824269911129-a8br692bjb63ltsgjgopc9jmfu16fbpg.apps.googleusercontent.com',
        storageBucket: 'food-record-3783d.appspot.com',
      );
    } else {
      // Android
      log("Analytics Dart-only initializer doesn't work on Android, please make sure to add the config file.");

      return null;
    }
  }
}
